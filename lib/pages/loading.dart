import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scalpsetter/account.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:scalpsetter/utils/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  SharedPref sharedPref = SharedPref();

  bool setPref(SharedPreferences prefs, String key){
    prefs.setBool(key, true);
    //print('inserting preferences for: ' + key);
    return true;
  }

  loadColors(BuildContext context) async {
    // too lazy to write new methods. just using change method to update colors
    final prefs = await SharedPreferences.getInstance();
    InheritedManager.of(context).changeTheme(!(prefs.getBool(Keys.THEME_PREF) ?? setPref(prefs, Keys.THEME_PREF)));
    InheritedManager.of(context).changeAccentColors(!(prefs.getBool(Keys.ACCENT_PREF) ?? setPref(prefs, Keys.ACCENT_PREF)));
  }

  loadAccounts(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // oh my
      ScalpSetter.accounts = List<Account>.from(json.decode(prefs.getString(Keys.ACCOUNTS_PREF)).map((i) => Account.fromJson(i)));

    } catch (e) {
      print(e.toString());
      ScalpSetter.accounts.add(Account.defaultAccount(1));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(Keys.ACCOUNTS_PREF, json.encode(ScalpSetter.accounts));
    }
  }

  load() async {
    // ????
    await loadColors(context);
    await loadAccounts(context);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Scaffold(
      backgroundColor: state.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(140),
            child: Image.asset('assets/sslogo.png'),
          ),
          // child: SpinKitChasingDots(
          //   color: ThemeColors.accentColor,
          //   size: 50,
          // ),
        ),
      ),
    );
  }
}
