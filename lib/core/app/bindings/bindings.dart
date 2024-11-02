import 'package:banaras_guide/admin/bindings/admin_bindings.dart';
import 'package:banaras_guide/core/app/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<AdminBindings>(() => AdminBindings());
  }
}
