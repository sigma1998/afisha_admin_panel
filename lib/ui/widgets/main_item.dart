import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget {

  int? id;
  String? name;
  Function delete;
  Function? onNamePressed;

  MainItem({super.key, required this.id, required this.name, required this.delete, this.onNamePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: SizeConfig.calculateVertical(56),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: AppColors.grey, width: 1)),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.calculateHorizontal(16),
            ),
            Expanded(
                child: InkWell(
                  onTap: () {
                    onNamePressed?.call();
                  },
                  child: Text(
              name ?? "no name",
              style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
            ),
                )),
            // InkWell(
            //   onTap: () {
            //     edit(data!.id);
            //   },
            //   child: SizedBox(
            //     width: SizeConfig.calculateHorizontal(24),
            //     height: SizeConfig.calculateVertical(24),
            //     child: const Icon(
            //       Icons.edit,
            //       color: Colors.black45,
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                delete(id);
              },
              child: SizedBox(
                width: SizeConfig.calculateHorizontal(24),
                height: SizeConfig.calculateVertical(24),
                child: const Icon(
                  Icons.delete,
                  color: Colors.black45,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
