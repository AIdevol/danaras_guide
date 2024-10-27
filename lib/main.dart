import 'package:banaras_guide/config/app_pages.dart';
import 'package:banaras_guide/config/init_binidings.dart';
import 'package:banaras_guide/services/auth/app_authenctication_method.dart';
import 'package:banaras_guide/services/custom_toast.dart';
import 'package:banaras_guide/services/custome_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_framework/responsive_framework.dart';

var log = Logger();
GetStorage storage = GetStorage();
CustomLoader customLoader = CustomLoader();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppAuthencticationMethod());
    
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'Banaras Guide',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          if (child == null) return const SizedBox.shrink();
          
          Widget responsiveChild = ResponsiveBreakpoints.builder(
            child: child,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
          return Builder(
            builder: (context) {
              CustomToast.init(context);
              return responsiveChild;
            },
          );
        },
        initialBinding: InitBinidings(),
        logWriterCallback: LoggerX.write,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}

class LoggerX {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => isError ? log.v("$text") : log.i("$text"));
  }
}