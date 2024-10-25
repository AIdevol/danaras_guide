import 'dart:collection';

import 'package:banaras_guide/launcher/screen_launcher/controller/screen_View_controller.dart';
import 'package:get/get.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenViewController>(() => ScreenViewController());
  }
}
