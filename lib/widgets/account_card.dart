import 'package:flutter/material.dart';
import 'package:scalpsetter/main.dart';
import 'package:scalpsetter/res/colors.dart';

class HomeAccountCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      color: ThemeColors.overlayColor,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/account');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Account 1', style: TextStyle(
                    color: ThemeColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20,
                    ),
                  ),
                  Text('0.025/0.075', style: TextStyle(
                    color: ThemeColors.textColor,
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
                  Text('25x', style: TextStyle(
                    color: ThemeColors.textColor,
                    //fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 16,
                    ),
                  ),
                  Text('1%', style: TextStyle(
                    color: ThemeColors.textColor,
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
