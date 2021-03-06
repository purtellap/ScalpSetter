import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';

import '../account.dart';


class RiskInput extends StatefulWidget {

  final Account account;
  RiskInput(this.account);

  @override
  _RiskInputState createState() => _RiskInputState();
}

class _RiskInputState extends State<RiskInput> {

  String entryText = '';
  bool inputError = false;

  // nicely formatted price in text below text field
  String formattedPrice(String price){
    try{
      inputError = false;
      return price.isNotEmpty ? NumberFormat('#,##0.0', 'en_US').format(double.parse(price)) + '%' : '';
    }
    catch (e){
      inputError = true;
      return Strings.errorText;
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
                initialValue: (widget.account.riskAmt * 100).toString(),
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                cursorColor: state.secondaryTextColor,
                //maxLength: 25,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: state.longColor),
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
                    double newRisk = double.tryParse(value);
                    if (newRisk != null){
                      widget.account.riskAmt = newRisk/100;
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