
import 'package:flutter/material.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';

ThemeData getLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: LightColors.whiteColor,
    primaryColor: LightColors.primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: LightColors.whiteColor,
      iconTheme: IconThemeData(color:LightColors.primaryColor),
      actionsIconTheme: IconThemeData(color:LightColors.primaryColor),
      centerTitle: true,
    ),

    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      backgroundColor: LightColors.whiteColor,
      selectedItemColor: LightColors.primaryColor,
      unselectedItemColor: LightColors.lightGrayColor,
      type:BottomNavigationBarType.fixed ,
      elevation: 0,
      selectedLabelStyle:
      TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: const CardTheme(
      color: LightColors.whiteColor,
      surfaceTintColor: LightColors.whiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.zero,
    ),
      buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
      ),
    fontFamily: 'Cairo',
    textTheme: getTextTheme()
  );

}

TextTheme getTextTheme() {
  return const TextTheme(
    labelSmall:  TextStyle(
      color: LightColors.primaryColor,
      fontSize: 10,
      fontWeight: FontWeight.w700,
    ),
    labelMedium:  TextStyle(
      color: LightColors.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: LightColors.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleMedium:  TextStyle(
      color: LightColors.blackColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    titleSmall:  TextStyle(
      color: LightColors.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium:  TextStyle(
      color: LightColors.darkGrayColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    bodySmall:  TextStyle(
      color: LightColors.darkGrayColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    )
  );
}