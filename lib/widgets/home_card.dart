import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/res/colors.dart';
import 'package:scalpsetter/utils/noscroll_behavior.dart';
import 'package:scalpsetter/widgets/fee_input.dart';
import 'package:scalpsetter/widgets/price_input.dart';

class ScalpCard extends StatefulWidget {

  final String title;
  final bool isLong;

  ScalpCard({this.title, this.isLong});

  @override
  _ScalpCardState createState() => _ScalpCardState();
}

class _ScalpCardState extends State<ScalpCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      color: ThemeColors.overlayColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  '${widget.title}',
                  style: TextStyle(
                    color: ThemeColors.longColor,
                    fontSize: 66,
                    letterSpacing: 6,
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Center(
                child: Text(
                  '100',
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
              SizedBox(height: 48,),
              TitleText(text: 'Account Size', color: ThemeColors.longColor,),
              PriceInput(),
              SizedBox(height: 24,),
              TitleText(text: 'Entry Price', color: ThemeColors.longColor,),
              PriceInput(),
              SizedBox(height: 24,),
              TitleText(text: 'Stop Loss Price', color: ThemeColors.longColor,),
              PriceInput(),
            ],
          ),
        ),
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
