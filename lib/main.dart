import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/pages/edit_account.dart';
import 'package:scalpsetter/pages/home.dart';
import 'package:scalpsetter/pages/layouts/settings_adapter.dart';
import 'package:scalpsetter/pages/loading.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/pages/layouts/edit_account_adapter.dart';
import 'package:scalpsetter/pages/layouts/home_adapter.dart';
import 'package:scalpsetter/pages/settings.dart';
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

class ScalpSetter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return StateManager(
          child: Builder(
            builder: (context){
              final state = InheritedManager.of(context).state;
              return MaterialApp(
                title: Strings.title,
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  brightness: Brightness.dark,
                  primaryColor: state.textColor,
                  //colorScheme: ColorScheme(secondary: state.textColor)  state.textColor,
                  accentColor: state.textColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: state.secondaryTextColor,
                    selectionColor: ThemeColors.selectionColor,
                    selectionHandleColor: Colors.transparent,
                  ),
                  //splashColor: state.overlayColor,
                ),
                //initialRoute: '/',
                routes: {
                  '/': (context) => Loading(),
                  '/home': (context) => HomeAdapter(),
                  '/account': (context) => EditAccountAdapter(),
                  '/settings': (context) => SettingsAdapter(),
                },
            );
          }
    ),
        );
  }
}
