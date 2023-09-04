import 'dart:developer';
import 'dart:io';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQRView extends StatefulWidget {
  const ScanQRView({super.key});

  @override
  State<ScanQRView> createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkBgColor1,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  return (snapshot.data != null) && snapshot.data!
                      ? const Icon(Icons.flash_off)
                      : const Icon(Icons.flash_on);
                },
              ))
        ],
      ),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: PageView(
            onPageChanged: (value) {
              if (value == 1) {}
            },
            children: [
              Column(
                children: [
                  Expanded(flex: 4, child: _buildQrView(context)),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Scan the QR code displayed on the \n phone of your employee',
                      textAlign: TextAlign.center,
                      style: AppTypography.poppinsLight.copyWith(
                        fontSize: 16,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
              qrCode()
            ]),
      ),
    );
  }

  Widget qrCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        QrImageView(
          backgroundColor: AppColors.secondaryColor,
          data: '1234567890',
          version: QrVersions.auto,
          size: 300,
        ),
        const Spacer(),
        Text(
          'EV-7634',
          style: AppTypography.poppinsMedium.copyWith(
            color: AppColors.secondaryColor,
            fontSize: 18,
          ),
        ),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.primaryColor,
          borderRadius: 0,
          borderLength: 50,
          borderWidth: 10,
          cutOutSize: scanArea,
          overlayColor: AppColors.darkBgColor1),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      log(">>>>>>${result!.code}<<<<<<");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
