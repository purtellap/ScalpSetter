import 'package:flutter/material.dart';

class Account {

  String name;
  double leverage;
  double makerFee;
  double takerFee;
  double riskAmt;

  Account({this.name, this.leverage, this.makerFee, this.takerFee, this.riskAmt});

  Account.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      leverage = json['leverage'],
      makerFee = json['makerFee'],
      takerFee = json['takerFee'],
      riskAmt = json['riskAmt'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'leverage': leverage,
    'makerFee': makerFee,
    'takerFee': takerFee,
    'riskAmt': riskAmt,
  };

  static Account defaultAccount(int i) =>
      Account(name: 'Account $i', leverage: 10.0, makerFee: -0.025, takerFee: 0.075, riskAmt: 0.01);
}