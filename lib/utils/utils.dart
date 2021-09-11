import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {

  static void changeAccentColor(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(Keys.ACCENT_PREF);
    InheritedManager.of(context).changeAccentColors(b);
    prefs.setBool(Keys.ACCENT_PREF, !b);
  }

  static void changeTheme(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(Keys.THEME_PREF);
    InheritedManager.of(context).changeTheme(b);
    prefs.setBool(Keys.THEME_PREF, !b);
  }

  static void changeTradeType(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(Keys.TRADE_TYPE_PREF);
    InheritedManager.of(context).changeTradeType(b);
    prefs.setBool(Keys.TRADE_TYPE_PREF, !b);
  }

  static void linkPlayStore(BuildContext context) async{
    //await launch(Strings.googlePlayLink);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Coming soon', style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
          textAlign: TextAlign.center
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black,
    ));
  }

  static void linkAppStore(BuildContext context) async{
    //await launch(Strings.appStoreLink);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Coming soon', style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
          textAlign: TextAlign.center
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black,
    ));
  }

  static void openWebView(BuildContext context) async{
    await launch(Strings.webLink); // yeah
    //await canLaunch(Strings.url) ? await launch(Strings.url) : throw 'Could not launch ${Strings.url}';
  }

}

class InfoAlert extends StatelessWidget {

  final String title;
  final String description;
  InfoAlert({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return IconButton(
        splashRadius: Dimens.splashRadius,
        icon: Icon(
          Icons.info_rounded,
          color: state.textColor,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 600
                  ),
                  child: AlertDialog(
                    title: Text(title, style: TextStyle(color: state.textColor)),
                    content: Text(description,
                      style: TextStyle(color: state.secondaryTextColor),
                    ),
                    backgroundColor: state.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => state.overlayColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(Strings.okay, style: TextStyle(color: ThemeColors.amberAccentColor),),
                        ),
                        onPressed:  () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },);
        }
    );
  }
}

class DonateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return IconButton(
        splashRadius: Dimens.splashRadius,
        icon: Icon(
          Icons.favorite_rounded,
          color: state.textColor,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 600
                  ),
                  child: AlertDialog(
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
                        style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => state.overlayColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(Strings.donoNo, style: TextStyle(color: state.secondaryTextColor),),
                        ),
                        onPressed:  () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => state.overlayColor)),
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
                  ),
                ),
              );
            },);
        }
    );
  }
}

