import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_result.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScanner extends StatefulWidget {
  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen(){
    isScanCompleted = false;
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileScanner()));
          },
          icon: const Icon(
            Icons.qr_code_scanner,

          ),
        ),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
            icon: Icon(
              Icons.flash_on,
              color: isFlashOn ? Colors.white : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              cameraController.switchCamera();

            },
            icon: Icon(
              Icons.flip_camera_android,
              color: isFrontCamera ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Place the QR code in designated area',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Let the scan do the magic - It starts on its own!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MobileScanner(
                      controller: cameraController,
                      onDetect: (BarcodeCapture barcodeCapture) {
                        if (!isScanCompleted) {
                          setState(() {
                            isScanCompleted = true;
                            String code = barcodeCapture.barcodes.first.rawValue ?? "---"; // Access the raw value of the barcode
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return QRResult(
                                    code: code,
                                  );
                                },
                              ),
                            );
                          });
                        }
                      }
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.black26,
                    borderColor: Colors.teal.shade500,
                    borderRadius: 20,
                    borderStrokeWidth: 5,
                    scanAreaWidth: 250,
                    scanAreaHeight: 250,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "|Scan properly to see result|",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}