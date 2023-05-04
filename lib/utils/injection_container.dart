import 'package:afisha_admin_panel/controllers/adds_detail/adds_detail_controller.dart';
import 'package:afisha_admin_panel/controllers/advertisment/adds_controller.dart';
import 'package:afisha_admin_panel/controllers/login/login_controller.dart';
import 'package:afisha_admin_panel/controllers/product_category/product_categories.dart';
import 'package:afisha_admin_panel/controllers/user_category/user_category_controller.dart';
import 'package:afisha_admin_panel/controllers/user_detail/user_detail_controller.dart';
import 'package:afisha_admin_panel/controllers/users/users_controller.dart';
import 'package:afisha_admin_panel/db/login_db.dart';
import 'package:afisha_admin_panel/network/dio_interceptors.dart';
import 'package:afisha_admin_panel/network/network_info.dart';
import 'package:afisha_admin_panel/repo/login_repo.dart';
import 'package:afisha_admin_panel/repo/repo.dart';
import 'package:afisha_admin_panel/ui/screens/user_detail/user_detail_screen.dart';
import 'package:afisha_admin_panel/values/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> init() async {
  LoginDb.init();

  final baseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json; charset=utf-8');

  final loginDio = Dio(baseOptions);
  final dio = addInterceptor(Dio(baseOptions));

  ///network info
  Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(
          connectivity: Connectivity(),
          dataChecker: InternetConnectionChecker()),
      fenix: true);

  ///repositories
  Get.lazyPut<LoginRepo>(
      () => LoginRepo(dio: loginDio, networkInfo: Get.find()),
      fenix: true);
  Get.lazyPut<Repo>(() => Repo(dio: dio, networkInfo: Get.find()), fenix: true);

  ///controllers
  Get.lazyPut<LoginController>(() => LoginController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<UserCategoryController>(() => UserCategoryController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<UsersController>(() => UsersController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<UserDetailController>(() => UserDetailController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<ProductCategoriesController>(() => ProductCategoriesController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<AddsController>(() => AddsController(repo: Get.find()),
      fenix: true);
  Get.lazyPut<AddsDetailController>(() => AddsDetailController(repo: Get.find()),
      fenix: true);
}
