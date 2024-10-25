import 'package:flutter/material.dart';

class CustomToast {
  // Private constructor to prevent direct instantiation
  CustomToast._();
  
  static CustomToast? _instance;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;
  static BuildContext? _context;

  // Factory constructor for singleton pattern
  factory CustomToast() {
    _instance ??= CustomToast._();
    return _instance!;
  }

  // Initialize the toast service
  static void init(BuildContext context) {
    _context = context;
  }

  // Show toast message with error handling
  static void show(String message) {
    if (_context == null) {
      debugPrint('CustomToast: Context not initialized. Call CustomToast.init() first.');
      return;
    }

    if (!_isVisible) {
      try {
        _overlayEntry = OverlayEntry(
          builder: (_) => _ToastWidget(message: message),
        );

        final overlay = Overlay.of(_context!);
        if (overlay.mounted) {
          overlay.insert(_overlayEntry!);
          _isVisible = true;

          // Auto hide after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            hide();
          });
        }
      } catch (e) {
        debugPrint('CustomToast: Error showing toast - $e');
      }
    }
  }

  // Hide current toast with error handling
  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      try {
        _overlayEntry!.remove();
        _overlayEntry = null;
        _isVisible = false;
      } catch (e) {
        debugPrint('CustomToast: Error hiding toast - $e');
      }
    }
  }

  // Dispose method to clean up resources
  static void dispose() {
    hide();
    _context = null;
    _instance = null;
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;

  const _ToastWidget({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}