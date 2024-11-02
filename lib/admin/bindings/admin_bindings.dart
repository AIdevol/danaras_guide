import 'package:banaras_guide/admin/controller/dashboard_screen_controller.dart';
import 'package:get/get.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardScreenController>(() => DashboardScreenController());
  }
}
