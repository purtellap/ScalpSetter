import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/res/colors.dart';

class PriceInput extends StatefulWidget {
  @override
  _PriceInputState createState() => _PriceInputState();
}

class _PriceInputState extends State<PriceInput> {

  String entryText = '';
  bool inputError = false;

  // nicely formatted price in text below text field
  String formattedPrice(String price){
    try{
      inputError = false;
      return price.isNotEmpty ? '\$' + NumberFormat('#,##0.00', 'en_US').format(double.parse(price)) : '';
    }
    catch (e){
      inputError = true;
      return 'Did you fat-finger?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                cursorColor: ThemeColors.accentColor,
                //maxLength: 25,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ThemeColors.longColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ThemeColors.underlineColor),
                  ),
                ),
                style: TextStyle(
                  color: ThemeColors.secondaryTextColor,
                  fontSize: 24,
                  letterSpacing: 2,
                ),
                onChanged: (String value) async {
                  setState(() {
                    entryText = value;
                  });
                  return;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy_rounded),
              color: ThemeColors.accentColor,
              onPressed: (){
                Clipboard.setData(ClipboardData(text: entryText));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Copied to clipboard', style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                      textAlign: TextAlign.center
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.black,
                ));
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top:8),
          child: Text(formattedPrice(entryText),
            style: TextStyle(color: inputError ? ThemeColors.errorColor : ThemeColors.textColor),
          ),
        ),
      ],
    );
  }
}