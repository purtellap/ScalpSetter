import 'package:flutter/material.dart';
import 'package:scalpsetter/manager/core_state.dart';
import 'package:scalpsetter/res/resources.dart';

import '../account.dart';

class StateManager extends StatefulWidget {
  final Widget child;

  const StateManager({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _StateManagerState createState() => _StateManagerState();
}

class _StateManagerState extends State<StateManager> {
  CoreState state = CoreState();

  bool forceUpdate = false;
  /* --- Functions for updating state --- */
  void changeTheme(bool isDark) {
    if(isDark){
      setState(() => state = state.copy(
        backgroundColor: ThemeColors.backgroundColorLight,
        overlayColor: ThemeColors.overlayColorLight,
        textColor: ThemeColors.textColorLight,
        secondaryTextColor: ThemeColors.secondaryTextColorLight,));
    }
    else{
      setState(() => state = state.copy(
        backgroundColor: ThemeColors.backgroundColorDark,
        overlayColor: ThemeColors.overlayColorDark,
        textColor: ThemeColors.textColorDark,
        secondaryTextColor: ThemeColors.secondaryTextColorDark,));
    }
  }

  void changeAccentColors(bool isDefault) {
    if(isDefault) {
      setState(() => state = state.copy(
        longColor: ThemeColors.blueColor,
        shortColor: ThemeColors.purpleColor));
    }
    else{
      setState(() => state = state.copy(
        longColor: ThemeColors.greenColor,
        shortColor: ThemeColors.redColor));
    }
  }

  void updateAccountList(List<Account> accounts){
    forceUpdate = true;
    final newState = state.copy(accounts: accounts);
    setState(() => state = newState);
  }

  void changeTradeType(bool isUSD){
    final newState = state.copy(tradeType: isUSD);
    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => InheritedManager(
    child: widget.child,
    state: state,
    stateWidget: this,
  );
}

class InheritedManager extends InheritedWidget {
  final CoreState state;
  final _StateManagerState stateWidget;

  const InheritedManager({
    Key key,
    @required Widget child,
    @required this.state,
    @required this.stateWidget,
  }) : super(key: key, child: child);

  static _StateManagerState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedManager>()
      .stateWidget;

  @override
  bool updateShouldNotify(InheritedManager oldWidget) =>
      (oldWidget.state != state) || stateWidget.forceUpdate;
}
