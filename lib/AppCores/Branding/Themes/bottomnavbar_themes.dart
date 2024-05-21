import 'package:flutter/material.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Branding/appcolors.dart';

class AppBottomNavBarThemes {
  AppBottomNavBarThemes._();

  static BottomNavigationBarThemeData darkBg(
      BuildContext context, bool isDark) {
    return BottomNavigationBarThemeData(
      selectedLabelStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: AppColors.textDarkTheme),
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: AppColors.textVaraiantDarkTheme),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        color: AppColors.iconsDarkTheme,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.iconsVaraintDarkTheme,
      ),
      selectedItemColor: AppColors.textDarkTheme,
      unselectedItemColor: AppColors.textVaraiantDarkTheme,
      backgroundColor: Colors.greenAccent,
    );
  }
}
