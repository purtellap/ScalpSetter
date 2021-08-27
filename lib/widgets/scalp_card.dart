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
    return GestureDetector(
        onTap: (){
      // hide keyboard when tapping out
          FocusManager.instance.primaryFocus?.unfocus();
          //SystemChannels.textInput.invokeMethod('TextInput.hide');
    }, child:Card(
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
        SizedBox(height: 48,),
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

  String calculateAnswer(){
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

      //print('percentRisk: $priceDiffPercent');
      //print('takerfee: $takerFee');

      // double pmBTC;
      // double contracts;
      // double slLoss;
      // double exitFee;
      // double entryFee;
      // double pmEntry;
      // double pmExit;
      // double totalLoss;

      // pmBTC = (contracts/leverage + contracts*takerFee)/entryPrice;
      // pmExit = pmBTC * stopLoss;
      // pmEntry = pmBTC * entryPrice;
      //
      // slLoss = pmExit * priceDiffPercent * leverage;
      // exitFee = pmExit * takerFee * leverage;
      // entryFee = pmEntry * makerFee * leverage;
      //
      // totalLoss = slLoss + exitFee + entryFee;

      //contracts = pmBTC * entryPrice / (1/leverage + takerFee);

      // ((contracts * (1/leverage + takerFee))

      double contracts = riskAmountFlat/((takerFee + 1/leverage) * leverage/entryPrice * (
          (stopLoss * priceDiffPercent) + (stopLoss * takerFee) + (entryPrice * makerFee)
      ));

      // --- LIQUIDATION STUFF - NOT PART OF EQUATION ----
      // liquidation price formula from a random example exchange that won't be named
      double exchangeLiquidationFlat = (entryPrice * widget.account.leverage)/(widget.account.leverage + 1 - (0.005 * widget.account.leverage));
      double exchangeLiquidationPercent = (entryPrice - exchangeLiquidationFlat)/entryPrice;
      //print('el%: $exchangeLiquidationPercent');
      if(priceDiffPercent > exchangeLiquidationPercent){
        return Strings.liquidated;
      }
      // if no stop loss, lose all here
      //double standardLiquidationPercent = 1/widget.account.leverage;
      //
      // // default liquidation calculation
      // // if(priceDiffPercent > standardLiquidationPercent){
      // //   return 'liquidation!';
      // // }
      //

      return '~' + contracts.floor().toString();
    }
    catch(e){
      return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    String answer = calculateAnswer();
    final state = InheritedManager.of(context).state;
    return GestureDetector(
      onTap: (){
        Clipboard.setData(ClipboardData(text: '$answer'));
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
              '$answer',
              style: TextStyle(
                color: ThemeColors.amberAccentColor,
                fontSize: 24,
                letterSpacing: 6,
              ),
            ),
          ),
          Center(
            child: Text(
              'CONTRACTS',
              style: TextStyle(
                color: state.secondaryTextColor,
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
