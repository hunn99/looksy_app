import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

const String typeFace = "sf-pro-display";

const Map<String, FontWeight> fontWeight = {
  "Regular": FontWeight.w400,
  "Medium": FontWeight.w500,
  "SemiBold": FontWeight.w600,
  "Bold": FontWeight.w700
};

TextStyle heading1 = TextStyle(
  fontFamily: typeFace,
  color: Colors.white,
  fontWeight: fontWeight["Medium"],
  fontSize: 44,
  letterSpacing: -2,
);

TextStyle heading2Black = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 32,
  letterSpacing: -2,
);

TextStyle heading2White = TextStyle(
  fontFamily: typeFace,
  color: Colors.white,
  fontWeight: fontWeight["Medium"],
  fontSize: 32,
  letterSpacing: -2,
);

TextStyle heading3Black = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 24,
  letterSpacing: 0,
);

TextStyle heading4Black = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["SemiBold"],
  fontSize: 20,
  letterSpacing: 0,
);

TextStyle heading4 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 18,
  letterSpacing: -2,
);

TextStyle bodyGrey1 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme[300],
  fontWeight: fontWeight["Medium"],
  fontSize: 16,
);

TextStyle bodyGrey2 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme[300],
  fontWeight: fontWeight["Medium"],
  fontSize: 14,
);

TextStyle bodyGrey3 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme[200],
  fontWeight: fontWeight["Medium"],
  fontSize: 16,
);

TextStyle bodyBlack1 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 16,
);
TextStyle bodyWhite1 = TextStyle(
  fontFamily: typeFace,
  color: Colors.white,
  fontWeight: fontWeight["Medium"],
  fontSize: 16,
);

TextStyle bodyBlack2 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 14,
);

TextStyle bodyBlack3 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Bold"],
  fontSize: 12,
);

TextStyle bodyBlack4 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Medium"],
  fontSize: 12,
);

TextStyle bodyBlack5 = TextStyle(
  fontFamily: typeFace,
  color: neutralTheme,
  fontWeight: fontWeight["Bold"],
  fontSize: 14,
);
