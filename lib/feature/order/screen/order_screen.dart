
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../service/test.dart';
import '/common/common.dart';
import '../../../core/core.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int selectIndex=0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorResources.whiteColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Get.to(Test());
              },
                child: Text('All Order:', style: boldOverLarge)
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('4', style: boldOverLarge),
            ),
          ],
        ),
        action: GestureDetector(
          onTap: (){
            customBottomSheet(
              height: size.height * 0.4 ,
              // isScrollControlled: false,
              width: size.width,
              context: context,
              horizontal: Dimensions.largePadding,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text('Filter', style: boldOverLarge),
                  ),
                  ...List.generate(3, (index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectIndex=index;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.defaultMagin,
                          ),
                          padding: EdgeInsets.all(Dimensions.largePadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.largeRadius),
                            border:selectIndex==index?  Border.all(
                              width: 1,
                              color:ColorResources.primary10
                            ):Border(),
                            color:selectIndex==index?  ColorResources.primary5:ColorResources.whiteColor,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Today',
                                  style: semiBoldMediumLarge,
                                ),
                              ),
                              Spacer(),
                              Text(
                                  'july 24,2025',
                                  style: semiBoldMediumLarge
                              ),
                            ],
                          )
                      ),
                    );
                  }),

                ],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
              color: ColorResources.primary10,

            ),child: Text('July 24,2025',style: mediumLarge.copyWith(color:ColorResources.primaryColor),),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.largePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8,),
              ...List.generate(16, (index) {
                return GestureDetector(
                  onTap: () {
                    customBottomSheet(
                      height: size.height * 0.7,
                      // isScrollControlled: false,
                      width: size.width,
                      context: context,
                      horizontal: Dimensions.largePadding,
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Get.to(Test());
                            },
                            child: Text('Invoice Nº #36', style: boldOverLarge),
                          ),
                          GestureDetector(
                            onTap:(){

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: Dimensions.largeMagin,
                              ),
                              padding: EdgeInsets.all(Dimensions.largePadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.largeRadius,
                                ),
                                color: ColorResources.whiteColor,
                              ),
                              child: Column(
                                children: [
                                  listName(assets: 'assets/images/profile.svg', name: 'Name', value: 'Wep Richard'),
                                  listName(assets: 'assets/images/phone.svg', name: 'Phone', value: '012345678'),
                                  listName(assets: 'assets/images/cash.svg', name: 'Cash', value: '+\$40.00',color: ColorResources.successColor),

                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.all(Dimensions.largePadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.largeRadius,
                              ),
                              color: ColorResources.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Item Detail', style: semiBoldMediumLarge),
                                Container(
                                  width: size.width,
                                  constraints: BoxConstraints(maxHeight: 90),

                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...List.generate(8, (index) {
                                          return Row(
                                            children: [
                                              Text(
                                                '${index + 1}x',
                                                style: regularLarge,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  4.0,
                                                ),
                                                child: Text(
                                                  'Honey Cream ',
                                                  style: regularLarge,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                '\$5.00',
                                                style: regularLarge,
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.defaultPadding,
                                  ),
                                  child: DottedLine(
                                    dashColor: ColorResources.dark10,
                                  ),
                                ),
                                listCount(title: 'Item count', value: '6'),
                                listCount(title: 'Subtotal', value: '\$40.00'),
                                listCount(title: 'Discount', value: '\$0.00'),
                                SizedBox(height: Dimensions.space16),
                                Row(
                                  children: [
                                    Text('Total', style: mediumLarge),
                                    Spacer(),
                                    Text('\$40.00', style: mediumLarge),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                              backgroundColor: ColorResources.darkColor,
                            ),
                            onPressed: () async {
                              // await PrinterService.printText('text');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/print.svg'),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Print Receipt',
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
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.defaultMagin,
                    ),
                    padding: EdgeInsets.all(Dimensions.largePadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.largeRadius,
                      ),
                      color: ColorResources.whiteColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'INV-1004',
                                style: semiBoldMediumLarge,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.defaultMagin),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.space6,
                                vertical: Dimensions.space2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.smallRadius,
                                ),
                                color: ColorResources.orderStatusColor(
                                  '3',
                                ).withOpacity(0.1),
                              ),
                              child: Text(
                                'Complete',
                                style: mediumDefault.copyWith(
                                  color: ColorResources.orderStatusColor('3'),
                                ),
                              ),
                            ),
                            Text('\$40.00', style: mediumLarge),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }

  listCount({required String title, required String value,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.smallPadding),
      child: Row(
        children: [
          Text(
            title,
            style: regularLarge.copyWith(color: ColorResources.dark75),
          ),
          Spacer(),
          Text(
            value,
            style: regularLarge.copyWith(color: ColorResources.dark75),
          ),
        ],
      ),
    );
  }

  listName({required String assets, required String name, required String value,Color color= ColorResources.darkColor}){
    return Row(
      children: [
        SvgPicture.asset(assets),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: semiBoldMediumLarge,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: semiBoldMediumLarge.copyWith(
            color:color,
          ),
        ),
      ],
    );
  }
}
