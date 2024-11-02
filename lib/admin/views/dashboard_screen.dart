import 'package:banaras_guide/admin/controller/dashboard_screen_controller.dart';
import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<DashboardScreenController>(
        init: DashboardScreenController(),
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              constraints.maxHeight - 32, // 32 is total padding
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            SizedBox(height: 20),
                            _buildStatCards(controller),
                            SizedBox(height: 20),
                            _buildCharts(controller),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Admin!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Here\'s your dashboard overview',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards(DashboardScreenController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
        return GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: constraints.maxWidth > 600 ? 1.5 : 2,
          children: [
            _buildStatCard(
              'Total Places',
              '${controller.totalPlaces}',
              Icons.place,
              Colors.blue,
            ),
            _buildStatCard(
              'Total Users',
              '${controller.totalUsers}',
              Icons.people,
              Colors.green,
            ),
            _buildStatCard(
              'Total Reviews',
              '${controller.totalReviews}',
              Icons.star,
              Colors.orange,
            ),
            _buildStatCard(
              'Active Users',
              '${controller.activeUsers}',
              Icons.person,
              Colors.purple,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharts(DashboardScreenController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxWidth > 600 ? 300 : 250,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SfCartesianChart(
                margin: EdgeInsets.zero,
                plotAreaBorderWidth: 0,
                title: const ChartTitle(
                  text: 'Monthly Visitor Statistics',
                  textStyle: TextStyle(fontSize: 14),
                ),
                legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines:
                      MajorGridLines(width: 0.5, color: Colors.grey[300]),
                ),
                series: [
                  LineSeries<VisitorData, String>(
                    name: 'Visitors',
                    dataSource: controller.visitorData,
                    xValueMapper: (VisitorData data, _) => data.month,
                    yValueMapper: (VisitorData data, _) => data.visitors,
                    markerSettings: MarkerSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: constraints.maxWidth > 600 ? 300 : 250,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SfCircularChart(
                margin: EdgeInsets.zero,
                title: const ChartTitle(
                  text: 'Popular Places Categories',
                  textStyle: TextStyle(fontSize: 14),
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  PieSeries<CategoryData, String>(
                    dataSource: controller.categoryData,
                    xValueMapper: (CategoryData data, _) => data.category,
                    yValueMapper: (CategoryData data, _) => data.count,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
