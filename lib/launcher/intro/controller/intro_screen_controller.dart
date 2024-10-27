import 'package:banaras_guide/config/app_pages.dart';
import 'package:banaras_guide/constants/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;
  var animationProgress = 0.0.obs;

  List<IntroContent> introContent = [
    IntroContent(
      title: "Welcome to Banaras",
      description:
          "Discover the spiritual heart of India through our curated experiences",
      illustration: IntroIllustration.temple,
    ),
    IntroContent(
      title: "Sacred Experiences",
      description:
          "Explore ancient temples and witness the magical Ganga Aarti",
      illustration: IntroIllustration.ritual,
    ),
    IntroContent(
      title: "Local Culture",
      description:
          "Immerse yourself in the rich traditions and authentic flavors",
      illustration: IntroIllustration.culture,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Add animation listener to PageController
    pageController.addListener(() {
      if (pageController.position.haveDimensions) {
        animationProgress.value = pageController.page ?? 0;
        update();
      }
    });
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    update();
  }

  void skipIntro() => Get.offAllNamed(AppRoutes.login);

  void nextPage() {
    if (currentPage.value == introContent.length - 1) {
      skipIntro();
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

enum IntroIllustration { temple, ritual, culture }

class IntroContent {
  final String title;
  final String description;
  final IntroIllustration illustration;

  IntroContent({
    required this.title,
    required this.description,
    required this.illustration,
  });
}
