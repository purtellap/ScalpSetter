import 'dart:io';

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
  int accountIndex = 0;

  CarouselController accountCarouselController = CarouselController();
  CarouselController cardCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    if(state.accounts.length - 1 < accountIndex){
      accountIndex = state.accounts.length - 1;
    }
    Account currentAccount = state.accounts[accountIndex];
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
            InfoAlert(title: Strings.infoTitle, description: Strings.infoDesc,),
            // IconButton(
            //   splashRadius: Dimens.splashRadius,
            //   icon: Icon(
            //     state.backgroundColor == ThemeColors.backgroundColorDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
            //     color: state.textColor,
            //   ),
            //   onPressed: () {
            //     Utils.changeTheme(context);
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Container(margin: EdgeInsets.fromLTRB(16, 16, 16, 8), child: HomeAccountCard()),
              CarouselSlider(
                carouselController: accountCarouselController,
                options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: .92,
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
                      return HomeAccountCard(i, state.accounts.indexOf(i), accountIndex, accountCarouselController);
                    },
                  );
                }).toList(),
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: cardCarouselController,
                  options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: .92,
                      aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
                    ),
                  items: [0,1].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          // onHorizontalDragEnd: (details){
                          //   if(!(Platform.isAndroid || Platform.isIOS)){
                          //     if(details.primaryVelocity > 200 && i == 1){
                          //       //right
                          //       cardCarouselController.previousPage(curve: Curves.easeIn);
                          //     }
                          //     else if (details.primaryVelocity < -200 && i == 0){
                          //       //left
                          //       cardCarouselController.nextPage(curve: Curves.easeIn);
                          //     }
                          //   }
                          // },
                          onTap: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            cardCarouselController.animateToPage(i, curve: Curves.easeIn);
                          },
                          child: ScalpCard(title: Strings.titles[i], isLong: bools[i], currentAccount: currentAccount,));
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
