import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/checkout/view/components/tile_option.dart';

import '../../../list/view/components/section_header.dart';
import '../../controllers/checkout_controller.dart';
import '../components/cart_list_sliver.dart';
import '../components/cart_order_bottom_bar.dart';
import '../components/rounded_custom_app_bar.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Checkout Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: const RoundedAppBar(
        title: 'Order',
        icon: Icons.shopping_cart_checkout,
      ),
      body: Obx(() => CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: 28.verticalSpace),
              if (CheckoutController.to.foodItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Food',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    carts: CheckoutController.to.foodItems,
                  ),
                )
              ],
              SliverToBoxAdapter(child: 17.verticalSpace),
              if (CheckoutController.to.drinkItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.local_drink_outlined,
                    title: 'Drink',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    carts: CheckoutController.to.drinkItems,
                  ),
                )
              ],
            ],
          )),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Total order tile
                    TileOption(
                      title: 'Total orders',
                      subtitle: '(${CheckoutController.to.cart.length} Menu):',
                      icon: Icons.payments_outlined,
                      message:
                          'Rp ${CheckoutController.to.totalPrice.toString()}',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Divider(color: Colors.black54, height: 2.h),

                    // Discount tile
                    TileOption(
                      icon: Icons.discount_outlined,
                      iconSize: 24.r,
                      title: 'Discount',
                      message: 'Rp ${CheckoutController.to.discountPrice}',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),

                    // Payment options tile
                    TileOption(
                      icon: Icons.payment_outlined,
                      iconSize: 24.r,
                      title: 'Payment',
                      message: 'Pay Later',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              CartOrderBottomBar(
                totalPrice: 'Rp ${CheckoutController.to.grandTotalPrice}',
                onOrderButtonPressed: CheckoutController.to.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
