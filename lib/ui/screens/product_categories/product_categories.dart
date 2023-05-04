import 'package:afisha_admin_panel/controllers/product_category/product_categories.dart';
import 'package:afisha_admin_panel/services/delete_dialog.dart';
import 'package:afisha_admin_panel/ui/widgets/empty_error.dart';
import 'package:afisha_admin_panel/ui/widgets/error.dart';
import 'package:afisha_admin_panel/ui/widgets/main_item.dart';
import 'package:afisha_admin_panel/ui/widgets/network_error.dart';
import 'package:afisha_admin_panel/ui/widgets/progres_indicator.dart';
import 'package:afisha_admin_panel/ui/widgets/shimmer_effect.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/utils/States.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../services/routes/app_routes.dart';
import '../../../values/colors.dart';

class ProductCategories extends StatelessWidget {
  ProductCategories({super.key});

  final controller = Get.find<ProductCategoriesController>();

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
              controller: controller.refreshController,
              onRefresh: () {
                controller.loadCategories();
              },
              child: SingleChildScrollView(
                child: controller.state == States.loaded
                    ? getList()
                    : controller.state == States.loading ||
                            controller.state == States.initial
                        ? getShimmer()
                        : controller.state == States.networkError
                            ? NetworkError(function: () {
                                controller.loadCategories();
                              })
                            : controller.state == States.empty
                                ? EmptyError(function: () {
                                    controller.loadCategories();
                                  })
                                : CustomError(function: () {
                                    controller.loadCategories();
                                  }),
              ),
            );
          }),
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
                              'Product categories',
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
              showAddDialog(context);
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

  getList() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
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
                name: controller.list[index].name,
                delete: (int id) {
                  showCustomDeleteDialog(context, () async {
                    await controller.onDeletePressed(id);
                      Get.back();
                  });
                },
              ),
            ],
          );
        });
  }

  showAddDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.calculateHorizontal(24),
                  right: SizeConfig.calculateHorizontal(24),
                  //top: SizeConfig.calculateVertical(200)
                ),
                child: Container(
                  width: double.infinity,
                  decoration: getDialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border: Border.all(color: AppColors.black),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  controller: controller.addController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.calculateVertical(40),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8),
                            child: InkWell(
                              onTap: () async {
                                final res = await controller.onSavedPressed();
                                if (res == States.loaded) {
                                  controller.loadCategories();
                                  Get.back();
                                }
                                //check(res, context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: GetBuilder(
                                    init: controller,
                                    id: controller.addId,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: controller.addState ==
                                                  States.loading
                                              ? const CustomProgressIndicator()
                                              : const Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: AppColors.white),
                                                ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'BACK',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  getDialogDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.white);
  }
}
