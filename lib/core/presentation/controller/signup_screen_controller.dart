import 'package:banaras_guide/main.dart';
import 'package:banaras_guide/services/custom_toast.dart';
import 'package:banaras_guide/services/custome_loader.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get/get.dart';

import '../../../services/auth/app_authenctication_method.dart';

class SignupScreenController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool acceptTerms = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> hitRegisterApiCall() async {
    isLoading.value = true;
    //  customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    final dataregisterData = {
      "firstname": fullNameController.text,
      "lastname": "",
      "email": emailController.text,
      "phone": phoneController.text,
      "password": passwordController.text,
      "confirmpass": confirmPasswordController.text
    };
    await Get.find<AppAuthencticationMethod>()
        .signUpAuhtAPiCall(dataBody: dataregisterData)
        .then((valeue) {
      // customLoader.hide();
      CustomToast.show("signup Successffuly");
    }).onError((error, stackError) {
      // customLoader.hide();
      CustomToast.show(error.toString());
    });
    // customLoader.show();
    // CustomToast.show("Successfully created User");
  }
}
