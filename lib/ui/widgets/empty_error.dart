
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';

class EmptyError extends StatelessWidget {
  Function function;

  EmptyError({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.calculateVertical(150),
        ),
        const Text(
          'No data',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: SizeConfig.calculateVertical(20),
        ),
        InkWell(
          onTap: () {function.call();},
          child: SizedBox(
            height: SizeConfig.calculateVertical(20),
            width: SizeConfig.calculateHorizontal(20),
            child: const Icon(Icons.refresh, color: AppColors.black,),
          ),
        )
      ],
    );
  }
}
