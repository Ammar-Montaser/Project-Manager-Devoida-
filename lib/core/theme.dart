import 'package:flutter/material.dart';
import 'package:project_manager/core/app_pallete.dart';
import 'package:project_manager/core/size.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: LightTheme.backgroundColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: fontSize.largeHeadingFontSize,
        fontWeight: FontWeight.bold,
        color: LightTheme.primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSize.largeBodyFontSize,
        color: LightTheme.primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize.mediumBodyFontSize,
        color: LightTheme.primaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        color: LightTheme.primaryColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      labelStyle: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        fontWeight: FontWeight.normal,
        color: LightTheme.primaryColor,
      ),
      hintStyle: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        fontWeight: FontWeight.normal,
        color: LightTheme.primaryColor,
      ),
      prefixIconColor: LightTheme.brandingColor,
      border: InputBorder.none,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        backgroundColor: MaterialStatePropertyAll(LightTheme.brandingColor),
        foregroundColor:
            MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
              fontSize: fontSize.mediumBodyFontSize,
              fontWeight: FontWeight.bold),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    ),
    // chipTheme: ChipThemeData(
    //   color: MaterialStatePropertyAll(LightTheme.secondaryColor),
    //   selectedColor: LightTheme.brandingColor,
    //   side: BorderSide.none,
    // ),
  );
}
