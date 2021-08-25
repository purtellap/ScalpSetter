import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  static void changeAccentColor(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(Keys.ACCENT_PREF);
    InheritedManager.of(context).changeAccentColors(b);
    prefs.setBool(Keys.ACCENT_PREF, !b);
  }

  static void changeTheme(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(Keys.THEME_PREF);
    InheritedManager.of(context).changeTheme(b);
    prefs.setBool(Keys.THEME_PREF, !b);
  }

  static void linkPlayStore(BuildContext context) async{

  }

  static void linkAppStore(BuildContext context) async{

  }

  static void openWebView(BuildContext context) async{

  }
}