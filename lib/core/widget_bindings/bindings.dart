import 'package:banaras_guide/launcher/screen_launcher/controller/screen_View_controller.dart';
import 'package:banaras_guide/services/auth/app_authenctication_method.dart';
import 'package:banaras_guide/services/auth/auth_abstract_method.dart';
import 'package:get/get.dart';

class WidgetBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenViewController>(() => ScreenViewController());
    Get.lazyPut<AppAuthencticationMethod>(() => AppAuthencticationMethod());
  }
}
