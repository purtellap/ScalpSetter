import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/pages/edit_account.dart';

import '../home.dart';

class EditAccountDesktop extends StatefulWidget {

  @override
  _EditAccountDesktopState createState() => _EditAccountDesktopState();
}

class _EditAccountDesktopState extends State<EditAccountDesktop> {
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
            child: EditAccount(),
          ),
        ),
      ),
    );
  }
}

class EditAccountAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 700 && kIsWeb){
          return EditAccountDesktop();
        }
        else if (constraints.maxWidth > 600) {
          return EditAccount();
        } else {
          return EditAccount();
        }
      },
    );
  }
}
