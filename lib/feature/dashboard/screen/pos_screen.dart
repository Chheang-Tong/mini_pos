import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/core.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});
  @override
  State<Testing> createState() => _TestState();
}

class _TestState extends State<Testing> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String qrText = '';
  bool isProcessing = false;
  bool isFlashOn = false;

  late AnimationController _animationController;
  late Animation<double> _animation;
  static const double cutOutHeight = 148;
  static const double cutOutWidth = 249;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 5, end: cutOutHeight - 5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.getFlashStatus().then((value) {
      setState(() {
        isFlashOn = value ?? false;
      });
    });
    controller.scannedDataStream.listen((scanData) {
      if (!isProcessing) {
        isProcessing = true;
        setState(() {
          qrText = scanData.code!;
        });
        // ignore: avoid_print
        print(qrText);
        Get.back();
      }
    });
  }

  void _toggleFlash() async {
    await controller.toggleFlash();
    final flashStatus = await controller.getFlashStatus();
    setState(() {
      isFlashOn = flashStatus ?? false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlayMargin: EdgeInsetsGeometry.zero,
            // onQRViewCreated: (_) {},
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 16,
              borderLength: 50,
              borderWidth: 2,
              cutOutHeight: cutOutHeight,
              cutOutWidth: cutOutWidth,
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
                      'assets/image/home.svg',
                      color: ColorResources.whiteColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _toggleFlash(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                width: cutOutWidth,
                height: cutOutHeight,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Stack(
                      children: [
                        Positioned(
                          top: _animation.value,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
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
  }
}
