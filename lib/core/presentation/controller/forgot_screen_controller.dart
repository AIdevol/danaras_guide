import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  RxBool isEmailSent = false.obs;
  RxBool isLoading = false.obs;

  void sendOTP() {
    // Implement your OTP sending logic here
    isEmailSent.value = true;
  }

  void verifyOTP() {
    // Implement your OTP verification logic here
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
