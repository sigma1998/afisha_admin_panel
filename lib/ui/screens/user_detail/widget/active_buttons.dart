import 'package:afisha_admin_panel/controllers/user_detail/user_detail_controller.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveButtons extends StatefulWidget {
  const ActiveButtons({super.key});

  @override
  State<ActiveButtons> createState() => _ActiveButtonsState();
}

class _ActiveButtonsState extends State<ActiveButtons> {
  final controller = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              update('active');
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: isActive() ? AppColors.red : AppColors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                child: Text(
                  'Active',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isActive() ? AppColors.white : AppColors.black),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              update('deactive');
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: isActive() ? AppColors.white : AppColors.red),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                child: Text(
                  'DeActive',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isActive() ? AppColors.black : AppColors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isActive() {
    return controller.model?.status?.startsWith('active') ?? false;
  }

  void update(String s) {
    setState(() {
      controller.model?.status = s;
    });
  }
}
