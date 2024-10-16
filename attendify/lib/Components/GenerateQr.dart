import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter/material.dart';

class GenerateQrComponent extends StatefulWidget {
  final String qrData;
  final double size;

  const GenerateQrComponent({Key? key, required this.qrData, required this.size}) : super(key: key);

  @override
  State<GenerateQrComponent> createState() => _GenerateQrComponentState();
}

class _GenerateQrComponentState extends State<GenerateQrComponent> {
  @override
  Widget build(BuildContext context) {
    return _scannerComponent();
  }

  _scannerComponent() {
    return SizedBox(
      width: widget.size, // Set desired width
      height: widget.size, // Set desired height
      child: PrettyQr(
        data: widget.qrData, // Access qrData through widget.qrData
        size: widget.size, // Controls the size of the QR code
        roundEdges: true, // Example of an additional option
        errorCorrectLevel: QrErrorCorrectLevel.M, // Error correction level
      ),
    );
  }
}