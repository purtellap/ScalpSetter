import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
import 'package:scalpsetter/widgets/fee_input.dart';
import 'package:scalpsetter/widgets/scalp_card.dart';
import 'package:scalpsetter/widgets/leverage_input.dart';
import 'package:scalpsetter/widgets/risk_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account.dart';
import '../main.dart';

class EditAccount extends StatefulWidget {

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  bool typing = false;

  save(BuildContext context, List<Account> accounts) async {
    InheritedManager.of(context).updateAccountList(accounts);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.ACCOUNTS_PREF, json.encode(InheritedManager.of(context).state.accounts));
    // final provider = ThemeInherited.of(context);
    // provider.changeAccentColors(Colors.amber);
  }

  addAccount(BuildContext context) async{
    final state = InheritedManager.of(context).state;
    if(state.accounts.length < 8){
      Account newAccount = Account.defaultAccount(state.accounts.length + 1);
      List<Account> newAccounts = List.from(state.accounts);
      newAccounts.add(newAccount);
      save(context, newAccounts);
      Navigator.pushReplacementNamed(context, '/account', arguments: {'account' : newAccount});
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final state = InheritedManager.of(context).state;
          return AlertDialog(
            title: Text(Strings.acctMaxTitle, style: TextStyle(color: state.textColor)),
            content: Text(Strings.acctMaxDesc, style: TextStyle(color: state.secondaryTextColor),),
            backgroundColor: state.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            actions: [
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(Strings.okay, style: TextStyle(color: state.textColor),),
                ),
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

  removeAccount(BuildContext context, Account account) async{
    final state = InheritedManager.of(context).state;
    List<Account> accounts = List.from(state.accounts);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.deleteTitle, style: TextStyle(color: state.textColor)),
          backgroundColor: state.backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          actions: [
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(Strings.no, style: TextStyle(color: state.secondaryTextColor),),
              ),
              onPressed:  () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(Strings.yes, style: TextStyle(color: state.textColor),),
              ),
              onPressed:  () {
                Navigator.pop(context);
                accounts.remove(account);
                save(context, accounts);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final state = InheritedManager.of(context).state;

    Account account;
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) account = arguments['account'];

    return WillPopScope(
      onWillPop:  () {
        save(context, state.accounts);
        Navigator.pop(context, true);
        return;
      },
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
          //SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: state.backgroundColor,
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_rounded),
            //   splashRadius: Dimens.splashRadius,
            //   onPressed: () {
            //     //print('saving...');
            //     Navigator.pop(context);
            //   },
            // ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: state.textColor
            ),
            title: typing ? TextFormField(
              initialValue: account.name,
              autocorrect: false,
              enableSuggestions: false,
              cursorColor: state.secondaryTextColor,
              //maxLength: 25,
              inputFormatters: [LengthLimitingTextInputFormatter(18),],
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: state.textColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.underlineColor),
                ),
              ),
              style: TextStyle(
                color: state.textColor,
                fontSize: 24,
                letterSpacing: 2,
              ),
              onChanged: (String value) {
                setState(() {
                  account.name = value;
                });
                return;
              },
            ) : Text(account.name, style: TextStyle(color: state.textColor,),),
            centerTitle: false,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  splashRadius: Dimens.splashRadius,
                  icon: Icon(
                    typing ? Icons.done_rounded : Icons.edit_rounded,
                    color: state.textColor,
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
                  splashRadius: Dimens.splashRadius,
                  icon: Icon(
                    Icons.delete_rounded,
                    color: state.textColor,
                  ),
                  onPressed: () {
                    if(state.accounts.length > 1){
                      removeAccount(context, account);
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final state = InheritedManager.of(context).state;
                          return AlertDialog(
                            title: Text(Strings.acctMinTitle, style: TextStyle(color: state.textColor)),
                            content: Text(Strings.acctMinDesc, style: TextStyle(color: state.secondaryTextColor),),
                            backgroundColor: state.backgroundColor,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                              ),
                            actions: [
                              TextButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(Strings.okay, style: TextStyle(color: state.textColor),),
                                ),
                                onPressed:  () {Navigator.pop(context);},
                              ),
                            ],
                          );
                        },
                      );
                    }
                    // setState(() {
                    //
                    // });
                  },
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  color: state.overlayColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Expanded(child: TitleText(text: 'Risk Tolerance', color: state.longColor,),),
                            Expanded(child: TitleText(text: 'Leverage', color: state.shortColor,)),
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
                            Expanded(child: TitleText(text: 'Maker Fee', color: state.longColor,),),
                            Expanded(child: TitleText(text: 'Taker Fee', color: state.shortColor,)),
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
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  color: state.overlayColor,
                  child: InkWell(
                  onTap: (){
                    addAccount(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text('ADD NEW ACCOUNT', style: TextStyle(
                                color: state.secondaryTextColor,
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