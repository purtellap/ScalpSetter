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

class HomeDesktop extends StatefulWidget {
  @override
  _HomeDesktopState createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {

  List bools = [true, false];
  CarouselController buttonCarouselController = CarouselController();
  int accountIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    if(state.accounts.length - 1 < accountIndex){
      accountIndex = state.accounts.length - 1;
    }
    Account currentAccount = state.accounts[accountIndex];

    Color footerColor = state.overlayColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // navigation bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Container(
        color: state.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Scaffold(
              backgroundColor: state.backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 72,
                elevation: 0,
                leading: IconButton(
                  splashRadius: Dimens.splashRadius,
                  icon: Image.asset('assets/sslogo64.png'),
                  onPressed: () {
                    Utils.changeAccentColor(context);
                  },
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
                  InfoAlert(title: Strings.infoTitle, description: Strings.infoDesc,),
                  // IconButton(
                  //   splashRadius: Dimens.splashRadius,
                  //   icon: Icon(
                  //     state.backgroundColor == ThemeColors.backgroundColorDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                  //     color: state.textColor,
                  //   ),
                  //   onPressed: () async {
                  //     final prefs = await SharedPreferences.getInstance();
                  //     bool b = prefs.getBool(Keys.THEME_PREF);
                  //     InheritedManager.of(context).changeTheme(b);
                  //     prefs.setBool(Keys.THEME_PREF, !b);
                  //   },
                  // ),
                  DonateButton(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,16,0),
                    child: IconButton(
                      splashRadius: Dimens.splashRadius,
                      icon: Icon(
                        Icons.settings_rounded,
                        color: state.textColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),
                ],
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 900,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 700,
                      ),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Container(margin: EdgeInsets.fromLTRB(16, 16, 16, 8), child: HomeAccountCard()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: IconButton(
                                    splashRadius: Dimens.splashRadius,
                                    icon: Icon(Icons.arrow_back_ios_rounded),
                                    color: accountIndex > 0 ? state.textColor : state.overlayColor,
                                    onPressed: (){
                                      buttonCarouselController.previousPage(curve: Curves.easeIn);
                                    },
                                  ),
                                ),
                                Flexible(
                                  flex: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CarouselSlider(
                                      carouselController: buttonCarouselController,
                                      options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: 1,
                                          height: 100,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              accountIndex = index;
                                            });
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
                                ),
                                Flexible(
                                  child: IconButton(
                                    splashRadius: Dimens.splashRadius,
                                    icon: Icon(Icons.arrow_forward_ios_rounded),
                                    color: accountIndex < state.accounts.length - 1 ? state.textColor : state.overlayColor,
                                    onPressed: (){
                                      buttonCarouselController.nextPage(curve: Curves.easeIn);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 64),
                              child: Row(
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
