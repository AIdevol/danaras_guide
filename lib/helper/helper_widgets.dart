import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAnotatedRegion extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Color navigationBarColor;
  final Brightness statusBarIconBrightness;
  final Brightness navigationBarIconBrightness;
  final bool hideStatusBar;
  final bool hideNavigationBar;

  const MyAnotatedRegion({
    Key? key,
    required this.child,
    this.statusBarColor = Colors.transparent,
    this.navigationBarColor = Colors.transparent,
    this.statusBarIconBrightness = Brightness.dark,
    this.navigationBarIconBrightness = Brightness.dark,
    this.hideStatusBar = false,
    this.hideNavigationBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarIconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,

        // Navigation bar
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: navigationBarIconBrightness,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          child,
          if (hideStatusBar || hideNavigationBar)
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarContrastEnforced: false,
              ),
              child: const SizedBox(),
            ),
        ],
      ),
    );
  }

  /// Static method to quickly update system UI overlay style
  static void updateSystemUIOverlay({
    Color? statusBarColor,
    Color? navigationBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? navigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarIconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: navigationBarIconBrightness,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  /// Hide or show system overlays
  static void setSystemUIOverlayVisibility({
    bool hideStatusBar = false,
    bool hideNavigationBar = false,
  }) {
    final overlays = <SystemUiOverlay>[];
    
    if (!hideStatusBar) overlays.add(SystemUiOverlay.top);
    if (!hideNavigationBar) overlays.add(SystemUiOverlay.bottom);
    
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: overlays,
    );
  }
}

// Hexcolor declaration that analyse to the hex_color .
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}