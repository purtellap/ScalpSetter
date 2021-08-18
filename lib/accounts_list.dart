import 'package:flutter/material.dart';
import 'account.dart';

class AccountsList extends InheritedWidget{

  final List<Account> accounts;

  const AccountsList({
    Key key,
    @required Widget child,
    @required this.accounts,
  }) : super(key:key, child: child);

  @override
  bool updateShouldNotify(AccountsList oldWidget) => oldWidget.accounts != accounts;

  static List<Account> of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AccountsList>().accounts;
}