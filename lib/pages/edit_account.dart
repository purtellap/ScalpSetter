import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/widgets/fee_input.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';
import 'package:scalpsetter/widgets/leverage_input.dart';
import 'package:scalpsetter/widgets/risk_input.dart';

import '../account.dart';

class AccountPage extends StatefulWidget {

  //Account account;
  //AccountPage(this.account);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String accountName = 'Account 1';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeColors.mainBkgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: ThemeColors.accentColor, //change your color here
          ),
          title: Text('$accountName', style: TextStyle(
            color: ThemeColors.textColor,
          ),),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                color: ThemeColors.overlayColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Expanded(child: TitleText(text: 'Risk Tolerance', color: ThemeColors.accountAccentColor,),),
                          Expanded(child: TitleText(text: 'Leverage', color: ThemeColors.accountAccentColor,)),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(child: RiskInput()),
                          Flexible(child: LeverageInput()),
                        ],
                      ),
                      SizedBox(height: 24,),
                      Row(
                        children: [
                          Expanded(child: TitleText(text: 'Maker Fee', color: ThemeColors.accountAccentColor,),),
                          Expanded(child: TitleText(text: 'Taker Fee', color: ThemeColors.accountAccentColor,)),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(child: FeeInput()),
                          Flexible(child: FeeInput()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              color: ThemeColors.overlayColor,
              child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/account');
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text('ADD NEW ACCOUNT', style: TextStyle(
                            color: ThemeColors.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 20,
                          ),
                        ),
                          ),
                     ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}