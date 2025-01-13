import 'package:event_planning/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryLight,
      ),
      primaryColor: AppColors.primaryLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        shape: StadiumBorder(
            side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )),

      // RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50),
        //   side: BorderSide(
        //     color: AppColors.whiteColor,
        //     width: 4,
        //   )
        // ),
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: TextTheme(
        labelLarge: AppStyle.bold20Primary,
        bodyMedium: AppStyle.medium16Black,
        //  headlineMedium: AppStyle.,
        bodySmall: AppStyle.regular14Black,
        labelMedium: AppStyle.medium20Primary),
  );

  static final ThemeData darkTheme = ThemeData(
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      textTheme: TextTheme(
        labelLarge: AppStyle.bold20Primary,
        bodyMedium: AppStyle.medium16White,
        bodySmall: AppStyle.regular14White,
      ),
      scaffoldBackgroundColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryDark),
      primaryColor: AppColors.primaryDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        shape: StadiumBorder(
            side: BorderSide(
          color: AppColors.whiteColor,
          width: 4,
        )),
        // RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50),
        //   side: BorderSide(
        //      color: AppColors.whiteColor,
        //      width: 4,
        //   )
        // ),
      ));
}
