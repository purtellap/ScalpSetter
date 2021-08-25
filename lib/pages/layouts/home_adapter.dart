import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/pages/layouts/home_desktop.dart';

import '../home.dart';
import 'home_tablet.dart';

// class HomeWideWrapper extends StatefulWidget {
//
//   @override
//   _HomeWideWrapperState createState() => _HomeWideWrapperState();
// }
//
// class _HomeWideWrapperState extends State<HomeWideWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final state = InheritedManager.of(context).state;
//     return Container(
//       color: state.backgroundColor,
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 1,
//               child: SizedBox(),
//           ),
//           Expanded(
//               flex: 2,
//               child: HomeTablet(),
//           ),
//           Expanded(
//               flex: 1,
//               child: SizedBox(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeWideWrapper extends StatefulWidget {

  @override
  _HomeWideWrapperState createState() => _HomeWideWrapperState();
}

class _HomeWideWrapperState extends State<HomeWideWrapper> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Container(
      color: state.backgroundColor,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 900,
              maxHeight: 700
            ),
            child: HomeTablet(),
          ),
        ),
      ),
    );
  }
}

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
