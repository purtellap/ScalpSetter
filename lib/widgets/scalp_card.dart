import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/utils/noscroll_behavior.dart';
import 'package:scalpsetter/widgets/fee_input.dart';
import 'package:scalpsetter/widgets/price_input.dart';

import '../account.dart';

class ScalpCard extends StatefulWidget {

  final Account currentAccount;
  final String title;
  final bool isLong;

  ScalpCard({this.title, this.isLong, this.currentAccount});

  @override
  _ScalpCardState createState() => _ScalpCardState();
}

class _ScalpCardState extends State<ScalpCard> {
  @override
  Widget build(BuildContext context) {
    Color accentColor = widget.isLong ? ThemeColors.longColor : ThemeColors.shortColor;
    return GestureDetector(
        onTap: (){
      // hide keyboard when tapping out
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }, child:Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      color: ThemeColors.overlayColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  '${widget.title}',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 66,
                    letterSpacing: 6,
                  ),
                ),
              ),
              SizedBox(height: 24,),
              AnswerText(widget.currentAccount, '', '', ''),
              SizedBox(height: 48,),
              TitleText(text: 'Account Size', color: accentColor,),
              PriceInput(underlineColor: accentColor),
              SizedBox(height: 24,),
              TitleText(text: 'Entry Price', color: accentColor,),
              PriceInput(underlineColor: accentColor),
              SizedBox(height: 24,),
              TitleText(text: 'Stop Loss Price', color: accentColor,),
              PriceInput(underlineColor: accentColor),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class AnswerText extends StatefulWidget {

  final Account account;
  final String accountSize;
  final String entryPrice;
  final String stopLoss;

  AnswerText(this.account, this.accountSize, this.entryPrice, this.stopLoss);

  @override
  _AnswerTextState createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {

  //var answer = double.parse(widget.accountSize)  * ;

  int calculateAnswer(){
    try{
      double accountSize = double.parse(widget.accountSize);
      double entryPrice = double.parse(widget.entryPrice);
      double stopLoss = double.parse(widget.stopLoss);

      return widget.account.leverage.floor();
    }
    catch(e){
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int answer = calculateAnswer();
    return GestureDetector(
      onTap: (){
        Clipboard.setData(ClipboardData(text: '$answer'));
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
      child: Column(
        children: [
          Center(
            child: Text(
              '$answer',
              style: TextStyle(
                color: ThemeColors.errorColor,
                fontSize: 24,
                letterSpacing: 6,
              ),
            ),
          ),
          Center(
            child: Text(
              'CONTRACTS',
              style: TextStyle(

                color: ThemeColors.secondaryTextColor,
                fontSize: 16,
                letterSpacing: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class TitleText extends StatelessWidget {

  final String text;
  final Color color;

  TitleText({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: TextAlign.left,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),
    );
  }
}
