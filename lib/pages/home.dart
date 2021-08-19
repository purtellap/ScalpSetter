import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:scalpsetter/widgets/account_card.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List titles = ['LONG', 'SHORT'];
  List bools = [true, false];

  Account currentAccount = ScalpSetter.accounts[0];

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // navigation bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: state.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: state.textColor,
              ),
              onPressed: () async {

              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.nightlight_round,
                color: state.textColor,
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                bool b = prefs.getBool(Keys.THEME_PREF);
                InheritedManager.of(context).changeTheme(b);
                prefs.setBool(Keys.THEME_PREF, !b);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite_rounded,
                color: state.textColor,
              ),
              onPressed: () {
                // do something
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,16,0),
              child: IconButton(
                icon: Icon(
                  Icons.invert_colors_on_rounded,
                  color: state.textColor,
                ),
                onPressed: () async{
                  final prefs = await SharedPreferences.getInstance();
                  bool b = prefs.getBool(Keys.ACCENT_PREF);
                  InheritedManager.of(context).changeAccentColors(b);
                  prefs.setBool(Keys.ACCENT_PREF, !b);
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Container(margin: EdgeInsets.fromLTRB(16, 16, 16, 8), child: HomeAccountCard()),
              CarouselSlider(
                options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: .92,
                  height: 100,
                  onPageChanged: (index, reason) {
                    setState(() {currentAccount = ScalpSetter.accounts[index];});
                  }
                ),
                items: ScalpSetter.accounts.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return HomeAccountCard(i);
                    },
                  );
                }).toList(),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: .92,
                      aspectRatio: 1/MediaQuery.of(context).devicePixelRatio,
                    ),
                  items: [0,1].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ScalpCard(title: titles[i], isLong: bools[i], currentAccount: currentAccount,);
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              //Expanded(child: ScalpCard(title: 'LONG', isLong: true,)),
            ],
          ),
        ),
      ),
    );
  }
}
