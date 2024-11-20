import 'package:flutter/material.dart';

const MaterialColor neutralTheme = MaterialColor(
  0xFF1b1b1b,
  <int, Color>{
    50: Color(0xFFF6F6F6),
    100: Color(0xFFE7E7E7),
    200: Color(0xFFD1D1D1),
    300: Color(0xFFB0B0B0),
    400: Color(0xFF888888),
    500: Color(0xFF6D6D6D),
    600: Color(0xFF5D5D5D),
    700: Color(0xFF4F4F4F),
    800: Color(0xFF454545),
    900: Color(0xFF3D3D3D),
    950: Color(0xFF1b1b1b),
  },
);

const MaterialColor redTheme = MaterialColor(
  0xFFCB3A31,
  <int, Color>{
    50: Color(0xFFFDF4F3),
    100: Color(0xFFFCE5E4),
    200: Color(0xFFFAD1CE),
    300: Color(0xFFF5B0AC),
    400: Color(0xFFEE827B),
    500: Color(0xFFE25951),
    600: Color(0xFFCB3A31),
    700: Color(0xFFAD3028),
    800: Color(0xFF8F2B25),
    900: Color(0xFF772A25),
    950: Color(0xFF40120F),
  },
);

const MaterialColor greenTheme = MaterialColor(
  0xFF43936C,
  <int, Color>{
    50: Color(0xFFF1F8F4),
    100: Color(0xFFDCEFE2),
    200: Color(0xFFBCDEC9),
    300: Color(0xFF90C5A8),
    400: Color(0xFF60A782),
    500: Color(0xFF43936C),
    600: Color(0xFF2D6E50),
    700: Color(0xFF245841),
    800: Color(0xFF1F4635),
    900: Color(0xFF1A3A2D),
    950: Color(0xFF0E2019),
  },
);

const MaterialColor yellowTheme = MaterialColor(
  0xFFC4631B,
  <int, Color>{
    50: Color(0xFFFDF8ED),
    100: Color(0xFFF9EBCC),
    200: Color(0xFFF2D495),
    300: Color(0xFFEBBA5E),
    400: Color(0xFFE6A239),
    500: Color(0xFFD57D20),
    600: Color(0xFFC4631B),
    700: Color(0xFFA3451A),
    800: Color(0xFF85371B),
    900: Color(0xFF6E2E19),
    950: Color(0xFF3E160A),
  },
);

const Color blackTheme = Color(0xFF1B1B1B);

final ThemeData theme = ThemeData(
  fontFamily: 'sf-pro-display',
  primarySwatch: neutralTheme,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: neutralTheme).copyWith(
      inversePrimary: Colors.white,
      secondary: neutralTheme[400],
      surface: neutralTheme[50],
      onPrimary: Colors.white,
      onSecondary: Colors.white),
);