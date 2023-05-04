
import 'package:afisha_admin_panel/controllers/user_detail/user_detail_controller.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedButtons extends StatefulWidget {
  const BlockedButtons({super.key});

  @override
  State<BlockedButtons> createState() => _BlockedButtonsState();
}

class _BlockedButtonsState extends State<BlockedButtons> {
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
              update('Unblocked');
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
                  'Unblocked',
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
              update('Blocked');
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
                  'Blocked',
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
    return controller.model?.blocked?.startsWith('Unblocked') ?? false;
  }

  void update(String s) {
    setState(() {
      controller.model?.blocked = s;
    });
  }
}
