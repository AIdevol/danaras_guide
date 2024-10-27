import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/core/presentation/controller/notifications_screen_controller.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<NotificationsScreenController>(
        init: NotificationsScreenController(),
        builder: (controller) => Scaffold(
          backgroundColor: appColor,
          body: Stack(
            children: [
              // Background circles
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ConcentricCircles(),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: _notificationBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_notificationBody() {
  return const Center(
      child:  Text("No Notificaitons Found"));
}
