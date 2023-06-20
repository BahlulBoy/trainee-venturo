import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/bindings/checkout_binding.dart';
import 'package:trainee/modules/features/checkout/view/ui/checkout_view.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/list/bindings/list_binding.dart';
import 'package:trainee/modules/features/list/view/ui/list_item_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const ConterView(),
      binding: ConterBindding(),
    ),
    GetPage(
      name: MainRoute.list,
      page: () => const ListItemView(),
      binding: ListBinding(),
    ),
    GetPage(
      name: MainRoute.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
