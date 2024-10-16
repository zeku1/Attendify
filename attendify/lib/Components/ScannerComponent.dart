import 'dart:typed_data';
import 'package:attendify/API/SessionApi.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerComponent extends StatefulWidget {
  @override
  State<ScannerComponent> createState() => _ScannerComponentState();
}

class _ScannerComponentState extends State<ScannerComponent> {
  SharedPreferences? _prefs;
  bool _isProcessing = false;

  DateTime now = DateTime.now();

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  final SessionApi _sessionApi = SessionApi();

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  // Initialize SharedPreferences and set state once loaded
  void _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = _prefs?.getString('role');
      _schoolId = _prefs?.getString('school_id');
      _id = _prefs?.getInt('student_id');
      _isLoading = false;
    });
  }

  void _joinSession(String code) async {
    if (_id != null) {
      try {
        final timeIn = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

        final result = await _sessionApi.joinSession(int.parse(code), timeIn, );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      } catch (e) {
        print('Error joining session: $e');

        // Call _initializeSharedPreferences to reset state
        _initializeSharedPreferences();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student ID is not available.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _scannerComponent();
  }

  Widget _scannerComponent() {
    return Container(
      child: Builder(
        builder: (context) {
          return MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: true,
            ),
            onDetect: (capture) async {
              if (_isProcessing) return;

              _isProcessing = true;

              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;

              if (image != null && barcodes.isNotEmpty) {
                String barcodeValue = barcodes.first.rawValue ?? "No Barcode Data";

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(barcodeValue),
                      content: Text("Tap to join the session."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _joinSession(barcodeValue);
                            Navigator.of(context).pop(); // Close the dialog after joining
                          },
                          child: Text("Join"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              }

              // Throttle by delaying the next detection.
              await Future.delayed(Duration(seconds: 2)); // Adjust the duration as needed.

              // Reset the flag after delay.
              _isProcessing = false;
            },
          );
        },
      ),
    );
  }
}
