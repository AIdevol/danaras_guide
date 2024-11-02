import 'package:banaras_guide/constants/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  onNotificationsTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.notifications );
  }

  onProfileTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingsScreen);
  }

  onDashboatrdTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.dashboardScreen);
  }

  onGuideTap() {}

  onSettingsTap(BuildContext context) {}

  onHelpTap() {}

  onLogoutTap() {}
}
