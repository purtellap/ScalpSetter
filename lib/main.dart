import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/pages/edit_account.dart';
import 'package:scalpsetter/pages/home.dart';
import 'package:scalpsetter/pages/loading.dart';
import 'package:scalpsetter/res/colors.dart';

import 'account.dart';

void main() {
  runApp(ScalpSetter());
}

class ScalpSetter extends StatelessWidget {

  static List<Account> accounts = [];

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: (){
    //     // hide keyboard when tapping out
    //     SystemChannels.textInput.invokeMethod('TextInput.hide');
    //   },
      return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: ThemeColors.accentColor,
          accentColor: ThemeColors.accentColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ThemeColors.accentColor,
            selectionColor: Color(0x33000000),
            selectionHandleColor: Colors.transparent,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/account': (context) => AccountPage(),
        },
    );
  }
}
