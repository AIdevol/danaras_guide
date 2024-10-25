import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CustomLoader {
  static CustomLoader? _loader;
  CustomLoader._createObject();

  factory CustomLoader() {
    if (_loader != null) {
      return _loader!;
    } else {
      _loader = CustomLoader._createObject();
      return _loader!;
    }
  }

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;

  double _size = 100.0;
  Color _primaryColor = const Color(0xFF6C63FF); // Modern primary color
  Color _secondaryColor = const Color(0xFF3F3D56); // Modern secondary color

  void setSize(double size) {
    _size = size;
  }

  void setColors({Color? primary, Color? secondary}) {
    if (primary != null) _primaryColor = primary;
    if (secondary != null) _secondaryColor = secondary;
  }

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withOpacity(0.3),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: buildLoader(),
          ),
        );
      },
    );
  }

  show() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayState = Overlay.of(Get.context!);
      _buildLoader();
      _overlayState!.insert(_overlayEntry!);
    });
  }

  hide() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    } catch (_) {}
  }

  buildLoader({bool isTransparent = false}) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: ModernLoader(
          size: _size,
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
        ),
      ),
    );
  }
}

class ModernLoader extends StatefulWidget {
  final double size;
  final Color primaryColor;
  final Color secondaryColor;

  const ModernLoader({
    Key? key,
    required this.size,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  _ModernLoaderState createState() => _ModernLoaderState();
}

class _ModernLoaderState extends State<ModernLoader>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _ModernLoaderPainter(
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
                progress: _rotationController.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ModernLoaderPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final double progress;

  _ModernLoaderPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Draw background circle
    final backgroundPaint = Paint()
      ..color = secondaryColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    
    canvas.drawCircle(center, radius * 0.8, backgroundPaint);

    // Draw spinning arc
    final spinPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius * 0.8);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * 0.75;

    canvas.drawArc(
      rect,
      startAngle + (2 * math.pi * progress),
      sweepAngle,
      false,
      spinPaint,
    );

    // Draw dots
    final dotPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 3; i++) {
      final angle = startAngle + (2 * math.pi * progress) + (i * math.pi / 8);
      final dotCenter = Offset(
        center.dx + radius * 0.8 * math.cos(angle),
        center.dy + radius * 0.8 * math.sin(angle),
      );
      canvas.drawCircle(dotCenter, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_ModernLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}