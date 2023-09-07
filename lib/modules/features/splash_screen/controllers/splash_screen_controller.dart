import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get to => Get.find();

  Future<void> checkAuth() async {
    var isHaveToken = await LocalStorageService.checkAuth();
    if (isHaveToken) {
      Get.offNamed(MainRoute.counter);
    } else {
      Get.offNamed(MainRoute.signIn);
    }
  }
}