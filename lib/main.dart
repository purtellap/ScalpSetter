import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/pages/edit_account.dart';
import 'package:scalpsetter/pages/home.dart';
import 'package:scalpsetter/pages/loading.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';

import 'account.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ScalpSetter());
}

// void main() {
//   runApp(ScalpSetter());
// }

class ScalpSetter extends StatelessWidget {

  static List<Account> accounts = [];

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: (){
    //     // hide keyboard when tapping out
    //     SystemChannels.textInput.invokeMethod('TextInput.hide');
    //   },
    //   return AccountsList(
    //     accounts: [],
    //     child:
        return StateManager(
          child: Builder(
            builder: (context){
              final state = InheritedManager.of(context).state;
              return MaterialApp(
                theme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: state.textColor,
                  accentColor: state.textColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: state.secondaryTextColor,
                    selectionColor: ThemeColors.selectionColor,
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
    ),
        );
  }
}
