import 'package:afisha_admin_panel/services/routes/app_routes.dart';
import 'package:afisha_admin_panel/ui/screens/adds_detail/adds_detail_screen.dart';
import 'package:afisha_admin_panel/ui/screens/login/login_screen.dart';
import 'package:afisha_admin_panel/ui/screens/main/main_screen.dart';
import 'package:afisha_admin_panel/ui/screens/user_detail/user_detail_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final getPages = [
    GetPage(name:  AppRoutes.login, page: () => LoginScreen()),
    GetPage(name:  AppRoutes.main, page: () => const MainScreen()),
    GetPage(name:  AppRoutes.userDetail, page: () =>  UserDetailScreen()),
    GetPage(name:  AppRoutes.addsDetail, page: () =>  AddsDetailScreen()),
  ];
}