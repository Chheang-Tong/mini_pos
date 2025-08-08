import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController qrController;
  String qrText = '';
  bool isProcessing = false;
  bool isFlashOn = false;
  RxList<String> qrList=<String>[].obs;
  int get qrCount => qrList.length;

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
    qrController = controller;
    qrController.getFlashStatus().then((value) {
      isFlashOn = value ?? false;
    });
    qrController.scannedDataStream.listen((scanData) {
      if (!isProcessing) {
        isProcessing = true;

        qrText = scanData.code!;
        if(qrText.isNotEmpty && !qrList.contains(qrText)){
          qrList.add(qrText);
          debugPrint("Add: $qrText");
        }
        else{
          debugPrint("Duplicate ignore: $qrText");
        }


        debugPrint(qrText);
        debugPrint(qrList.toString());
        // Get.back(result: qrText);

        Future.delayed(Duration(milliseconds: 500),(){
          isProcessing=false;
        });
      }
    });
  }

  void toggleFlash() async {
    await qrController.toggleFlash();
    final flashStatus = await qrController.getFlashStatus();

    isFlashOn = flashStatus ?? false;
    update();
  }

  void clearHistory(){
    qrList.clear();
  }

  @override
  void onClose() {
    animationController.dispose();
    qrController.dispose();
    super.onClose();
  }
}
