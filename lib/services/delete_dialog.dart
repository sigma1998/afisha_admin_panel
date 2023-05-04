import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';

showCustomDeleteDialog(BuildContext context, Function delete) {
  showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: SizeConfig.calculateVertical(240),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.white),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'You really want to delete this item?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      InkWell(
                        onTap:() {
                          delete.call();
                        },
                        child: Container(
                          width: SizeConfig.calculateHorizontal(150),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: AppColors.blue),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'YES',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
