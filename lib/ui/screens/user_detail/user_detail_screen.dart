
import 'package:afisha_admin_panel/controllers/user_detail/user_detail_controller.dart';
import 'package:afisha_admin_panel/controllers/users/users_controller.dart';
import 'package:afisha_admin_panel/ui/screens/user_detail/widget/active_buttons.dart';
import 'package:afisha_admin_panel/ui/screens/user_detail/widget/blocked_buttons.dart';
import 'package:afisha_admin_panel/ui/widgets/progres_indicator.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/routes/app_routes.dart';
import '../../../utils/States.dart';

class UserDetailScreen extends StatelessWidget {
  UserDetailScreen({super.key});

  final controller = Get.find<UserDetailController>();
  final userController = Get.find<UsersController>();

  check() {
    if (controller.state == States.loading) return;
    if (controller.state != States.initial) {
      Future.delayed(const Duration(seconds: 3), () {
        controller.setInitial();
      });
    }
  }
  _check() {
    if (controller.state == States.unAuthorizedError) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    check();
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: getAppBar(context),
        body: GetBuilder(
          id: controller.id,
          init: controller,
          builder: (context) {
            return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                  width: double.infinity,
                ),
                getImage(),
                const SizedBox(
                  height: 32,
                  width: double.infinity,
                ),
                getFiled('Full name:', controller.model.fullname),
                getFiled('Username:', controller.model.username),
                getFiled('Phone number:', controller.model.phone),
                getFiled('Address:', controller.model.address),
                getFiled(
                    'ProductNumber:', controller.model.productNumber.toString()),
                getFiled('Role:', controller.model.role.toString()),
                getFiled('Category:', controller.model.adminUserCategory),
                getFiled('Created at:', "2023-03-15"),
                getFiled('Updated at:', "2023-03-15"),
                getFiled('Views:', controller.model.views.toString()),
                const ActiveButtons(),
                SizedBox(
                  height: SizeConfig.calculateVertical(16),
                ),
                const BlockedButtons(),
                getSaveButton()
              ],
            ),
            );
          }
        )
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'User\'s detail',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.black),
          ),
        ],
      ),
      actions: [
        getPopUp(),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }

  getPopUp() {
    return PopupMenuButton(
        color: AppColors.black,
        onSelected: (val) async {},
        itemBuilder: (_) {
          return [
            PopupMenuItem(
              onTap: () async {
                await controller.onDeletePressed().then((value) {
                  if (value == States.loaded) {
                    userController.loadUsers();
                    Get.back();
                  }
                });
              },
              value: 0,
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ];
        });
  }

  getImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        controller.model.avatar == null
            ? Container(
          alignment: Alignment.center,
          width: SizeConfig.calculateHorizontal(160),
          height: SizeConfig.calculateVertical(160),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.person,
              size: SizeConfig.calculateVertical(120),
              color: AppColors.grey,
            ),
          ),
        )
            : Container(
          alignment: Alignment.center,
          width: SizeConfig.calculateHorizontal(160),
          height: SizeConfig.calculateVertical(160),
          decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(controller.model!.avatar!),
                  fit: BoxFit.fill)),
        ),
      ],
    );
  }

  getFiled(String str, String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Text(
              str,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
          ),
          Expanded(
            child: Text(
              text ?? '-------',
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }

  getSaveButton() {
    return GetBuilder(
        init: controller,
        id: controller.id,
        builder: (context) {
          _check();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
            child: InkWell(
              onTap: () {
                controller.onSavePressed();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.blue),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24),
                  child: getWord(),
                ),
              ),
            ),
          );
        });
  }

  getWord() {
    return controller.state == States.loading
        ? const CustomProgressIndicator()
        : controller.state == States.error
        ? getText('Error')
        : controller.state == States.networkError
        ? getText('No internet')
        : controller.state == States.loaded
        ? getText('Saved')
        : getText('Save');
  }

  getText(String str) {
    return Text(
      str,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.white),
    );
  }
}
