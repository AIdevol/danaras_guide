import 'package:banaras_guide/config/icon_widget.dart';
import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:banaras_guide/launcher/screen_launcher/controller/screen_View_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenViewLauncher extends GetView<ScreenViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
        child: GetBuilder<ScreenViewController>(
      init: ScreenViewController(),
      builder: (controller) => Scaffold(
        backgroundColor: appColor,
        body: const Center(
          child: IconWidget(),
        ),
      ),
    ));
  }
}
