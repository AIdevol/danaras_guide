import 'package:banaras_guide/core/presentation/controller/forgot_screen_controller.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/const_color.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) => Scaffold(
          backgroundColor: appColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ConcentricCircles(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainWidgetViews(
      BuildContext context, ForgotPasswordController controller) {
    return Container(
      height: Get.height * 0.02,
      width: Get.width * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to receive OTP',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Obx(() {
                return !controller.isEmailSent.value
                    ? _buildEmailSection(controller)
                    : _buildOTPSection(controller);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailSection(ForgotPasswordController controller) {
    return Column(
      children: [
        TextField(
          controller: controller.emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email_outlined, color: appColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColor, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => controller.sendOTP(),
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Send OTP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPSection(ForgotPasswordController controller) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: Get.context!,
          length: 6,
          controller: controller.otpController,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 50,
            fieldWidth: 45,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            activeColor: appColor,
            inactiveColor: Colors.grey[300]!,
            selectedColor: appColor,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (value) {
            // Handle OTP completion
          },
          onChanged: (value) {
            // Handle OTP change
          },
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => controller.verifyOTP(),
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Verify OTP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => controller.sendOTP(),
          child: Text(
            'Resend OTP',
            style: TextStyle(
              color: appColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
