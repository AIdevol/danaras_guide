import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool acceptTerms = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
 void onClose() {
    super.onInit();
  }

  
  onProfileTap() {}

  onNotificationsTap() {}

  onGuideTap() {}

  onSettingsTap() {}

  onHelpTap() {}

  onLogoutTap() {}

  hitRegisterApiCall() {}
}
