import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/repositories/cart_repository.dart';

import '../view/components/fingerprint_dialog.dart';
import '../view/components/order_success_dialog.dart';
import '../view/components/pin_dialog.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();

  RxList<Map<String, dynamic>> cart = <Map<String, dynamic>>[].obs;
  RxString cartViewState = 'success'.obs;
  late final CartRepository repository;

  @override
  void onInit() {
    super.onInit();
    repository = CartRepository();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      cartViewState('loading');
      final result = repository.getListOfData();
      cart.assignAll(result);
      cartViewState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      cartViewState('error');
    }
  }

  void increaseQty(Map<String, dynamic> item) {
    item['qty']++;
    cart.refresh();
  }

  void decreaseQty(Map<String, dynamic> item) async {
    if (item['qty'] > 1) {
      item['qty']--;
      cart.refresh();
    }
  }

  // Get food items
  List<Map<String, dynamic>> get foodItems =>
      cart.where((e) => e['item']['category'] == 'food').toList();

  /// Get drink items
  List<Map<String, dynamic>> get drinkItems =>
      cart.where((e) => e['item']['category'] == 'drink').toList();

  // calculate total price of all item
  int get totalPrice => cart.fold(
      0,
      (prevTotal, item) =>
          prevTotal + (item['item']['harga'] as int) * item['qty'] as int);

  // calculate discount price
  int get discountPrice => totalPrice ~/ 100;

  // calculate final price
  int get grandTotalPrice => totalPrice - discountPrice;

  Future<void> verify() async {
    // check supported auth type in device
    final LocalAuthentication localAuth = LocalAuthentication();
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    final bool isBiometricSupported = await localAuth.isDeviceSupported();

    if (canCheckBiometrics && isBiometricSupported) {
      // open fingerprint dialog if supported
      final String? authType = await showFingerprintDialog();

      if (authType == 'fingerprint') {
        // fingerprint auth flow
        final bool authenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to confirm order'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );

        // if succeed, order cart
        if (authenticated) {
          showOrderSuccessDialog();
        }
      } else if (authType == 'pin') {
        // pin auth flow
        await showPinDialog();
      }
    } else {
      await showPinDialog();
    }
  }

  Future<String?> showFingerprintDialog() async {
    // ensure all modal is closed before show fingerprint dialog
    Get.until(ModalRoute.withName(MainRoute.checkout));
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showPinDialog() async {
    // ensure all modal is closed before show pin dialog
    Get.until(ModalRoute.withName(MainRoute.checkout));

    const userPin = '123456';

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      // if succeed, order cart
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      // if failed 3 times, show order failed dialog
      Get.until(ModalRoute.withName(MainRoute.checkout));
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(MainRoute.checkout));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    Get.back();
  }
}
