// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shoop_app/app/constants/colors/app_colors.dart';
class SnackBarWidget {
  static void snackBar(String text, var _scaffoldKey) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: AppColors.yellow,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}