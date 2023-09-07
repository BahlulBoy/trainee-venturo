import 'package:get/get.dart';
import 'package:trainee/modules/features/splash_screen/controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}