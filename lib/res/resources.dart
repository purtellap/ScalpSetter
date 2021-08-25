import 'dart:ui';
import 'package:flutter/material.dart';

class Keys {
  static const String THEME_PREF = 'themePref';
  static const String ACCENT_PREF = 'accentPref';
  static const String ACCOUNTS_PREF = 'accountsList';
}

class Dimens {
  static const int borderRadius = 16;
  static const double splashRadius = 24;
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

class Strings {
  static const List titles = ['LONG', 'SHORT'];
  static const String errorText = 'Did you fat-finger?';
  static const String liquidated = 'liquidation!';

  static const String copied = 'Copied to clipboard';
  static const String okay = 'Okay';
  static const String yes = 'Yes';
  static const String no = 'No';

  static const String acctMaxTitle = 'Account Limit Reached';
  static const String acctMaxDesc = 'You cannot have more than 8 accounts.';
  static const String acctMinTitle = 'Account Minimum Reached';
  static const String acctMinDesc = 'You must have at least 1 account.';

  static const String deleteTitle = 'Delete Account?';

  static const String btcAddress = '32i8Q9KythnH8KFUrPdNrhPbTTgXE8mB7m';
  static const String donoYes = 'Copy BTC Address';
  static const String donoNo = 'Not today';
  static const String donoTitle = 'Donations Appreciated';
  static const String donoDesc = 'If this app helped you lose money a little slower, feel free to slide some satoshis this way.';
}