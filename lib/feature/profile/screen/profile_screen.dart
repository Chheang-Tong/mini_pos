import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minipos_app/feature/feature.dart';
import 'package:minipos_app/feature/profile/widget/test.dart';
import '/core/core.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.space40),
          padding: EdgeInsets.all(Dimensions.largePadding),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(SearchPage());
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.space12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: ColorResources.dark10,
                        ),
                        color: ColorResources.dark5,
                      ),
                      child: SvgPicture.asset('assets/images/user.svg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.largePadding,
                    ),
                    child: Text('Depa aly', style: boldMegaLarge),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DottedLine(dashColor: ColorResources.dark10),
              ),
              listPf(
                asset: 'assets/images/profile01.svg',
                title: 'Profile',
                ontab: () {
                  Get.toNamed(RouteHelper.profileUpdate);
                },
              ),
              listPf(
                asset: 'assets/images/reset_password.svg',
                title: 'Reset Password',
                ontab: () {
                  Get.toNamed(RouteHelper.resetPWScreen);
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    persistent: true,
                    enableDrag: true,
                    AnimatedPadding(
                      padding: MediaQuery.of(context).viewInsets,
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.decelerate,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.largePadding),
                        height: size.height * 0.5,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: ColorResources.bgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.largeRadius),
                            topRight: Radius.circular(Dimensions.largeRadius),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 6,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: ColorResources.dark45.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.space16),
                            Text('Choose Language', style: boldOverLarge),
                            SizedBox(height: Dimensions.space10),
                            ...List.generate(controller.langItems.length, (
                              index,
                            ) {
                              String title = controller.langItems.keys
                                  .elementAt(index);
                              String assets = controller.langItems.values
                                  .elementAt(index);
                              return GestureDetector(
                                onTap: () => controller.onLang(index),
                                child: GetBuilder<ProfileController>(
                                  builder: (controller) {
                                    return Container(
                                      width: size.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.defaultPadding,
                                        vertical: Dimensions.largePadding,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: Dimensions.defaultMagin,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedLangIndex ==
                                                index
                                            ? ColorResources.primary5
                                            : ColorResources.whiteColor,
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.defaultRadius,
                                        ),
                                        border: Border.all(
                                          color:
                                              controller.selectedLangIndex ==
                                                  index
                                              ? ColorResources.primaryColor
                                              : ColorResources.transparentColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.defaultMagin,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 3.33,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: ColorResources.darkColor,
                                                image: DecorationImage(
                                                  image: AssetImage(assets),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(title, style: boldMediumLarge),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                            Divider(color: ColorResources.dark5),
                            Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // controller.setLanguage();
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.largeMagin,
                                        vertical: Dimensions.space10,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.defaultRadius,
                                        ),
                                        color: ColorResources.dark5,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: semiBoldMediumLarge.copyWith(
                                          color: ColorResources.dark75,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.space10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // controller.setLanguage();
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.largeMagin,
                                        vertical: Dimensions.space10,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.defaultRadius,
                                        ),
                                        color: ColorResources.primaryColor,
                                      ),
                                      child: Text(
                                        'Save',
                                        style: semiBoldMediumLarge.copyWith(
                                          color: ColorResources.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.smallPadding,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/lang.svg'),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.space10),
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.space12,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Languages',
                                  style: semiBoldMediumLarge,
                                ),
                              ),

                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorResources.dark25,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/usa_flag.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.space30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.space12,
                    horizontal: Dimensions.largePadding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                    color: ColorResources.primary10,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/logout.svg',
                        color: ColorResources.primaryColor,
                      ),
                      SizedBox(width: Dimensions.space8),
                      Text(
                        'Logout',
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  listPf({
    required String asset,
    required String title,
    required Function ontab,
  }) {
    return GestureDetector(
      onTap: () => ontab(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.smallPadding),
        child: Row(
          children: [
            SvgPicture.asset(asset),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.space10),
                padding: EdgeInsets.symmetric(vertical: Dimensions.space12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: ColorResources.dark5),
                  ),
                ),
                child: Row(
                  children: [
                    Text(title, style: semiBoldMediumLarge),
                    Spacer(),
                    SvgPicture.asset('assets/images/arrow_forward_ios.svg'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
