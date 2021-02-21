import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do/cells/button.dart';
import 'package:to_do/cells/text_field.dart';
import 'package:to_do/routes.dart';
import 'package:to_do/theme/styles.dart';

class LoginController extends StatefulWidget {
  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  TapGestureRecognizer signUpLinkTapRecognizer;

  /// --- Life Cycles ---

  @override
  void initState() {
    super.initState();
    signUpLinkTapRecognizer = TapGestureRecognizer()..onTap = openSignUp;
  }

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    signUpLinkTapRecognizer.dispose();

    super.dispose();
  }

  /// --- Methods ---

  void openSignUp() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.signup,
      (_) => false,
    );
  }

  void openHomeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  void submit() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  /// --- Widgets ---

  Widget get signUpLink => RichText(
        text: TextSpan(
          text: "Do you have an account? ",
          style: Style.caption,
          children: <TextSpan>[
            TextSpan(
                text: "Register",
                style: Style.caption.copyWith(color: Style.colors.primary),
                recognizer: signUpLinkTapRecognizer),
          ],
        ),
      );

  Widget get numberField => TextInputField(
        controller: phoneController,
        title: "Phone number",
      );

  Widget get passwordField => TextInputField.obscure(
        controller: passwordController,
        title: "Password",
      );

  Widget submitButton() => Button.primary(
        text: "Enter",
        onPressed: submit,
      );

  Widget get card => Container(
        padding: Style.padding20.copyWith(bottom: 56.0, top: 36.0),
        decoration: BoxDecoration(
          color: Style.colors.white,
          borderRadius: Style.border36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            numberField,
            const SizedBox(height: 12.0),
            passwordField,
            const SizedBox(height: 12.0),
            const SizedBox(height: 32.0),
            submitButton(),
            const SizedBox(height: 16.0),
            signUpLink,
          ],
        ),
      );

  Widget get header => Padding(
        padding: Style.padding16.copyWith(top: 56.0, bottom: 56.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              style: Style.subtitle1.copyWith(color: Style.colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Login",
              style: Style.headline5.copyWith(color: Style.colors.white),
            ),
          ],
        ),
      );

  Widget get view => ListView(
        reverse: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        children: [
          header,
          card,
        ].reversed.toList(),
      );

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        backgroundColor: Style.colors.primary,
        child: SafeArea(
          top: true,
          bottom: false,
          child: view,
        ),
      );
}
