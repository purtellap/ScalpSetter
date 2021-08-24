import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/account.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';

class FeeInput extends StatefulWidget {

  final Account account;
  final bool isMaker;
  FeeInput(this.account, this.isMaker);

  @override
  _FeeInputState createState() => _FeeInputState();
}

class _FeeInputState extends State<FeeInput> {

  String entryText = '';
  bool inputError = false;

  // nicely formatted price in text below text field
  String formattedPrice(String price){
    try{
      inputError = false;
      return price.isNotEmpty ? NumberFormat('#,##0.000', 'en_US').format(double.parse(price)) + '%' : '';
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
                initialValue: widget.isMaker ? widget.account.makerFee.toString() : widget.account.takerFee.toString(),
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                cursorColor: state.secondaryTextColor,
                //maxLength: 25,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.isMaker ? state.longColor : state.shortColor),
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
                    double newFee = double.tryParse(value);
                    if (newFee != null){
                      widget.isMaker ? widget.account.makerFee = newFee : widget.account.takerFee = newFee;
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