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
      ));

  static final ThemeData darkTheme = ThemeData(
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
