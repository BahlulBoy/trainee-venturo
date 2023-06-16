import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class ConterController extends GetxController {
  static ConterController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();

    await GlobalController.to.checkConnection();
  }

  /// Initial Variable
  var count = 0.obs;

  /// Increment function
  void increment() async {
    try {
      count++;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
