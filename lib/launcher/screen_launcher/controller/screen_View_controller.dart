import 'dart:async';

import 'package:banaras_guide/constants/route_strings.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScreenViewController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeListMethod('TextInput.hide');
    _navigateToNextScreen();
    super.onInit();
  }

  _navigateToNextScreen() {
    Timer(const Duration(milliseconds: 3500), () {
      Get.offNamed(AppRoutes.login);
    });
  }
}
