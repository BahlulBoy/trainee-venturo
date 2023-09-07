import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CounterController extends GetxController{
  static CounterController get to => Get.find();

  var count = 0.obs;
  void increment() async {
    try {
      count++;
    } catch(e, stack) {
      await Sentry.captureException(
        e,
        stackTrace: stack
      );
    }
  }
}