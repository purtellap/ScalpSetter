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

  List bools = [true, false];

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    Account currentAccount = state.accounts[0];
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
                Icons.thermostat_rounded,
                color: state.textColor,
              ),
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                bool b = prefs.getBool(Keys.ACCENT_PREF);
                InheritedManager.of(context).changeAccentColors(b);
                prefs.setBool(Keys.ACCENT_PREF, !b);
              },
            ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,16,0),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_rounded,
                  color: state.textColor,
                ),
                onPressed: () {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(Strings.donoTitle, style: TextStyle(color: state.textColor)),
                    content: Text(Strings.donoDesc,
                      style: TextStyle(color: state.secondaryTextColor),
                    ),
                    backgroundColor: state.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    actions: [
                      TextButton(
                        child: Text(Strings.donoNo, style: TextStyle(color: state.secondaryTextColor),),
                        onPressed:  () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(Strings.donoYes, style: TextStyle(color: ThemeColors.amberAccentColor),),
                        onPressed:  () {
                          Clipboard.setData(ClipboardData(text: Strings.btcAddress));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(Strings.copied, style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                                textAlign: TextAlign.center
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.black,
                          ));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },);
                }
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
                    setState(() {currentAccount = state.accounts[index];});
                  }
                ),
                items: state.accounts.map((i) {
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
                      aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
                    ),
                  items: [0,1].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ScalpCard(title: Strings.titles[i], isLong: bools[i], currentAccount: currentAccount,);
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
