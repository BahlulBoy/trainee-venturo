import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../list/view/components/menu_card.dart';
import '../../controllers/checkout_controller.dart';

class CartListSliver extends StatelessWidget {
  const CartListSliver({
    super.key,
    required this.carts,
  });

  final List<Map<String, dynamic>> carts;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.5.h),
            child: MenuCard(
              menu: carts[index]['item'],
              onIncrement: () =>
                  CheckoutController.to.increaseQty(carts[index]),
              onDecrement: () =>
                  CheckoutController.to.decreaseQty(carts[index]),
              quantity: carts[index]['qty'] as int,
            ),
          );
        },
        childCount: carts.length,
      ),
      itemExtent: 112.h,
    );
  }
}
