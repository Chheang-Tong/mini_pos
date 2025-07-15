import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minipos_app/feature/feature.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../core/core.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ScanController controller = Get.put(ScanController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ScanController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlayMargin: EdgeInsetsGeometry.zero,
                // onQRViewCreated: (_) {},
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 16,
                  borderLength: 50,
                  borderWidth: 2,
                  cutOutHeight: controller.cutOutHeight,
                  cutOutWidth: controller.cutOutWidth,
                  cutOutBottomOffset: 1,
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Scanning Barcode',
                    style: boldOverLarge.copyWith(
                      color: ColorResources.whiteColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * .3,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorResources.white10,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/home.svg',
                          color: ColorResources.whiteColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toggleFlash(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 12),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorResources.white10,
                        ),
                        child: SvgPicture.asset('assets/image/flash.svg'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: SizedBox(
                    width: controller.cutOutWidth,
                    height: controller.cutOutHeight,
                    child: AnimatedBuilder(
                      animation: controller.animationController,
                      builder: (_, __) {
                        return Stack(
                          children: [
                            Positioned(
                              top: controller.animation.value,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
