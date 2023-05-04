import 'package:afisha_admin_panel/db/login_db.dart';
import 'package:afisha_admin_panel/services/routes/app_pages.dart';
import 'package:afisha_admin_panel/services/routes/app_routes.dart';
import 'package:afisha_admin_panel/ui/screens/adds_detail/adds_detail_screen.dart';
import 'package:afisha_admin_panel/ui/screens/login/login_screen.dart';
import 'package:afisha_admin_panel/ui/screens/main/main_screen.dart';
import 'package:afisha_admin_panel/utils/injection_container.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return GetMaterialApp(
      title: 'Afisha Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.blue
      ),
      initialRoute: LoginDb.isRegistered() ?  AppRoutes.main : AppRoutes.login,
      // initialRoute: AppRoutes.addsDetail,
      //home: AddsDetailScreen(),
      getPages: AppPages.getPages,
    );
  }
}
