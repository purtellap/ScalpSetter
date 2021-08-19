import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';

import '../account.dart';

class LeverageInput extends StatefulWidget {

  // final String input;
  // LeverageInput(this.input);
  final Account account;
  LeverageInput(this.account);

  @override
  _LeverageInputState createState() => _LeverageInputState();
}

class _LeverageInputState extends State<LeverageInput> {

  String entryText = '';
  bool inputError = false;

  // nicely formatted price in text below text field
  String formattedPrice(String price){
    try{
      inputError = false;
      return price.isNotEmpty ? NumberFormat('#,##0', 'en_US').format(double.parse(price)) + 'x' : '';
    }
    catch (e){
      inputError = true;
      return 'Did you fat-finger?';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: TextFormField(
                initialValue: widget.account.leverage.toString(),
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.number,
                cursorColor: state.secondaryTextColor,
                //maxLength: 25,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: state.shortColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ThemeColors.underlineColor),
                  ),
                ),
                style: TextStyle(
                  color: state.secondaryTextColor,
                  fontSize: 24,
                  letterSpacing: 2,
                ),
                onChanged: (String value) {
                  setState(() {
                    entryText = value;
                    double newLeverage = double.tryParse(value);
                    if (newLeverage != null){
                      widget.account.leverage = newLeverage;
                    }
                  });
                  return;
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top:8),
          child: Text(formattedPrice(entryText),
            style: TextStyle(color: inputError ? ThemeColors.amberAccentColor : state.textColor),
          ),
        ),
      ],
    );
  }
}