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
              splashRadius: Dimens.splashRadius,
              icon: Image.asset('assets/sslogo64.png'),
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
                icon: ImageIcon(AssetImage('assets/google64p.png'), color: ThemeColors.linkColor),
                onPressed: () {
                  Utils.linkPlayStore(context);
                },
              ),
            ),
            Visibility(
              visible: kIsWeb,
              child: IconButton(
                splashRadius: Dimens.splashRadius,
                icon: ImageIcon(AssetImage('assets/appstore64.png'), color: ThemeColors.linkColor),
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
            InfoAlert(),
            IconButton(
              splashRadius: Dimens.splashRadius,
              icon: Icon(
                state.backgroundColor == ThemeColors.backgroundColorDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                color: state.textColor,
              ),
              onPressed: () {
                Utils.changeTheme(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,16,0),
              child: DonateButton(),
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
