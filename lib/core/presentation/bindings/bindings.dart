import 'package:banaras_guide/core/presentation/controller/explore_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/forgot_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/login_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/profile_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/signup_screen_controller.dart';
import 'package:get/get.dart';

class PresentationBindigns extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<SignupScreenController>(() => SignupScreenController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
     Get.lazyPut<ExploreBanarasController>(() => ExploreBanarasController());
  }
}
