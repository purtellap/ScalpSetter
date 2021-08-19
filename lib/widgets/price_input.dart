import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';

class PriceInput extends StatefulWidget {

  final Color underlineColor;
  final Function(String) onChange;
  final String entryText;

  PriceInput({this.underlineColor, this.onChange, this.entryText});

  @override
  _PriceInputState createState() => _PriceInputState();
}

class _PriceInputState extends State<PriceInput> {

  bool inputError = false;
  final nameHolder = TextEditingController();

  clearTextInput(){
    nameHolder.clear();
  }

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
    final state = InheritedManager.of(context).state;
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
                cursorColor: state.secondaryTextColor,
                //maxLength: 25,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.underlineColor),
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
                onChanged: widget.onChange,
                controller: nameHolder,
                // onChanged: (String value) async {
                //   widget.onChange;
                //   setState(() {
                //     entryText = value;
                //   });
                //   return;
                // },
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear_rounded),
              color: state.secondaryTextColor,
              onPressed: (){
                clearTextInput();
              },
            ),
            IconButton(
              icon: Icon(Icons.copy_rounded),
              color: state.secondaryTextColor,
              onPressed: (){
                Clipboard.setData(ClipboardData(text: widget.entryText));
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
          child: Text(formattedPrice(widget.entryText),
            style: TextStyle(color: inputError ? ThemeColors.amberAccentColor : state.textColor),
          ),
        ),
      ],
    );
  }
}