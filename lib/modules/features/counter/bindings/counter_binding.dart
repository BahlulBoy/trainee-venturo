import 'package:get/get.dart';
import 'package:trainee/modules/features/counter/controllers/counter_controller.dart';

class CounterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CounterController());
  }

}