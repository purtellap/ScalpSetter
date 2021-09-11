import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:scalpsetter/utils/utils.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final state = InheritedManager.of(context).state;
    bool isDarkTheme = state.backgroundColor == ThemeColors.backgroundColorDark;
    bool isDefaultAccent = state.longColor == ThemeColors.greenColor;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        //SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            splashRadius: Dimens.splashRadius,
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: state.textColor
          ),
          title: Text('Settings', style: TextStyle(color: state.textColor,),),
          centerTitle: false,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            color: state.overlayColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Row(
                        children: [
                          TitleText(text: Strings.tradeInUSD, color: state.secondaryTextColor,),
                          InfoAlert(title: Strings.tradeTypeTitle, description: Strings.tradeTypeInfo,)
                        ],
                      ),),
                      Flexible(child: Switch(
                        activeColor: state.tradeType ? state.longColor : state.shortColor,
                        value: state.tradeType,
                        onChanged: (value){
                          setState(() {
                            Utils.changeTradeType(context);
                          });
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: TitleText(text: Strings.darkTheme, color: state.secondaryTextColor,),),
                      Flexible(child: Switch(
                        activeColor: isDarkTheme ? state.longColor : state.shortColor,
                        value: isDarkTheme,
                        onChanged: (value){
                          Utils.changeTheme(context);
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: TitleText(text: Strings.coolerColors, color: state.secondaryTextColor,),),
                      Flexible(child: Switch(
                        activeColor: !isDefaultAccent ? state.longColor : state.shortColor,
                        value: !isDefaultAccent,
                        onChanged: (value){
                          setState(() {
                            Utils.changeAccentColor(context);
                          });
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}