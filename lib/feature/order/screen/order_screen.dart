import 'package:dotted_line/dotted_line.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:minipos_app/common/commen.dart';
import 'package:minipos_app/feature/order/service/pr_service.dart';
import '../../../core/core.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorResources.whiteColor,
        title: Row(
          children: [
            Text('All Order:', style: boldOverLarge),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('4', style: boldOverLarge),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.largePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(8, (index) {
                return GestureDetector(
                  onTap: () {
                    customBottomSheet(
                      height: size.height * 0.9,
                      // isScrollControlled: false,
                      width: size.width,
                      context: context,
                      horizontal: Dimensions.largePadding,
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final type =
                                  await PrinterService.getPrinterType();
                              print(type);
                            },
                            child: Text('Invoice Nº #36', style: boldOverLarge),
                          ),
                          Container(
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
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/cash.svg'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cash',
                                    style: semiBoldMediumLarge,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '+\$40.00',
                                  style: semiBoldMediumLarge.copyWith(
                                    color: ColorResources.successColor,
                                  ),
                                ),
                              ],
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
                                  constraints: BoxConstraints(maxHeight: 135),

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
                              await PrinterService.printText('text');
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer 0${index + 1}',
                              style: semiBoldMediumLarge,
                            ),
                            Text('\$40.00', style: mediumLarge),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '59 St 534, Phnom Penh, Cambodia',
                              style: regularDefault,
                            ),
                            Container(
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

  listCount({required String title, required String value}) {
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
}
