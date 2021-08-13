import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/widgets/account_card.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // navigation bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ThemeColors.mainBkgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.nightlight_round,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,16,0),
              child: IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
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
