import 'package:flutter/material.dart';

String fontFamily = 'NotoSansCJK';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: const Color(0xFF536471),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    error: const Color(0xFFE0245E),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      color: Colors.black.withOpacity(0.9),
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFEFF3F4),
    labelStyle: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: const Color(0xFFEFF3F4),
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: const Color(0xFF71767B),
    onSecondary: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
    error: const Color(0xFFE0245E),
    surfaceVariant: const Color(0xFF2F3336),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      color: Colors.white.withOpacity(0.9),
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFF2F3336),
    labelStyle: TextStyle(
      color: Colors.white,
      fontFamily: fontFamily,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: const Color(0xFF2F3336),
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      disabledBackgroundColor: const Color(0xFF2F3336),
      disabledForegroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
    ),
  ),
);
