import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';

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
//               child: HomeWide(),
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

class HomeAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return HomeTablet();
        } else {
          return Home();
        }
      },
    );
  }
}
