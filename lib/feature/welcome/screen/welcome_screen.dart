import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minipos_app/core/core.dart';
import 'package:minipos_app/feature/feature.dart';

import '../../../common/common.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(WelRepo(apiService: Get.find()));
    final controller = Get.put(WelcomeController(welRepo: Get.find()));
    controller.isLoading = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GetBuilder<WelcomeController>(builder: (controller) {
      return Scaffold(
        backgroundColor: ColorResources.whiteColor,
        body:controller.isLoading
            ? Loading()
            : Column(
          children: [
            Container(
              height: 260,
              width: size.width,
              decoration: BoxDecoration(
                color: Color(0xFFFFDBD7),
                image: DecorationImage(
                  image: AssetImage('assets/images/store.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.space16),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: boldMegaLarge.copyWith(
                      color: ColorResources.primaryColor,
                      fontSize: 36,
                    ),
                  ),
                  Text('Depa Aly', style: boldOverLarge),
                  Text(
                    'April 24, 2025 10:45 AM',
                    style: regularLarge.copyWith(
                      color: ColorResources.dark75,
                    ),
                  ),
                  SizedBox(height: Dimensions.space30),
                  Row(
                    children: [
                      Text("Today's Summary", style: semiBoldMediumLarge),
                    ],
                  ),
                  SizedBox(height: Dimensions.space8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.44,
                        padding: EdgeInsets.all(Dimensions.space16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.largeRadius,
                          ),
                          border: Border.all(
                            width: 1,
                            color: ColorResources.dark10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/money_bag.svg',
                                  color: ColorResources.primaryColor,
                                ),
                                SizedBox(width: Dimensions.space10),
                                Text('Revenue', style: regularLarge),
                              ],
                            ),
                            SizedBox(width: Dimensions.space10),
                            Text('\$${controller.welModel.totalRevenue}'??'Null', style: boldOverLarge),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.navbarScreen,
                            arguments: 2,
                          );
                        },
                        child: Container(
                          width: size.width * 0.44,
                          padding: EdgeInsets.all(Dimensions.space16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.largeRadius,
                            ),
                            border: Border.all(
                              width: 1,
                              color: ColorResources.dark10,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/order.svg',
                                    color: ColorResources.primaryColor,
                                  ),
                                  SizedBox(width: Dimensions.space10),
                                  Text('Orders', style: regularLarge),
                                ],
                              ),
                              SizedBox(width: Dimensions.space10),

                              Text('${controller.welModel.totalOrders}'??'Null', style: boldOverLarge),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteHelper.navbarScreen);
                },
                child: Text(
                  'Get Started',
                  style: semiBoldMediumLarge.copyWith(
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
