import 'package:banaras_guide/constants/const_color.dart';
import 'package:banaras_guide/helper/circle_centric_design.dart';
import 'package:banaras_guide/helper/helper_widgets.dart';
import 'package:banaras_guide/launcher/intro/controller/intro_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class AppIntroScreen extends GetView<IntroScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnotatedRegion(
      child: GetBuilder<IntroScreenController>(
        init: IntroScreenController(),
        builder: (controller) => Scaffold(
          backgroundColor: appColor,
          body: Stack(
            children: [
              // Animated background patterns
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ConcentricCircles(),
              ),
              // Positioned.fill(
              //   child: CustomPaint(
              //     painter: BackgroundPatternPainter(),
              //   ),
              // ),

              // Skip button
              Positioned(
                top: 50,
                right: 20,
                child: TextButton(
                  onPressed: () => controller.skipIntro,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // PageView
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.introContent.length,
                itemBuilder: (context, index) {
                  return _buildIntroPage(
                    controller.introContent[index],
                    index,
                    context,
                  );
                },
              ),

              // Bottom navigation
              Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: _buildBottomNavigation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroPage(
      IntroContent content, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
      child: Column(
        children: [
          // Custom illustration
          Expanded(
            flex: 3,
            child: GetBuilder<IntroScreenController>(
              builder: (controller) {
                final progress = controller.animationProgress.value - index;
                return Transform.scale(
                  scale: 1 - (progress.abs() * 0.3).clamp(0.0, 1.0),
                  child: Opacity(
                    opacity: 1 - progress.abs(),
                    child: CustomIllustration(
                      illustration: content.illustration,
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  content.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  content.description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.introContent.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: controller.currentPage.value == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: controller.currentPage.value == index
                      ? Colors.white
                      : Colors.white38,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 32),

          // Next button with gradient
          Container(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: controller.nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white70],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    controller.currentPage.value ==
                            controller.introContent.length - 1
                        ? 'Get Started'
                        : 'Continue',
                    style: TextStyle(
                      color: appColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIllustration extends StatelessWidget {
  final IntroIllustration illustration;

  const CustomIllustration({required this.illustration});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _getIllustrationPainter(),
      size: Size(double.infinity, 300),
    );
  }

  CustomPainter _getIllustrationPainter() {
    switch (illustration) {
      case IntroIllustration.temple:
        return TemplePainter();
      case IntroIllustration.ritual:
        return RitualPainter();
      case IntroIllustration.culture:
        return CulturePainter();
    }
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Create flowing pattern with circles
    for (int i = 0; i < 5; i++) {
      double offset = i * 100;
      canvas.drawCircle(
        Offset(size.width * 0.2 + offset, size.height * 0.3),
        80 + i * 20,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TemplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw stylized temple
    final path = Path();

    // Base
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.8);

    // Steps
    path.moveTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.lineTo(size.width * 0.7, size.height * 0.8);

    // Dome
    path.moveTo(size.width * 0.3, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width * 0.7,
      size.height * 0.3,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RitualPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw stylized diya and waves
    final path = Path();

    // Diya base
    path.addArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width * 0.3,
        height: size.width * 0.15,
      ),
      0,
      math.pi * 2,
    );

    // Flame
    path.moveTo(size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.2,
    );

    // Waves
    for (int i = 0; i < 3; i++) {
      double yOffset = size.height * 0.7 + (i * 20);
      path.moveTo(size.width * 0.2, yOffset);
      path.quadraticBezierTo(
        size.width * 0.35,
        yOffset - 10,
        size.width * 0.5,
        yOffset,
      );
      path.quadraticBezierTo(
        size.width * 0.65,
        yOffset + 10,
        size.width * 0.8,
        yOffset,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CulturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw stylized musical instruments and patterns
    final path = Path();

    // Veena outline
    path.moveTo(size.width * 0.3, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width * 0.7,
      size.height * 0.4,
    );

    // Circular patterns
    for (int i = 0; i < 3; i++) {
      double xOffset = size.width * (0.35 + (i * 0.15));
      canvas.drawCircle(
        Offset(xOffset, size.height * 0.6),
        20,
        paint,
      );
    }

    // Decorative lines
    for (int i = 0; i < 5; i++) {
      double yOffset = size.height * 0.2 + (i * 20);
      path.moveTo(size.width * 0.4, yOffset);
      path.lineTo(size.width * 0.6, yOffset);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
