import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.primaryLight,
    canvasColor: AppColors.primaryLight,
    textTheme: TextTheme(
      
      titleLarge: TextStyle(
        fontSize: 22,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        color: AppColors.darkGray2,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: AppColors.darkGray2,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.blue,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.darkGray2,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    canvasColor: AppColors.primaryDark,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        color: AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        color: AppColors.darkGray2,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.darkGray2,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
