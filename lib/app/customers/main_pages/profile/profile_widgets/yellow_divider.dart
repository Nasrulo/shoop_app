import 'package:flutter/material.dart';
import 'package:shoop_app/app/constants/colors/app_colors.dart';

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        thickness: 1,
        color: AppColors.yellow,
      ),
    );
  }
}