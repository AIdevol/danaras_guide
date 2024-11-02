import 'package:get/get.dart';

class DashboardScreenController extends GetxController {
  int totalPlaces = 0;
  int totalUsers = 0;
  int totalReviews = 0;
  int activeUsers = 0;

  List<VisitorData> visitorData = [];
  List<CategoryData> categoryData = [];

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void fetchDashboardData() {
    // TODO: Implement API calls to fetch dashboard data
    // For now, using dummy data
    totalPlaces = 150;
    totalUsers = 1000;
    totalReviews = 450;
    activeUsers = 250;

    visitorData = [
      VisitorData('Jan', 1000),
      VisitorData('Feb', 1200),
      VisitorData('Mar', 1500),
      VisitorData('Apr', 1300),
      VisitorData('May', 1800),
    ];

    categoryData = [
      CategoryData('Temples', 50),
      CategoryData('Ghats', 30),
      CategoryData('Restaurants', 25),
      CategoryData('Hotels', 20),
      CategoryData('Museums', 15),
    ];
  }
}


class VisitorData {
  final String month;
  final int visitors;

  VisitorData(this.month, this.visitors);
}

class CategoryData {
  final String category;
  final int count;

  CategoryData(this.category, this.count);
}
