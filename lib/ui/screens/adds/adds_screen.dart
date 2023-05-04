import 'package:afisha_admin_panel/controllers/advertisment/adds_controller.dart';
import 'package:afisha_admin_panel/services/routes/app_routes.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../services/delete_dialog.dart';
import '../../../utils/States.dart';
import '../../widgets/empty_error.dart';
import '../../widgets/error.dart';
import '../../widgets/main_item.dart';
import '../../widgets/network_error.dart';
import '../../widgets/shimmer_effect.dart';

class AddsScreen extends StatelessWidget {
  AddsScreen({super.key});

  final controller = Get.find<AddsController>();

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
                controller: controller.refreshController,
                enablePullUp: false,
                enablePullDown: true,
                onRefresh: () {
                  controller.loadAdds();
                },
                child: SingleChildScrollView(
                  child: controller.state == States.loaded
                      ? getList(context)
                      : controller.state == States.loading
                          ? getShimmer()
                          : controller.state == States.networkError
                              ? NetworkError(function: () {
                                  controller.loadAdds();
                                })
                              : controller.state == States.empty
                                  ? EmptyError(function: () {
                                      controller.loadAdds();
                                    })
                                  : CustomError(function: () {
                                      controller.loadAdds();
                                    }),
                ),
              );
            }));
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
                              'Adds',
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
        GestureDetector(
            onTap: () {
              //showAddDialog(context);
            },
            child: const SizedBox(
                child: Icon(
              Icons.add,
              color: AppColors.black,
            ))),
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

  getList(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.list.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: SizedBox(
                  height: SizeConfig.calculateVertical(20),
                ),
              ),
              MainItem(
                id: controller.list[index].id,
                name: controller.list[index].category,
                delete: (int id) {
                  showCustomDeleteDialog(context, () async {
                    await controller.onDeletePressed(id).then((value) {
                      if (value == States.loaded) Get.back();
                    });
                  });
                },
                onNamePressed: () {
                  Get.toNamed(AppRoutes.addsDetail,
                      arguments: controller.list[index]);
                },
              ),
            ],
          );
        });
  }

  getShimmer() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.calculateVertical(20),
                ),
                const CustomShimmerEffect(
                    width: double.infinity, height: 56, radius: 10),
              ],
            ),
          );
        });
  }

  check() {
    if (controller.state == States.unAuthorizedError) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }
}
