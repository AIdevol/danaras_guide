import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/core/presentation/controller/explore_screen_controller.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreBanarasScreen extends GetView<ExploreBanarasController> {
  const ExploreBanarasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<ExploreBanarasController>(
        init: ExploreBanarasController(),
        builder: (controller) => CustomScrollView(
          slivers: [
            // Custom App Bar with Search
            SliverAppBar(
              backgroundColor: appColor.withOpacity(0.09),
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Explore Banaras',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1561361513-2d000a50f0dc',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBar(
                  controller: controller.searchController,
                  hintText: "Search places, temples, ghats...",
                  leading: const Icon(Icons.search),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
              ),
            ),

            // Categories
            SliverToBoxAdapter(
              child: _buildCategories(controller),
            ),

            // Featured Places
            SliverToBoxAdapter(
              child: _buildFeaturedPlaces(controller),
            ),

            // Popular Ghats
            SliverToBoxAdapter(
              child: _buildPopularGhats(controller),
            ),

            // Recent Reviews
            SliverToBoxAdapter(
              child: _buildRecentReviews(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(ExploreBanarasController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _categoryCard(
                  "Temples", Icons.temple_hindu, controller.onTempleTap),
              _categoryCard("Ghats", Icons.waves, controller.onGhatsTap),
              _categoryCard("Food", Icons.restaurant, controller.onFoodTap),
              _categoryCard(
                  "Culture", Icons.celebration, controller.onCultureTap),
              _categoryCard(
                  "Shopping", Icons.shopping_bag, controller.onShoppingTap),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: appColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedPlaces(ExploreBanarasController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Featured Places",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _featuredPlaceCard(
                "Kashi Vishwanath Temple",
                "https://i.pinimg.com/736x/9d/cd/8b/9dcd8b10e7912bd6b0fe4205285b44c1.jpg",
                "4.9",
                "The most famous temple in Varanasi",
                controller.onKashiVishwanathTap,
              ),
              _featuredPlaceCard(
                "Dashashwamedh Ghat",
                "https://upload.wikimedia.org/wikipedia/commons/1/17/%E0%A4%A6%E0%A4%B6%E0%A4%BE%E0%A4%B6%E0%A5%8D%E0%A4%B5%E0%A4%AE%E0%A5%87%E0%A4%A7_%E0%A4%98%E0%A4%BE%E0%A4%9F_by_vsv.jpg",
                "4.8",
                "Famous for its spectacular Ganga Aarti",
                controller.onDashashwamedhGhatTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _featuredPlaceCard(
    String title,
    String imageUrl,
    String rating,
    String description,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(rating),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularGhats(ExploreBanarasController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Popular Ghats",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _ghatCard(
                "Assi Ghat",
                "https://images.unsplash.com/photo-1590077428593-a55bb07c4665",
                "4.7",
                controller.onAssiGhatTap,
              ),
              _ghatCard(
                "Manikarnika Ghat",
                "https://images.unsplash.com/photo-1627894006066-12c8276cc428",
                "4.6",
                controller.onManikarnikaGhatTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ghatCard(
    String name,
    String imageUrl,
    String rating,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentReviews(ExploreBanarasController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Recent Reviews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _reviewCard(
              "John Doe",
              "https://images.unsplash.com/photo-1599566150163-29194dcaad36",
              "Amazing experience at Dashashwamedh Ghat! The evening aarti was spectacular.",
              4.8,
              "2 days ago",
            );
          },
        ),
      ],
    );
  }

  Widget _reviewCard(
    String userName,
    String userImage,
    String review,
    double rating,
    String timeAgo,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(rating.toString()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review),
        ],
      ),
    );
  }
}
