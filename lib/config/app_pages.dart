import 'package:banaras_guide/constants/route_strings.dart';
import 'package:banaras_guide/core/app/bindings/bindings.dart';
import 'package:banaras_guide/core/app/views/home_screen.dart';
import 'package:banaras_guide/core/presentation/bindings/bindings.dart';
import 'package:banaras_guide/core/presentation/views/explore_screen.dart';
import 'package:banaras_guide/core/presentation/views/forgot_screen.dart';
import 'package:banaras_guide/core/presentation/views/login_screen.dart';
import 'package:banaras_guide/core/presentation/views/notifications_screen.dart';
import 'package:banaras_guide/core/presentation/views/profile_screen.dart';
import 'package:banaras_guide/core/presentation/views/settings_screen.dart';
import 'package:banaras_guide/core/presentation/views/signup_screen.dart';
import 'package:banaras_guide/launcher/intro/views/intro_screen.dart';
import 'package:banaras_guide/launcher/screen_launcher/bindings/screen_bindings.dart';
import 'package:get/get.dart';

import '../launcher/screen_launcher/views/screen_view.dart';

// part 'route_strings.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;
  static final routes = [
    GetPage(
        name: AppRoutes.splash,
        binding: ScreenBindings(),
        page: () => ScreenViewLauncher()),
    GetPage(
      name: AppRoutes.homepage,
      binding: HomeBinding(),
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      binding: PresentationBindigns(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      binding: PresentationBindigns(),
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotpassword,
      binding: PresentationBindigns(),
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      binding: PresentationBindigns(),
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.exploreScreen,
      binding: PresentationBindigns(),
      page: () => const ExploreBanarasScreen(),
    ),
    GetPage(
      name: AppRoutes.settingsScreen,
      binding: PresentationBindigns(),
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      binding: PresentationBindigns(),
      page: () =>  NotificationsScreen(),
    ),
     GetPage(
      name: AppRoutes.introScreenContent,
      binding: PresentationBindigns(),
      page: () => AppIntroScreen(),
    )
  ];
}
