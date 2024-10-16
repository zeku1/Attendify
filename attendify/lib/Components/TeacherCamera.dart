import 'dart:typed_data';
import 'package:attendify/API/SessionApi.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherCamera extends StatefulWidget {
  final int? sessionId;

  const TeacherCamera({super.key, this.sessionId});

  @override
  State<TeacherCamera> createState() => _TeacherCameraState();
}

class _TeacherCameraState extends State<TeacherCamera> {
  SharedPreferences? _prefs;
  bool _isProcessing = false;
  bool _isScanning = true; // New variable to control scanning state

  String? _role;
  String? _schoolId;
  int? _id;
  bool _isLoading = true;

  final SessionApi _sessionApi = SessionApi();
  List<String> _scannedData = []; // List to store scanned QR code values

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
      _id = _prefs?.getInt('teacher_id');
      _isLoading = false;
    });
  }

  void _joinSession(String code) async {
    if (_id != null) {
      try {
        DateTime now = DateTime.now(); // Move here to capture the current time
        final timeIn = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

        final result = await _sessionApi.addStudentToSession(widget.sessionId!, code, timeIn);

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      } catch (e) {
        print('Error joining session: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to join session: $e')),
        );
        _initializeSharedPreferences();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student ID is not available.")),
      );
    }
  }

  void _promptSaveData(String barcodeValue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Scanned QR Code"),
          content: Text("Would you like to save this data? ($barcodeValue)"),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data
                _joinSession(barcodeValue);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                // Discard the data
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data discarded.")),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Discard"),
            ),
            TextButton(
              onPressed: () {
                // End scanning
                setState(() {
                  _isScanning = false; // Set scanning state to false
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Scanning has ended.")),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("End Scan"),
            ),
          ],
        );
      },
    );
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
              if (_isProcessing || !_isScanning) return; // Prevent processing if not scanning

              setState(() {
                _isProcessing = true;  // Ensure the UI updates for processing state
              });

              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;

              if (image != null && barcodes.isNotEmpty) {
                String barcodeValue = barcodes.first.rawValue ?? "No Barcode Data";

                print(barcodeValue);
                // Prompt to save, discard, or end scan
                _promptSaveData(barcodeValue);
              }

              // Throttle by delaying the next detection.
              await Future.delayed(Duration(seconds: 2)); // Adjust the duration as needed.

              setState(() {
                _isProcessing = false;  // Reset after delay to allow new scan
              });
            },
          );
        },
      ),
    );
  }
}
