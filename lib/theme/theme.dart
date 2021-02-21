import 'package:flutter/cupertino.dart';
import 'package:to_do/theme/styles.dart';

final theme = CupertinoThemeData(
  brightness: Style.appBrightness,
  primaryColor: Style.colors.primary,
  scaffoldBackgroundColor: Style.colors.background,
  barBackgroundColor: Style.colors.background,
  textTheme: CupertinoTextThemeData(
    navActionTextStyle: TextStyle(color: Style.colors.black),
    navTitleTextStyle: Style.headline5,
  ),
);
