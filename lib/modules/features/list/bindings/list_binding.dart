import 'package:get/get.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListController());
  }
}