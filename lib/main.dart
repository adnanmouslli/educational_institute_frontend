import 'package:education_managment/utils/app_routes.dart';
import 'package:education_managment/utils/app_theme.dart';
import 'package:education_managment/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      textDirection: TextDirection.rtl,
      getPages: AppRoutes.namedRoutes,
      initialRoute: RouteWrapper.getInitialRoute,
      defaultTransition: Transition.fadeIn,
    );
  }
}
