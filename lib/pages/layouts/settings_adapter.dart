import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/pages/settings.dart';

import '../home.dart';

class SettingsDesktop extends StatefulWidget {

  @override
  _SettingsDesktopState createState() => _SettingsDesktopState();
}

class _SettingsDesktopState extends State<SettingsDesktop> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Container(
      color: state.backgroundColor,
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 72),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 700,
            ),
            child: Settings(),
          ),
        ),
      ),
    );
  }
}

class SettingsAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 700 && kIsWeb){
          return SettingsDesktop();
        }
        else if (constraints.maxWidth > 600) {
          return Settings();
        } else {
          return Settings();
        }
      },
    );
  }
}
