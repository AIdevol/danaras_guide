import 'package:banaras_guide/core/app/bindings/bindings.dart';
import 'package:banaras_guide/core/presentation/bindings/bindings.dart';
import 'package:banaras_guide/core/widget_bindings/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitBinidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetBindings>(() => WidgetBindings());
    Get.lazyPut<HomeBinding>(() => HomeBinding());
    Get.lazyPut<PresentationBindigns>(() => PresentationBindigns());
  }
}
