import 'package:flutter/material.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

class SnackBarUtils {
  
  static void showSnackBar({required BuildContext context, required String text,int seconds=1,
      required ConfigProvider configProvider,}) {
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: seconds),
      backgroundColor: AppColors.blue,
      content: Text(
        text,
        style: TextStyle(
            color: configProvider.isDark()
                ? AppColors.darkGray2
                : AppColors.white),
      ),
    );
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
  }
}
