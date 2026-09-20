import 'package:flutter/material.dart';

class AppTextStyles {

  static const String fontFamily = 'Cairo';

  static TextStyle largeTitle({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w700, // Bold
    color: color,
  );
  static TextStyle sectionTitle({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w600, // SemiBold
    color: color,
  );
  static TextStyle cardTitle({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w600, // SemiBold
    color: color,
  );
  static TextStyle bodyText({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500, // Medium
    color: color,
  );
  static TextStyle caption({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500, // Medium
    color: color,
  );
}