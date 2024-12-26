import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/QR_Scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRResult extends StatelessWidget {
  final String code;

  const QRResult({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return QRScanner();
            }));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "QR Code Result",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QRScanner()));
            }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            QrImageView(
              data: "",
              size: 150,
              version: QrVersions.auto,
            ),
            Text(
              "Scanned QR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Center(
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 125,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade500,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: Text(
                    "Copy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}