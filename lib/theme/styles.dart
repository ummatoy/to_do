import 'package:flutter/cupertino.dart';
import 'package:to_do/theme/colors.dart';

class Style {
  /// Application Colors
  static AppColors get colors => const AppColors();

  /// Brightness of the app
  static Brightness get appBrightness => Brightness.light;

  static BorderRadius get border10 => const BorderRadius.all(
        Radius.circular(10.0),
      );

  static BorderRadius get border24 => const BorderRadius.all(
        Radius.circular(24.0),
      );

  static BorderRadius get border36 => const BorderRadius.vertical(
        top: Radius.circular(36.0),
      );

  static EdgeInsets get padding4 => const EdgeInsets.all(4.0);

  static EdgeInsets get padding8 => const EdgeInsets.all(8.0);

  static EdgeInsets get padding12 => const EdgeInsets.all(12.0);

  static EdgeInsets get padding16 => const EdgeInsets.all(16.0);

  static EdgeInsets get padding20 => const EdgeInsets.all(20.0);
  static TextStyle get button => TextStyle(
        fontSize: 14.0,
        letterSpacing: 1.25,
        color: colors.black,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get subtitle1 => TextStyle(
        fontSize: 18.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get headline5 => TextStyle(
        fontSize: 24.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get body => TextStyle(
        fontSize: 14.0,
        letterSpacing: 0.15,
        color: colors.white,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get body2 => TextStyle(
        fontSize: 14.0,
        letterSpacing: 0.15,
        color: colors.grey,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: colors.black,
        fontWeight: FontWeight.w300,
      );
}
