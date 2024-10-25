import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreBanarasController extends GetxController {
  final searchController = TextEditingController();

  void onTempleTap() {
    // Navigate to temples list
  }

  void onGhatsTap() {
    // Navigate to ghats list
  }

  void onFoodTap() {
    // Navigate to food spots
  }

  void onCultureTap() {
    // Navigate to cultural experiences
  }

  void onShoppingTap() {
    // Navigate to shopping places
  }

  void onKashiVishwanathTap() {
    // Navigate to Kashi Vishwanath Temple details
  }

  void onDashashwamedhGhatTap() {
    // Navigate to Dashashwamedh Ghat details
  }

  void onAssiGhatTap() {
    // Navigate to Assi Ghat details
  }

  void onManikarnikaGhatTap() {
    // Navigate to Manikarnika Ghat details
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
