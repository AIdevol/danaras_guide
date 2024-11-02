import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/constants/const_image.dart';
import 'package:banaras_guide/constants/const_string.dart';
import 'package:banaras_guide/core/presentation/details_screen/controller/details_screen_controller.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsTempleScreen extends GetView<DetailsScreenController> {
  const DetailsTempleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<DetailsScreenController>(
        init: DetailsScreenController(),
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
              SafeArea(
                child: Column(
                  children: [
                    _buildAppBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _MainContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              // TODO: Implement favorite functionality
            },
          ),
        ],
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTempleImage(),
        _buildTempleDetails(),
      ],
    );
  }

  Widget _buildTempleImage() {
    return Container(
      height: Get.height * 0.4,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          kashi,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTempleDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kashi Vishwanath Temple',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on, 'Varanasi, Uttar Pradesh'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time, 'Open 3:00 AM - 11:00 PM'),
          const SizedBox(height: 16),
          const Text(
            'About',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            kashiStory,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildFacilitiesSection(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Facilities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFacilityItem(Icons.clean_hands, 'Shoe Stand'),
            _buildFacilityItem(Icons.local_parking, 'Parking'),
            _buildFacilityItem(Icons.restaurant, 'Prasad'),
            _buildFacilityItem(Icons.wc, 'Washroom'),
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
