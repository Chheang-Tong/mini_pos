import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController qrcontroller;
  String qrText = '';
  bool isProcessing = false;
  bool isFlashOn = false;

  late AnimationController animationController;
  late Animation<double> animation;
   double cutOutHeight = 148;
   double cutOutWidth = 249;
  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 5, end: cutOutHeight - 5).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrcontroller = controller;
    qrcontroller.getFlashStatus().then((value) {
      isFlashOn = value ?? false;
    });
    qrcontroller.scannedDataStream.listen((scanData) {
      if (!isProcessing) {
        isProcessing = true;

        qrText = scanData.code!;

        // ignore: avoid_print
        print(qrText);
        Get.back(result: qrText);
      }
    });
  }

  void toggleFlash() async {
    await qrcontroller.toggleFlash();
    final flashStatus = await qrcontroller.getFlashStatus();

    isFlashOn = flashStatus ?? false;
  }

  @override
  void onClose() {
    animationController.dispose();
    qrcontroller.dispose();
    super.onClose();
  }
}
