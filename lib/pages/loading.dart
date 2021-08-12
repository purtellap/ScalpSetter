import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scalpsetter/res/colors.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void splashScreen() async {

    await Future.delayed(Duration(seconds: 1), (){});

    Navigator.pushReplacementNamed(context, '/home');

  }

  @override
  void initState() {
    super.initState();
    splashScreen();
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
