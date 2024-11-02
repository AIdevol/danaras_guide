import 'package:banaras_guide/constants/const_image.dart';
import 'package:banaras_guide/core/presentation/views/profile_screen.dart';
import 'package:banaras_guide/helper/animation_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
// popular_places_data.dart
  final List<PopularPlace> popularPlacesList = [
    PopularPlace(
      id: '1',
      name: 'Kashi Vishwanath Temple',
      imagePath: kashi,
      rating: 4.8,
      reviewCount: 1200,
      description:
          'One of the most famous Hindu temples dedicated to Lord Shiva',
      location: 'Varanasi, Uttar Pradesh',
    ),
    PopularPlace(
      id: '2',
      name: 'Dashashwamedh Ghat',
      imagePath: kashi,
      rating: 4.6,
      reviewCount: 800,
      description:
          'Main ghat in Varanasi known for its spectacular Ganga Aarti',
      location: 'Varanasi, Uttar Pradesh',
    ),
    PopularPlace(
      id: '3',
      name: 'Assi Ghat',
      imagePath: kashi,
      rating: 4.5,
      reviewCount: 650,
      description:
          'Southernmost ghat in Varanasi, popular among students and locals',
      location: 'Varanasi, Uttar Pradesh',
    ),
    PopularPlace(
      id: '4',
      name: 'Ramnagar Fort',
      imagePath: kashi,
      rating: 4.3,
      reviewCount: 450,
      description: 'Historic fort and museum on the eastern bank of the Ganges',
      location: 'Varanasi, Uttar Pradesh',
    ),
    PopularPlace(
      id: '5',
      name: 'Sarnath',
      imagePath: kashi,
      rating: 4.7,
      reviewCount: 950,
      description:
          'Buddhist pilgrimage site where Buddha first taught the Dharma',
      location: 'Varanasi, Uttar Pradesh',
    ),
  ].obs;
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

class PopularPlace {
  final String id;
  final String name;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final String description;
  final String location;

  PopularPlace({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.location,
  });
}
