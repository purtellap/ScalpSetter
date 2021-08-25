import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalpsetter/pages/layouts/home_desktop.dart';

import '../home.dart';
import 'home_tablet.dart';

class HomeAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 900 && kIsWeb){
          return HomeDesktop();
        }
        else if (constraints.maxWidth > 600) {
          return HomeTablet();
        } else {
          return Home();
        }
      },
    );
  }
}
