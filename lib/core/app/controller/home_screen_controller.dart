import 'package:banaras_guide/core/presentation/views/profile_screen.dart';
import 'package:banaras_guide/helper/animation_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final PageController pageController = PageController();
  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  void navigateToProfile(BuildContext context) {
    changePage(3);
    // Navigator.push(
    //   context,
    //   CustomPageTransition(const ProfileScreen()),
    // );
  }
}
