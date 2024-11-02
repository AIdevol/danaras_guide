import 'package:banaras_guide/core/presentation/controller/calander_view_controller.dart';
import 'package:banaras_guide/core/presentation/controller/explore_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/favourite_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/forgot_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/login_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/notifications_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/profile_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/settings_screen_controller.dart';
import 'package:banaras_guide/core/presentation/controller/signup_screen_controller.dart';
import 'package:banaras_guide/core/presentation/details_screen/controller/details_screen_controller.dart';
import 'package:get/get.dart';

class PresentationBindigns extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<SignupScreenController>(() => SignupScreenController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<ExploreBanarasController>(() => ExploreBanarasController());
    Get.lazyPut<SettingsScreenController>(() => SettingsScreenController());
    Get.lazyPut<FavouriteScreenController>(() => FavouriteScreenController());
    Get.lazyPut<NotificationsScreenController>(() => NotificationsScreenController());
    Get.lazyPut<DetailsScreenController>(() => DetailsScreenController());
    Get.lazyPut<CalanderViewController>(() => CalanderViewController());
  }
}
