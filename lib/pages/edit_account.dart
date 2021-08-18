import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/widgets/fee_input.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';
import 'package:scalpsetter/widgets/leverage_input.dart';
import 'package:scalpsetter/widgets/risk_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account.dart';
import '../main.dart';

class AccountPage extends StatefulWidget {

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  bool typing = false;

  save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accountsList', json.encode(ScalpSetter.accounts));
  }

  addAccount() async{
    if(ScalpSetter.accounts.length < 8){
      Account newAccount = Account.defaultAccount(ScalpSetter.accounts.length + 1);
      ScalpSetter.accounts.add(newAccount);
      save();
      Navigator.pushReplacementNamed(context, '/account', arguments: {'account' : newAccount});
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Account Limit Reached"),
            content: Text('You cannot have more than 8 accounts.', style: TextStyle(color: ThemeColors.secondaryTextColor),),
            backgroundColor: ThemeColors.mainBkgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            actions: [
              TextButton(
                child: Text("Okay", style: TextStyle(color: ThemeColors.textColor),),
                onPressed:  () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  removeAccount(account) async{
    if(ScalpSetter.accounts.length > 1){
      ScalpSetter.accounts.remove(account);
      save();
      Navigator.pop(context);
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Account Minimum Reached"),
            content: Text('You must have at least 1 account.', style: TextStyle(color: ThemeColors.secondaryTextColor),),
            backgroundColor: ThemeColors.mainBkgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            actions: [
              TextButton(
                child: Text("Okay", style: TextStyle(color: ThemeColors.textColor),),
                onPressed:  () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Account account;
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) account = arguments['account'];

    return WillPopScope(
      onWillPop:  () async {
        save();
        Navigator.pop(context, true);
        return true;
      },
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
          //SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ThemeColors.mainBkgColor,
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_rounded),
            //   onPressed: () {
            //     print('saving...');
            //     Navigator.pop(context);
            //   },
            // ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: ThemeColors.accentColor,
            ),
            title: typing ? TextFormField(
              initialValue: account.name,
              autocorrect: false,
              enableSuggestions: false,
              cursorColor: ThemeColors.accentColor,
              //maxLength: 25,
              inputFormatters: [LengthLimitingTextInputFormatter(18),],
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.accentColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.underlineColor),
                ),
              ),
              style: TextStyle(
                color: ThemeColors.textColor,
                fontSize: 24,
                letterSpacing: 2,
              ),
              onChanged: (String value) {
                setState(() {
                  account.name = value;
                });
                return;
              },
            ) : Text(account.name, style: TextStyle(color: ThemeColors.textColor,),),
            centerTitle: false,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(
                    typing ? Icons.done_rounded : Icons.edit_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      typing = !typing;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Account?"),
                          backgroundColor: ThemeColors.mainBkgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          actions: [
                        TextButton(
                        child: Text("No", style: TextStyle(color: ThemeColors.secondaryTextColor),),
                        onPressed:  () {
                          Navigator.pop(context);
                        },
                        ),
                        TextButton(
                        child: Text("Yes", style: TextStyle(color: ThemeColors.textColor),),
                        onPressed:  () {
                          Navigator.pop(context);
                          removeAccount(account);
                        },
                        ),
                          ],
                        );
                      },
                    );
                    // setState(() {
                    //
                    // });
                  },
                ),
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
                            Flexible(child: RiskInput(account)),
                            Flexible(child: LeverageInput(account)),
                            // Flexible(child: LeverageInput(account.leverage.toString())),
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
                            Flexible(child: FeeInput(account, true)),
                            Flexible(child: FeeInput(account, false)),
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
                  addAccount();
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
      ),
    );
  }
}