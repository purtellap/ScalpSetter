import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/manager.dart';

import '../account.dart';

class HomeAccountCard extends StatelessWidget {

  final Account account;
  HomeAccountCard(this.account);

  @override
  Widget build(BuildContext context) {
    final state = InheritedManager.of(context).state;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      color: state.overlayColor,
      child: InkWell(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pushNamed(context, '/account', arguments: {'account' : account});
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(account.name, style: TextStyle(
                      color: state.textColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('${account.makerFee}/${account.takerFee}', style: TextStyle(
                    color: state.secondaryTextColor,
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${account.leverage}x', style: TextStyle(
                    color: state.secondaryTextColor,
                    //fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 16,
                    ),
                  ),
                  Text('${account.riskAmt * 100}%', style: TextStyle(
                    color: state.secondaryTextColor,
                    letterSpacing: 1,
                    fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
