import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});
  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  XFile? _pickedPhoto;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF801F1F), Color(0xFF551010)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: ColorResources.bgColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            margin: EdgeInsets.only(top: 35),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorResources.dark5,
                              border: Border.all(
                                width: 3,
                                color: ColorResources.dark10,
                              ),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: _pickedPhoto != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(_pickedPhoto!.path),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/user.svg',
                                          height: 50,
                                        ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  right: -12,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? photo = await picker
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          );
                                      if (photo != null) {
                                        setState(() {
                                          _pickedPhoto = photo;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorResources.whiteColor,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/ic_camera.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: ColorResources.whiteColor,
                          ),
                        ),
                        Text(
                          'Profile',
                          style: boldOverLarge.copyWith(
                            color: ColorResources.whiteColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorResources.white10,
                          ),
                          child: Text(
                            'Save',
                            style: mediumLarge.copyWith(
                              color: ColorResources.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultPadding,
              ),
              color: ColorResources.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: textField(title: 'First Name')),
                      SizedBox(width: 13),
                      Expanded(child: textField(title: 'Last Name')),
                    ],
                  ),
                  SizedBox(height: Dimensions.space20),
                  textField(
                    title: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: Dimensions.space20),
                  textField(
                    title: 'Phone Number',
                    textInputType: TextInputType.number,
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: Dimensions.space20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  textField({
    required String title,
    TextEditingController? controller,
    TextInputAction? inputAction,
    TextInputType? textInputType,
    FocusNode? focusNode,
    FocusNode? nextNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: mediumLarge.copyWith(color: ColorResources.dark75)),
        CustomTextField(
          controller: controller,
          inputAction: inputAction ?? TextInputAction.next,
          textInputType: textInputType,
          focusNode: focusNode,
          nextFocus: nextNode,
          fillColor: ColorResources.dark10,
          noneBorder: true,
          onChanged: (onChanged) {},
        ),
      ],
    );
  }
}
