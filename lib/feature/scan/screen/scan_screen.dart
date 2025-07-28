import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minipos_app/common/common.dart';
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
    Size size = MediaQuery
        .of(context)
        .size;
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
                  )

              ),
              Positioned(
                bottom: size.height * .2,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Obx(() {
                                return Container(
                                    width:54,
                                    height: 54,
                                    padding: EdgeInsets.only(
                                      top: 8,
                                      bottom: 12,
                                      left: 15, right: 8
                                    ),
                                    // alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: ColorResources.white10,
                                    ),
                                    child: CustomBadge(
                                        icon: SizedBox(
                                          width: 24,height: 24,
                                          child: SvgPicture.asset(
                                            'assets/images/cart.svg',
                                            color: ColorResources.whiteColor,
                                          ),
                                        ),
                                        color: Colors.white,
                                        value: controller.qrCount.toString(),
                                        isShow: controller.qrCount==0?false:true,
                                        tap: () {})
                                );
                              }),
                              Text('Cart', style: mediumLarge.copyWith(color: ColorResources.whiteColor),)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.toggleFlash(),
                          child: Column(
                            children: [
                              Container(
                                width:54,
                                height: 54,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ColorResources.white10,
                                ),
                                child: SvgPicture.asset('assets/images/flash.svg'),
                              ),
                              Text('Light', style: mediumLarge.copyWith(color: ColorResources.whiteColor),)

                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text('Cancel', style: mediumLarge.copyWith(color: ColorResources.whiteColor),)
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
