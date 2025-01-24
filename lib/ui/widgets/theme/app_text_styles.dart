import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';

abstract class AppTextStyles {
  static const auth = TextStyle(
    fontSize: 16,
    color: AppColors.black,
  );
  static const authlink = TextStyle(
    fontSize: 16,
    color: AppColors.lightBlue,
    decoration: TextDecoration.none,
  );
  static const reset = TextStyle(
    color: AppColors.lightBlue,
    fontWeight: FontWeight.w400,
  );
  static const login = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static const error = TextStyle(
    color: Colors.red,
  );
}
