import 'package:get/get.dart';
import 'package:trainee/modules/features/profile/controller/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
  
}