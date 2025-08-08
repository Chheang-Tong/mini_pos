import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/common.dart';
import '/core/core.dart';

import '../../feature.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final formKey = GlobalKey<FormState>();

  final ProductController controller = Get.put(ProductController(productRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ProductController>(builder: (controller) {
      return Scaffold(
        backgroundColor: ColorResources.bgColor,
        appBar: AppBar(
          title: Text('Filter Option'),
          titleTextStyle: semiBoldExtraLarge.copyWith(
            color: ColorResources.darkColor,
          ),
          actions: [
            GestureDetector(
              onTap: controller.isFilterEmpty ? null : () {
                    controller.reset();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 68,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:controller.isFilterEmpty
                  ?ColorResources.dark5:ColorResources.primary25,
                ),
                child: Text(
                  'Reset',
                  style: semiBoldDefault.copyWith(
                    color: controller.isFilterEmpty
                   ? ColorResources.dark25:ColorResources.primaryColor,

                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Price Range',
                  style: semiBoldDefault.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.fromController,
                      focusNode: controller.fromNode,
                      nextFocus: controller.toNode,
                      borderRadius: 16,
                      hintText: 'From',
                      inputAction: TextInputAction.next,
                      textInputType: TextInputType.numberWithOptions(),
                      onChanged: (onChanged) {
                        controller.update();
                      },
                    ),
                  ),
                  SizedBox(width: 23),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.toController,
                      focusNode: controller.toNode,
                      hintText: 'To',
                      borderRadius: 16,
                      inputAction: TextInputAction.done,
                      textInputType: TextInputType.numberWithOptions(),
                      onChanged: (onChanged) {
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Promotion Type',
                  style: semiBoldDefault.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorResources.whiteColor,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedValue,
                    hint: Text('Select'),
                    borderRadius: BorderRadius.circular(16),
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      controller.onChanged(newValue!);
                      controller.update();
                    },
                    items: controller.items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return controller.items.map<Widget>(
                            (String value) {
                          return Row(
                            children: [
                              Text(value),
                              GestureDetector(
                                onTap: () {
                                  controller.nullValue();
                                  controller.update();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close, size: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList();
                    },
                  ),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Sort By',
                  style: semiBoldDefault.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    controller.sorts.length,
                        (index) => GestureDetector(
                      onTap: () {
                        controller.sort(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: size.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.selectSort == index
                              ? ColorResources.primaryColor
                              : ColorResources.dark5,
                        ),
                        child: Center(
                          child: Text(
                            controller.sorts[index],
                            style: regularDefault.copyWith(
                              color: controller.selectSort == index
                                  ? ColorResources.whiteColor
                                  : ColorResources.darkColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: size.width,
          child: FloatingActionButton(
            backgroundColor: ColorResources.primary75,
            // onPressed: () {
              // final args = {
              //   'startPrice': controller.fromController.text,
              //   'endPrice': controller.toController.text,
              //   'promoId': controller.selectedValue,
              //   'sortBy': controller.selectSort != null
              //       ? controller.sorts[controller.selectSort!]
              //       : '',
              // };
              //
              // // Print to console
              // print('=== Passing arguments to navbarScreen: $args');
              //
              // Get.toNamed(
              //   RouteHelper.navbarScreen,
              //   arguments: args,
              // );

            // },
            onPressed: () async {
              controller.filterProducts();
              Get.back(); // Go back to product screen
            },
            child: Text(
              'Apply',
              style: semiBoldDefault.copyWith(
                color: ColorResources.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}