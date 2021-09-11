import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scalpsetter/manager/manager.dart';
import 'package:scalpsetter/res/resources.dart';
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
    final state = InheritedManager.of(context).state;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      color: state.overlayColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: CalculationArea(widget.currentAccount, widget.title, widget.isLong),
        ),
      ),
    );
  }
}

class CalculationArea extends StatefulWidget {

  final Account account;
  final String title;
  final bool isLong;

  CalculationArea(this.account, this.title, this.isLong);

  @override
  _CalculationAreaState createState() => _CalculationAreaState();
}

class _CalculationAreaState extends State<CalculationArea> {

  String accountSize = '';
  String entryPrice = '';
  String stopLoss = '';

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    Color accentColor = widget.isLong ? state.longColor : state.shortColor;
    return ListView(
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
        AnswerText(widget.account, accountSize, entryPrice, stopLoss, widget.isLong),
        SizedBox(height: 8,),
        TitleText(text: 'Account Size', color: accentColor,),
        PriceInput(underlineColor: accentColor, entryText: accountSize,
          onChange:  (val) => setState(() {
            accountSize = val;
          }
          ),
        ),
        SizedBox(height: 24,),
        TitleText(text: 'Entry Price', color: accentColor,),
        PriceInput(underlineColor: accentColor, entryText: entryPrice,
          onChange:  (val) => setState(() {
            entryPrice = val;
          }
          ),
        ),
        SizedBox(height: 24,),
        TitleText(text: 'Stop Loss Price', color: accentColor,),
        PriceInput(underlineColor: accentColor, entryText: stopLoss,
          onChange:  (val) => setState(() {
            stopLoss = val;
          },
          ),
        ),
      ],
    );
  }
}

class AnswerText extends StatefulWidget {

  final Account account;
  final String accountSize;
  final String entryPrice;
  final String stopLoss;
  final bool isLong;

  AnswerText(this.account, this.accountSize, this.entryPrice, this.stopLoss, this.isLong);

  @override
  _AnswerTextState createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {

  int i = 0;

  Map<String, String> calculateAnswer(bool isUSD){
    try{
      double accountSize = double.parse(widget.accountSize);
      double entryPrice = double.parse(widget.entryPrice);
      double stopLoss = double.parse(widget.stopLoss);

      double priceDiffFlat = widget.isLong ? entryPrice - stopLoss : stopLoss - entryPrice;
      double priceDiffPercent = priceDiffFlat / entryPrice;

      double riskAmountFlat = accountSize * widget.account.riskAmt;
      double leverage = widget.account.leverage;
      double takerFee = widget.account.takerFee/100;
      double makerFee = widget.account.makerFee/100;

      double dollars;
      double units;
      double contracts;
      if(isUSD){
        dollars = riskAmountFlat / ((priceDiffPercent * leverage) + (leverage * makerFee) + (leverage * takerFee));
        units = dollars / entryPrice;
        contracts = dollars * leverage;
      }
      else{
        contracts = riskAmountFlat/(
            (takerFee + 1/leverage) * leverage/entryPrice *
                ((stopLoss * priceDiffPercent) + (stopLoss * takerFee) + (entryPrice * makerFee))
        );
        dollars = contracts / leverage;
        units = dollars / entryPrice;
      }

      // --- LIQUIDATION STUFF - NOT PART OF EQUATION ----
      // liquidation price formula from a random example exchange that won't be named
      double exchangeLiquidationFlat = (entryPrice * widget.account.leverage)/(widget.account.leverage + 1 - (0.005 * widget.account.leverage));
      double exchangeLiquidationPercent = (entryPrice - exchangeLiquidationFlat)/entryPrice;
      //print('el%: $exchangeLiquidationPercent');
      if(priceDiffPercent > exchangeLiquidationPercent){
        return {'DOLLARS' : Strings.liquidated, 'UNITS' : Strings.liquidated, 'CONTRACTS' : Strings.liquidated,};
      }
      // if no stop loss, lose all here
      //double standardLiquidationPercent = 1/widget.account.leverage;
      //
      // // default liquidation calculation
      // // if(priceDiffPercent > standardLiquidationPercent){
      // //   return 'liquidation!';
      // // }

      Map<String, String> map = {
        'DOLLARS' : dollars.toString(),
        'UNITS' : units.toString(),
        'CONTRACTS' : contracts.floor().toString(),
      };
      return map;
    }
    catch(e){
      return {'DOLLARS' : '0', 'UNITS' : '0', 'CONTRACTS' : '0'};
    }
  }

  Map formattedAns(Map m){
    return {
      'DOLLARS' : '\$' + NumberFormat('#,##0.00', 'en_US').format(double.parse(m['DOLLARS'])),
      'UNITS' : NumberFormat('#,##0.0########', 'en_US').format(double.parse(m['UNITS'])),
      'CONTRACTS' : NumberFormat('#,##0', 'en_US').format(double.parse(m['CONTRACTS'])),
    };
  }
    // try{
    //   inputError = false;
    //   return price.isNotEmpty ? '\$' + NumberFormat('#,##0.00', 'en_US').format(double.parse(price)) : '';
    // }
    // catch (e){
    //   inputError = true;
    //   return Strings.errorText;
    // }

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;

    Map answers = calculateAnswer(state.tradeType);
    String descriptor = answers.keys.elementAt(i%answers.length);
    String unformattedAnswer = answers[descriptor];
    String formattedAnswer;
    try{formattedAnswer =  formattedAns(answers)[descriptor];}
    catch (e){formattedAnswer = unformattedAnswer;}

    return GestureDetector(
      onTap: (){
        Clipboard.setData(ClipboardData(text: unformattedAnswer));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(Strings.copied, style: TextStyle(
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
              formattedAnswer,
              style: TextStyle(
                color: ThemeColors.amberAccentColor,
                fontSize: 24,
                letterSpacing: 6,
              ),
            ),
          ),
          SizedBox(height: 4,),
          Center(
            child: Text(
              descriptor,
              style: TextStyle(
                color: state.secondaryTextColor,
                fontSize: 16,
                letterSpacing: 6,
              ),
            ),
          ),
          Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: Dimens.splashRadius,
              icon: Icon(Icons.swap_horiz_rounded, color: state.secondaryTextColor,),
              onPressed: () {
                setState(() {
                  i++;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

// DisplayAns(answer: answer, text: Strings.types[0], color: state.secondaryTextColor,)
// class DisplayAns extends StatefulWidget {
//
//   DisplayAns({this.answer, this.text, this.color});
//
//   @override
//   _DisplayAnsState createState() => _DisplayAnsState();
// }
//
// class _DisplayAnsState extends State<DisplayAns> {
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }


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
