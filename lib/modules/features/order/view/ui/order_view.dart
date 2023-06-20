import 'package:flutter/material.dart';

import '../components/order_top_bar.dart';
import 'history_order_tab.dart';
import 'ongoing_order_tab.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: OrderTopBar(),
          body: TabBarView(
            children: [
              OnGoingOrderTabView(),
              OrderHistoryTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
