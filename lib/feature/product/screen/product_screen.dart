import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minipos_app/feature/feature.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  final CartController cartController=Get.put(CartController(cartRepo: Get.find()));
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ProductRepo(apiService: Get.find()));
    Get.put(CartRepo(apiService: Get.find())); // <-- ADD THIS
    final controller = Get.put(ProductController(productRepo: Get.find(),));
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
    return GetBuilder<ProductController>(
      assignId: true,
      builder: (controller) {
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
              onTap: () {
                Get.toNamed(RouteHelper.filterScreen);
              },
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
          body:controller.isLoading
            ?  Loading()
            : RefreshIndicator(
            onRefresh: ()async{
              controller.reset();
              await controller.initialData(shouldLoad: false);
            },
              child: CustomScrollView(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
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
                                    // ...List.generate(categories.length, (index) {
                                    //   return Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //       horizontal: 16,
                                    //       vertical: 12,
                                    //     ),
                                    //     margin: EdgeInsets.all(4),
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(
                                    //         Dimensions.smallRadius,
                                    //       ),
                                    //       color: ColorResources.whiteColor,
                                    //       border: Border.all(
                                    //         color: ColorResources.dark5,
                                    //         width: 1,
                                    //       ),
                                    //     ),
                                    //     child: Text(
                                    //       categories[index],
                                    //       style: regularDefault.copyWith(
                                    //         color: ColorResources.darkColor,
                                    //         letterSpacing: 0.02,
                                    //       ),
                                    //     ),
                                    //   );
                                    // }),
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
                    delegate: SliverChildBuilderDelegate(
                        // childCount:controller.productModel.data!.length,
                      childCount: controller.products.length,
                            (context, index,) {
                          // final product=controller.productModel.data![index];
                              final pro=controller.products[index];
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
                            (pro.images != null && pro.images!.isNotEmpty)
                           ? Container(
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
                                  image:
                                      NetworkImage(pro.images![0].imageUrl!
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
                            )
                           : Container(
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
                              ),
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
                                    '${pro.name}   ${pro.id}',
                                    style: mediumLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text('${pro.priceFormat}', style: semiBoldMediumLarge),
                                      SizedBox(width: 2),
                                      // Text(
                                      //   '\$6.00',
                                      //   style: mediumDefault.copyWith(
                                      //     fontSize: 14,
                                      //     decoration: TextDecoration.lineThrough,
                                      //     color: ColorResources.dark45,
                                      //   ),
                                      // ),
                                      // Spacer(),
                                      //
                                      // Text(
                                      //   '-20%',
                                      //   style: regularDefault.copyWith(
                                      //     letterSpacing: 0.01,
                                      //     color: ColorResources.errorColor,
                                      //   ),
                                      // ),
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
                                          '${pro.outOfStockStatus}',
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
                                        onTap: ()async {
                                         bool added=await cartController.addToCart(productId: pro.id!, qty: 1);
                                          if(added){
                                            addToCardDialog();
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/cart.svg',
                                          color: ColorResources.primaryColor,
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
                SliverToBoxAdapter(
                  child: controller.isMoreLoading
                      ? Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 100)
                        ],
                      )
                      : const SizedBox(),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        );
      },
    );
  }
}


