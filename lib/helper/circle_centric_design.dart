import 'package:banaras_guide/constants/const_color.dart';
import 'package:flutter/material.dart';

class ConcentricCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outermost Circle
        CircleContainer(size: 400, color: appColor.withOpacity(0.5)),
        // Middle Circle
        CircleContainer(size: 300, color: appColor.withOpacity(0.4)),
        // Inner Circle
        CircleContainer(size: 200, color: appColor.withOpacity(0.3)),
        // Core Circle
        CircleContainer(size: 100, color: appColor.withOpacity(0.2)),
      ],
    );
  }
}

class CircleContainer extends StatelessWidget {
  final double size;
  final Color color;

  CircleContainer({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(0, 8), // Changes the shadow position
          ),
        ],
      ),
    );
  }
}
