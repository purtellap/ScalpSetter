import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/pages/edit_account.dart';

import '../home.dart';

class AccountPageWide extends StatefulWidget {

  // final int flexWidth;
  // final int flexHeight;
  // AccountPageWide(this.flexWidth, this.flexHeight);

  @override
  _AccountPageWideState createState() => _AccountPageWideState();
}

class _AccountPageWideState extends State<AccountPageWide> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Container(
      width: double.infinity,
      child: Container(
        width: 600,
        child: AccountPage(),
      ),
    );
  }
}

class AccountPageAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    int widthFlex = -1;
    int heightFlex = -1;
    return LayoutBuilder(
      builder: (context, constraints) {
        double ar = constraints.maxWidth/constraints.maxHeight;
        if(ar > 1){
          return AccountPageWide();
        }
        else{
          return AccountPage();
        }

      },
    );
  }
}
