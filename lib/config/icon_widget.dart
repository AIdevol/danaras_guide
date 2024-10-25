import 'package:banaras_guide/constants/const_image.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(200), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(5, 5),
        ),
      ]),
      child: const CircleAvatar(
        backgroundImage: AssetImage(appIcon),
        radius: 200,
      ),
    );
  }
}
