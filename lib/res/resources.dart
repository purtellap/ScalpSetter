import 'dart:ui';
import 'package:flutter/material.dart';

class Keys {
  static const String THEME_PREF = 'themePref';
  static const String ACCENT_PREF = 'accentPref';
  static const String ACCOUNTS_PREF = 'accountsList';
}

class ThemeColors {

  // Dark Theme
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color overlayColorDark = Color(0x11ffffff);
  static const Color textColorDark = Colors.white;
  static const Color secondaryTextColorDark = Colors.grey;

  // Light Theme
  static const Color backgroundColorLight = Color(0xFFfafafa);
  static const Color overlayColorLight = Color(0xffffffff);
  static const Color textColorLight = Color(0xFF121212);
  static const Color secondaryTextColorLight = Color(0xff777777);

  // Long/Short
  static const Color greenColor = Colors.green;
  static const Color redColor = Colors.red;
  static const Color blueColor = Colors.lightBlue;
  static const Color purpleColor = Colors.deepPurpleAccent;

  // Accent Colors
  static const Color amberAccentColor = Colors.amber;
  static const Color underlineColor = Color(0x44000000);
  static const Color selectionColor = Color(0x33000000);
}