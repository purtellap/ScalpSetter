import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalpsetter/res/resources.dart';

import '../account.dart';

class CoreState {
  final List<Account> accounts;

  final Color backgroundColor;
  final Color overlayColor;
  final Color textColor;
  final Color secondaryTextColor;

  final Color longColor;
  final Color shortColor;

  const CoreState({
    this.accounts,
    this.backgroundColor = ThemeColors.backgroundColorDark,
    this.overlayColor = ThemeColors.overlayColorDark,
    this.textColor = ThemeColors.textColorDark,
    this.secondaryTextColor = ThemeColors.secondaryTextColorDark,
    this.longColor = ThemeColors.blueColor,
    this.shortColor = ThemeColors.purpleColor,
  });

  // Makes a copy of the object for use in state manager
  CoreState copy({
    List<Account> accounts,
    Color backgroundColor,
    Color overlayColor,
    Color textColor,
    Color secondaryTextColor,
    Color longColor,
    Color shortColor,
  }) => CoreState(
    accounts: accounts ?? this.accounts,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    overlayColor: overlayColor ?? this.overlayColor,
    textColor: textColor ?? this.textColor,
    secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
    longColor: longColor ?? this.longColor,
    shortColor: shortColor ?? this.shortColor,
  );

  // All this is doing is replacing the comparison method used in the
  // inherited widget. Could get rid of and just update UI every time probably
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CoreState &&
          runtimeType == other.runtimeType &&
          //listEquals(accounts, other.accounts) && // might have to get rid of this
          backgroundColor == other.backgroundColor &&
          overlayColor == other.overlayColor &&
          textColor == other.textColor &&
          secondaryTextColor == other.secondaryTextColor &&
          longColor == other.longColor &&
          shortColor == other.shortColor;

  @override
  int get hashCode =>
      accounts.hashCode ^
      backgroundColor.hashCode ^
      overlayColor.hashCode ^
      textColor.hashCode ^
      secondaryTextColor.hashCode ^
      longColor.hashCode ^
      shortColor.hashCode;
}
