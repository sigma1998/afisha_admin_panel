import 'package:afisha_admin_panel/network/models/user_personel_model.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  UserPersonalModel user;

  UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16),
      child: Column(
        children: [
          Row(
            children: [
              getImage(),
              const SizedBox(
                width: 8,
              ),
              Expanded(child: getName()),
              getBlocked()
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: AppColors.grey,
            height: 1,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  getImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        user.avatar == null
            ? Container(
                alignment: Alignment.center,
                width: SizeConfig.calculateHorizontal(60),
                height: SizeConfig.calculateVertical(60),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    size: SizeConfig.calculateVertical(40),
                    color: AppColors.grey,
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: SizeConfig.calculateHorizontal(60),
                height: SizeConfig.calculateVertical(60),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(user.avatar!), fit: BoxFit.fill)),
              ),
        user.status?.startsWith('active') ?? false
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  getName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.fullname ?? "------",
          maxLines: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.black),
        ),
        Text(
          user.phone ?? "-------",
          maxLines: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.black),
        ),
        Text(
          user.adminUserCategory ?? "-------",
          maxLines: 1,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.black),
        ),
      ],
    );
  }

  getBlocked() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
          width: 24,
          height: 24,
          child: user.blocked == 'Blocked'
              ? const Icon(
                  Icons.safety_check_outlined,
                  color: AppColors.grey,
                )
              : const SizedBox()),
    );
  }
}
