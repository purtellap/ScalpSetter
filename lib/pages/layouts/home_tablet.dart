import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:scalpsetter/utils/utils.dart';
import 'package:scalpsetter/widgets/account_card.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../account.dart';

class HomeTablet extends StatefulWidget {
  @override
  _HomeTabletState createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {

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
              splashRadius: Dimens.splashRadius,
              icon: Image.asset('assets/sslogo.png'),
              onPressed: () {
                Utils.changeAccentColor(context);
              },
            ),
          ),
          actions: [
            Visibility(
              visible: kIsWeb,
              child: IconButton(
                splashRadius: Dimens.splashRadius,
                icon: ImageIcon(AssetImage('assets/google.png'), color: ThemeColors.linkColor),
                onPressed: () {
                  Utils.linkPlayStore(context);
                },
              ),
            ),
            Visibility(
              visible: kIsWeb,
              child: IconButton(
                splashRadius: Dimens.splashRadius,
                icon: ImageIcon(AssetImage('assets/ios.png'), color: ThemeColors.linkColor),
                onPressed: () {
                  Utils.linkAppStore(context);
                },
              ),
            ),
            Visibility(
              visible: !kIsWeb,
              child: IconButton(
                splashRadius: Dimens.splashRadius,
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  color: ThemeColors.linkColor,
                ),
                onPressed: () {
                  Utils.openWebView(context);
                },
              ),
            ),
            IconButton(
              splashRadius: Dimens.splashRadius,
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
                  splashRadius: Dimens.splashRadius,
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
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(Strings.donoNo, style: TextStyle(color: state.secondaryTextColor),),
                              ),
                              onPressed:  () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(Strings.donoYes, style: TextStyle(color: ThemeColors.amberAccentColor),),
                              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CarouselSlider(
                  options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: .98,
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: ScalpCard(title: Strings.titles[0], isLong: bools[0], currentAccount: currentAccount,)
                      ),
                      Flexible(
                        child: ScalpCard(title: Strings.titles[1], isLong: bools[1], currentAccount: currentAccount,)
                      ),
                    ],
                  ),
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
