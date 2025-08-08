import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/common/common.dart';

import '../../../core/core.dart';
import '../../feature.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final NavbarController navbarController = Get.put(NavbarController());

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(CartRepo(apiService: Get.find()));
    final controller=Get.put(CartController(cartRepo: Get.find()));
    controller.loading=true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            backgroundColor: ColorResources.whiteColor,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                readOnly: true,
                style: regularDefault.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
                controller: controller.searchController,
                autofocus: false,
                textInputAction: TextInputAction.done,
                enabled: true,

                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space15,
                    vertical: Dimensions.space5,
                  ),
                  hintStyle: regularSmall.copyWith(
                    color: ColorResources.getdark45(),
                  ),
                  // fillColor: ColorResources.dark25,
                  // filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: ColorResources.dark10,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.extraLargeRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: ColorResources.dark10,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.extraLargeRadius,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: ColorResources.dark10,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.extraLargeRadius,
                    ),
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {
                      customBottomSheet(
                        height: size.height * 0.8,
                        width: size.width,
                        context: context,
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: CustomTextField(
                                onChanged: (onChanged) {},
                                hintText: 'Search Name',
                                borderRadius: Dimensions.extraLargeRadius,
                                isPrefixIcon: true,
                                inputAction: TextInputAction.done,
                              ),
                            ),
                            SizedBox(height: Dimensions.space10),
                            Expanded(
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(17, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // print('$index');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 1,
                                                  color: ColorResources.dark5,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Name',
                                                  style: mediumLarge,
                                                ),
                                                Text(
                                                  'Phone Number',
                                                  style: regularLarge.copyWith(
                                                    color:
                                                        ColorResources.dark75,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    color: ColorResources.getdark45(),
                  ),
                ),
                onFieldSubmitted: (text) {},

                onChanged: (text) {},
              ),
            ),
            action: GestureDetector(
              onTap: (){},
              child: Container(
                height: 40,
                // width: 86,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: Dimensions.space12),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.largePadding,
                  vertical: Dimensions.defaultPadding,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.primary5,
                  borderRadius: BorderRadius.circular(
                    Dimensions.extraLargeRadius,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/add.svg',
                      color: ColorResources.primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: Dimensions.space4),
                      child: Text(
                        'Add',
                        style: mediumLarge.copyWith(
                          color: ColorResources.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body:controller.loading
              ?Loading()
              : controller.cartModel.data==null
                  ? EmptyCart(
                      onPressed: () {
                        if (Get.currentRoute == RouteHelper.navbarScreen) {
                          navbarController.changeIndex(0);
                        } else {
                          Get.toNamed(RouteHelper.navbarScreen, arguments: 0);
                        }
                      },
                    )
                  : Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.space16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.space8,
                        ),
                        child: Row(
                          children: [
                            Text('Menu Count:', style: regularLarge),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text('${controller.cartModel.data!.totalProductsI}', style: semiBoldLarge),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async{
                              await  controller.rmAllProduct();
                              await controller.clearUuid();
                              },
                              child: SvgPicture.asset(
                                'assets/images/trash.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(controller.cartModel.data!.products!.length, (index) {
                                final product=controller.cartModel.data!.products![index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.space8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: ColorResources.dark10,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     GestureDetector(
                                       onTap:(){
                                         debugPrint('delete');
                                         },
                                       child: Container(
                                          padding: const EdgeInsets.only(right: 4),
                                          child: Icon(Icons.close),
                                        ),
                                     ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${product.name} ${product.cartId}',
                                                  style: mediumLarge,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:()=>controller.minus(index: index),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(Dimensions.smallRadius),
                                                          color: ColorResources.dark5,
                                                        ),
                                                        child: Icon(Icons.remove, color: ColorResources.darkColor),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.space4,
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                        Dimensions.space14,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.smallRadius,),
                                                        color: ColorResources.dark5,
                                                      ),
                                                      child: Text(
                                                        '${product.quantity}',
                                                        style: semiBoldMediumLarge.copyWith(color: ColorResources.darkColor),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap:()=> controller.plus(index: index),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                            Dimensions
                                                                .smallRadius,
                                                          ),
                                                          color: ColorResources.dark5,
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: ColorResources
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.3,
                                                  child: Column(
                                                    children: [

                                                      listDetail(
                                                        title: 'Price',
                                                        value: '\$ ${product.price}',
                                                      ),
                                                      listDetail(
                                                        title: 'Sub Total',
                                                        value: '\$ ${product.total} ',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap:(){
                                                    discountDialog(
                                                      content: GetBuilder<CartController>(
                                                        builder: (controller) {
                                                          return Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.space8,
                                                                  horizontal: Dimensions.space3,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                                                  border: Border.all(width: 1, color:ColorResources.dark10),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    ...List.generate(
                                                                      controller.discount.length,
                                                                          (index) {
                                                                        final entry = controller.discount.entries.toList()[index];
                                                                        return GestureDetector(
                                                                          onTap: () => controller.isSelect(index),
                                                                          child: Container(
                                                                            margin: EdgeInsets.symmetric(horizontal: Dimensions.space5,),
                                                                            padding: EdgeInsets.symmetric(
                                                                              horizontal: Dimensions.largePadding,
                                                                              vertical: Dimensions.defaultPadding,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                                                                              color: controller.discountIndex == index
                                                                                  ? ColorResources.darkColor
                                                                                  : ColorResources.dark5,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  entry.key,
                                                                                  color: controller.discountIndex == index
                                                                                      ? ColorResources.whiteColor
                                                                                      : ColorResources.darkColor,
                                                                                ),
                                                                                SizedBox(width: Dimensions.space8,),
                                                                                Text(
                                                                                  entry.value,
                                                                                  style: regularLarge.copyWith(
                                                                                    color: controller.discountIndex == index
                                                                                        ? ColorResources.whiteColor
                                                                                        : ColorResources.darkColor,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: Dimensions.space8,
                                                              ),
                                                              CustomTextField(
                                                                style: regularLarge,
                                                                controller: controller.discountCtr,
                                                                onChanged: (onChanged) {},
                                                                noneBorder: true,
                                                                fillColor: ColorResources.dark5,
                                                                inputAction: TextInputAction.done,
                                                                textInputType: TextInputType.numberWithOptions(),
                                                              ),
                                                              SizedBox(height: Dimensions.space8),
                                                              Divider(color: ColorResources.dark10),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      onTap: () async{
                                                        final discountValue = double.tryParse(controller.discountCtr.text) ?? 0;
                                                        final productPrice = product.price ?? 0;

                                                        if (controller.isFixedDiscount) {

                                                          if (discountValue >= productPrice) {
                                                            CustomSnackBar.error(
                                                              errorList: ['Discounted price must be less than $productPrice'],
                                                            );
                                                            return;
                                                          }
                                                        }

                                                        await controller.disCountItem(
                                                          discount: controller.discountCtr.text,
                                                          cartId: '${product.cartId}',
                                                          isFix: controller.isFixedDiscount,
                                                        );

                                                        Get.back();
                                                        controller.clear();

                                                        debugPrint('${product.cartId} ${controller.isFixedDiscount} $productPrice ');
                                                      },
                                                    );
                                                    },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.space8,
                                                      vertical: Dimensions.space2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        Dimensions.smallRadius,
                                                      ),
                                                      color: ColorResources.primary5,
                                                    ),
                                                    child: Text(
                                                      product.isDiscountFixed==true
                                                        ? 'Discount : \$ ${product.discount??0}'
                                                        : 'Discount : ${(double.tryParse(product.discount?.toString() ?? '0') ?? 0).toStringAsFixed(0)} %',
                                                      style: semiBoldMediumLarge.copyWith(color: ColorResources.primaryColor),
                                                    ),
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.space16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.defaultRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listCheck(title: 'Item count', value:'${controller.cartModel.data!.totalQuantityI}'),
                            listCheck(title: 'Subtotal', value: '\$${(double.tryParse(controller.cartModel.data?.subTotalI.toString()??'0')??0).toStringAsFixed(2)}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      discountDialog(
                                        content: GetBuilder<CartController>(
                                          builder: (controller) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions.space8,
                                                    horizontal: Dimensions.space3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                                    border: Border.all(width: 1, color:ColorResources.dark10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      ...List.generate(
                                                        controller.discount.length,
                                                        (index) {
                                                          final entry = controller.discount.entries.toList()[index];
                                                          return GestureDetector(
                                                            onTap: () => controller.isSelect(index),
                                                            child: Container(
                                                              margin: EdgeInsets.symmetric(horizontal: Dimensions.space5,),
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal: Dimensions.largePadding,
                                                                vertical: Dimensions.defaultPadding,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                                                                color: controller.discountIndex == index
                                                                    ? ColorResources.darkColor
                                                                    : ColorResources.dark5,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    entry.key,
                                                                    color: controller.discountIndex == index
                                                                        ? ColorResources.whiteColor
                                                                        : ColorResources.darkColor,
                                                                  ),
                                                                  SizedBox(width: Dimensions.space8,),
                                                                  Text(
                                                                    entry.value,
                                                                    style: regularLarge.copyWith(
                                                                      color: controller.discountIndex == index
                                                                          ? ColorResources.whiteColor
                                                                          : ColorResources.darkColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.space8,
                                                ),
                                                CustomTextField(
                                                  style: regularLarge,
                                                  controller: controller.discountCtr,
                                                  onChanged: (onChanged) {},
                                                  noneBorder: true,
                                                  fillColor: ColorResources.dark5,
                                                  inputAction: TextInputAction.done,
                                                  textInputType: TextInputType.numberWithOptions(),
                                                ),
                                                SizedBox(height: Dimensions.space8),
                                                Divider(color: ColorResources.dark10),
                                              ],
                                            );
                                          },
                                        ),
                                        onTap: () async{
                                          await controller.disCountInvoice(discount: controller.discountCtr.text, isFix: controller.isFixedDiscount);
                                          // await Future.delayed(const Duration(milliseconds: 200));
                                          Get.back();
                                          controller.clear();
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Discount',
                                          style: boldMediumLarge.copyWith(
                                            color: ColorResources.primaryColor,
                                            letterSpacing: 0.02,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.cartModel.data!.isDiscountFixedI==true
                                      ? '\$ ${controller.cartModel.data!.cartDiscountI??0}'
                                      : '${(double.tryParse(controller.cartModel.data!.cartDiscountI.toString()) ??0).toStringAsFixed(0)} %',
                                  style: boldMediumLarge.copyWith(
                                    color: ColorResources.primaryColor,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: semiBoldMediumLarge.copyWith(
                                    color: ColorResources.darkColor,
                                  ),
                                ),
                                Text(
                                  '\$ ${(double.tryParse(controller.cartModel.data?.totalI.toString()??'0')??0).toStringAsFixed(2)}',
                                  style: semiBoldMediumLarge.copyWith(
                                    color: ColorResources.darkColor,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorResources.darkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.smallRadius,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.space8,
                                ),
                              ),
                              onPressed: () {
                                confirmCheckout(
                                  content: GetBuilder<CartController>(
                                    builder: (controller) {
                                      return SizedBox(
                                        width: size.width * .78,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Amount',
                                                        style: regularDefault
                                                            .copyWith(
                                                              color:
                                                                  ColorResources
                                                                      .dark75,
                                                            ),
                                                      ),
                                                      Text(
                                                        '\$ ${(double.tryParse(controller.cartModel.data?.totalI.toString()??'0')??0).toStringAsFixed(2)}',
                                                        style: regularLarge,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Order Date',
                                                        style: regularDefault
                                                            .copyWith(
                                                              color:
                                                                  ColorResources
                                                                      .dark75,
                                                            ),
                                                      ),
                                                      Text(
                                                        'April 12, 2025',
                                                        style: regularLarge,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.space8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: Dimensions.space8,
                                                  ),
                                              child: Text('Payment Methods'),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: Dimensions.space8,
                                                horizontal: Dimensions.space3,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      Dimensions.defaultRadius,
                                                    ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: ColorResources.dark10,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,

                                                children: [
                                                  ...List.generate(controller.method.length, (
                                                    index,
                                                  ) {
                                                    final entry = controller
                                                        .method
                                                        .entries
                                                        .toList()[index];
                                                    return Expanded(
                                                      child: GestureDetector(
                                                        onTap: () => controller
                                                            .metSelect(index),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              EdgeInsets.symmetric(
                                                                horizontal:
                                                                    Dimensions
                                                                        .space5,
                                                              ),
                                                          padding: EdgeInsets.symmetric(
                                                            vertical: Dimensions
                                                                .defaultPadding,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  Dimensions
                                                                      .smallRadius,
                                                                ),
                                                            color:
                                                                controller
                                                                        .methodIndex ==
                                                                    index
                                                                ? ColorResources
                                                                      .darkColor
                                                                : ColorResources
                                                                      .dark5,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                entry.key,
                                                                color:
                                                                    controller
                                                                            .methodIndex ==
                                                                        index
                                                                    ? ColorResources
                                                                          .whiteColor
                                                                    : ColorResources
                                                                          .darkColor,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Dimensions
                                                                        .space8,
                                                              ),
                                                              Text(
                                                                entry.value,
                                                                style: regularLarge.copyWith(
                                                                  color:
                                                                      controller
                                                                              .methodIndex ==
                                                                          index
                                                                      ? ColorResources
                                                                            .whiteColor
                                                                      : ColorResources
                                                                            .darkColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  action: [
                                    GetBuilder<CartController>(
                                      builder: (controller) {
                                        return controller.methodIndex == 0
                                            ? Row(

                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () => Get.back(),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              vertical:
                                                                  Dimensions
                                                                      .space10,
                                                            ),
                                                        margin: EdgeInsets.only(
                                                          right: Dimensions
                                                              .defaultMargin,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: ColorResources
                                                              .dark5,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                Dimensions
                                                                    .defaultRadius,
                                                              ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Cancel',
                                                            style: semiBoldMediumLarge
                                                                .copyWith(
                                                                  color:
                                                                      ColorResources
                                                                          .dark75,
                                                                ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              vertical:
                                                                  Dimensions
                                                                      .space10,
                                                            ),
                                                        margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .defaultMargin,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: ColorResources
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                Dimensions
                                                                    .defaultRadius,
                                                              ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Pay',
                                                            style: semiBoldMediumLarge
                                                                .copyWith(
                                                                  color: ColorResources
                                                                      .whiteColor,
                                                                ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  ...List.generate(
                                                    controller.bank.length,
                                                    (index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          //Bank choice
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                            vertical: Dimensions
                                                                .smallPadding,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                16,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  Dimensions
                                                                      .defaultRadius,
                                                                ),
                                                            border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  ColorResources
                                                                      .dark10,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .bank[index],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                      },
                                    ),
                                  ],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Checkout',
                                    style: semiBoldMediumLarge.copyWith(
                                      color: ColorResources.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * .11),
                    ],
                  ),
                ),
        );
      },
    );
  }

  listCheck({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: regularMediumLarge.copyWith(
            color: ColorResources.dark75,
            letterSpacing: 0.02,
          ),
        ),
        Text(
          value,
          style: regularMediumLarge.copyWith(
            color: ColorResources.dark75,
            letterSpacing: 0.02,
          ),
        ),
      ],
    );
  }

  listDetail({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: regularDefault.copyWith(
              color: ColorResources.dark75,
              letterSpacing: 0.02,
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(':'),
              SizedBox(width: Dimensions.space8),
              Text(
                value,
                style: regularDefault.copyWith(
                  color: ColorResources.darkColor,
                  letterSpacing: 0.02,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
