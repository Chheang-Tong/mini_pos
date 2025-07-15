import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/commen.dart';
import '../../../core/core.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});
  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final List<String> categories = [
    'All',
    'Fruits',
    'Vegetables',
    'Dairy',
    'Bakery',
    'Beverages',
    'Snacks',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorResources.bgColor,
        lead: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: Dimensions.space16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorResources.whiteColor,
            ),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CustomTextField(
            onChanged: () {},
            borderRadius: 32,
            hintText: 'Search for Products',
            isPrefixIcon: true,
            inputAction: TextInputAction.done,
          ),
        ),
        action: GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: Dimensions.space16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorResources.whiteColor,
            ),
            child: Center(child: SvgPicture.asset('assets/images/filter.svg')),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.space16,
                          vertical: Dimensions.space12,
                        ),
                        margin: EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.smallRadius,
                          ),
                          color: ColorResources.primaryColor,
                        ),
                        child: Text(
                          'All',
                          style: regularDefault.copyWith(
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(categories.length, (index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.smallRadius,
                                    ),
                                    color: ColorResources.whiteColor,
                                    border: Border.all(
                                      color: ColorResources.dark5,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    categories[index],
                                    style: regularDefault.copyWith(
                                      color: ColorResources.darkColor,
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Menu Today', style: boldMediumLarge),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 80, right: 8, left: 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(childCount: 6, (
                context,
                index,
              ) {
                return Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: ColorResources.white45,
                    borderRadius: BorderRadius.circular(Dimensions.largeRadius),
                    border: Border.all(color: ColorResources.dark45, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              Dimensions.largeRadius - 1,
                            ),
                            topRight: Radius.circular(
                              Dimensions.largeRadius - 1,
                            ),
                          ),
                          color: ColorResources.dark45,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://i.pinimg.com/736x/b6/ff/6f/b6ff6f1069bdb3ec62a6e40a7177a397.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Stack(
                        //   clipBehavior: Clip.none,
                        //   children: [
                        //     Positioned(
                        //       top: 4,
                        //       right: 4,
                        //       child: GestureDetector(
                        //         onTap: () => {},
                        //         child: Container(
                        //           padding: EdgeInsets.all(
                        //             Dimensions.smallRadius,
                        //           ),
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(
                        //               Dimensions.defaultRadius,
                        //             ),
                        //             color: ColorResources.whiteColor
                        //                 .withOpacity(0.25),
                        //           ),
                        //           child: Center(
                        //             child: Icon(
                        //               Icons.favorite_outline,
                        //               size: 20,
                        //               // color: widget.color,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              'widget.name',
                              style: mediumLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text('\$4.75', style: semiBoldMediumLarge),
                                SizedBox(width: 2),
                                Text(
                                  '\$6.00',
                                  style: mediumDefault.copyWith(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: ColorResources.dark45,
                                  ),
                                ),
                                Spacer(),

                                Text(
                                  '-20%',
                                  style: regularDefault.copyWith(
                                    letterSpacing: 0.01,
                                    color: ColorResources.errorColor,
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.smallRadius,
                                    ),
                                    color: ColorResources.dark5,
                                  ),
                                  child: Text(
                                    'In Stock',
                                    style: regularDefault.copyWith(
                                      letterSpacing: 0.01,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.smallRadius,
                                    ),
                                    color: ColorResources.dark5,
                                  ),
                                  child: Text(
                                    'New',
                                    style: regularDefault.copyWith(
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    'assets/images/cart.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
        ],
      ),
    );
  }
}
