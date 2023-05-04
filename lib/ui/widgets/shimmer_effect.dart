import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const CustomShimmerEffect(
      {super.key, required this.width, required this.height, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      //period: const Duration(seconds: 2),
      child: Container(
        width: SizeConfig.calculateHorizontal(width),
        height: SizeConfig.calculateVertical(height),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: AppColors.white),
      ),
    );
  }
}
