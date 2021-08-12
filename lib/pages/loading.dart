import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scalpsetter/account.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/utils/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  SharedPref sharedPref = SharedPref();

  loadAccounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // oh my
      ScalpSetter.accounts = List<Account>.from(json.decode(prefs.getString('accountsList')).map((i) => Account.fromJson(i)));

      print(ScalpSetter.accounts[0].name);

    } catch (e) {
      print(e.toString());
      ScalpSetter.accounts.add(Account.defaultAccount(1));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('accountsList', json.encode(ScalpSetter.accounts));
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBkgColor,
      body: SafeArea(
        child: Center(
          child: SpinKitChasingDots(
            color: ThemeColors.accentColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
