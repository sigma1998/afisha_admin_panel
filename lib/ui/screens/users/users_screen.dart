import 'package:afisha_admin_panel/controllers/users/users_controller.dart';
import 'package:afisha_admin_panel/services/routes/app_routes.dart';
import 'package:afisha_admin_panel/ui/screens/users/widget/user_item.dart';
import 'package:afisha_admin_panel/ui/widgets/empty_error.dart';
import 'package:afisha_admin_panel/ui/widgets/error.dart';
import 'package:afisha_admin_panel/ui/widgets/network_error.dart';
import 'package:afisha_admin_panel/ui/widgets/shimmer_effect.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/States.dart';
import '../../../values/colors.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final controller = Get.find<UsersController>();

  check() {
    if (controller.state == States.unAuthorizedError) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: GetBuilder(
        init: controller,
        id: controller.id,
        builder: (_) {
          check();
          return SmartRefresher(
            enablePullUp: false,
            enablePullDown: true,
            onRefresh: () {
              controller.loadUsers();
            },
            controller: controller.smartRefController,
            child: SingleChildScrollView(
              child: controller.state == States.loaded
                  ? getList()
                  : controller.state == States.loading
                      ? getLoading()
                      : controller.state == States.networkError
                          ? NetworkError(function: () {controller.loadUsers();})
                          : controller.state == States.empty
                              ? EmptyError(function: () {controller.loadUsers();})
                              : CustomError(
                                  function: () {controller.loadUsers();},
                                ),
            ),
          );
        },
      ),
    );
  }

  getAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.white,
      leadingWidth: 55,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      )),
      leading: SizedBox(
        width: SizeConfig.calculateHorizontal(30),
      ),
      title: GetBuilder(
          id: controller.searchId,
          init: controller,
          builder: (context) {
            return controller.typing
                ? getSearch()
                : Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Users',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          }),
      actions: [
        GestureDetector(
          onTap: () {
            controller.onSearchPressed();
          },
          child: GetBuilder(
              id: controller.searchId,
              init: controller,
              builder: (context) {
                return SizedBox(
                  width: 24,
                  child: controller.typing
                      ? const Icon(
                          Icons.clear,
                          color: AppColors.black,
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                );
              }),
        ),
        getHorSizedBox(26),
      ],
    );
  }

  getSearch() {
    return Container(
      width: controller.typing ? double.infinity : 0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
      ),
    );
  }

  getHorSizedBox(double width) {
    return SizedBox(
      width: width,
    );
  }

  getDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColors.white);
  }

  getList() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.list.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.userDetail,
                  arguments: controller.list[index]);
            },
            child: UserItem(
              user: controller.list[index],
            ),
          );
        });
  }

  getLoading() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        CustomShimmerEffect(
            width: double.infinity,
            height: SizeConfig.calculateVertical(100),
            radius: 0),
        const SizedBox(
          height: 16,
        ),
        CustomShimmerEffect(
            width: double.infinity,
            height: SizeConfig.calculateVertical(100),
            radius: 0),
        const SizedBox(
          height: 16,
        ),
        CustomShimmerEffect(
            width: double.infinity,
            height: SizeConfig.calculateVertical(100),
            radius: 0),
        const SizedBox(
          height: 16,
        ),
        CustomShimmerEffect(
            width: double.infinity,
            height: SizeConfig.calculateVertical(100),
            radius: 0),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
