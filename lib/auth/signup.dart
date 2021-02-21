import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:to_do/cells/button.dart';
import 'package:to_do/cells/checkbox.dart';
import 'package:to_do/cells/text_field.dart';
import 'package:to_do/routes.dart';
import 'package:to_do/theme/styles.dart';

class SignUpController extends StatefulWidget {
  @override
  _SignUpControllerState createState() => _SignUpControllerState();
}

class _SignUpControllerState extends State<SignUpController> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  TapGestureRecognizer loginLinkTapRecognizer;
  TapGestureRecognizer termsTapRecognizer;

  bool acceptTerms = false;

  /// --- Life Cycles ---

  @override
  void initState() {
    super.initState();
    loginLinkTapRecognizer = TapGestureRecognizer()..onTap = openLogin;
    termsTapRecognizer = TapGestureRecognizer()..onTap = showTerms;
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    loginLinkTapRecognizer.dispose();
    termsTapRecognizer.dispose();
    super.dispose();
  }

  void openLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }

  void submit() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  void showTerms() {
    showCupertinoModalBottomSheet(
      backgroundColor: Style.colors.white,
      context: context,
      builder: (_) => Column(
        children: [
          const SizedBox(height: 12.0),
          Container(
            width: 48.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Style.colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          const SizedBox(height: 8.0),
          Text("Terms of reference", style: Style.subtitle1),
          const SizedBox(height: 12.0),
          Text(
            "To raise the profile and importance of patients, service users,carers and other stakeholder’s opinion in influencing localhealthcare developments, such as service redesign,commissioning intentions and procurement.",
            style: Style.body2,
          ),
        ],
      ),
    );
  }

  Widget get nameTextField => TextInputField(
        controller: nameController,
        title: "Name",
      );

  Widget get lastNameTextField => TextInputField(
        controller: lastNameController,
        title: "Surname",
      );

  Widget get mailTextField => TextInputField(
        controller: mailController,
        title: "Email",
      );

  Widget get passwordTextField => TextInputField.obscure(
        controller: passwordController,
        title: "Password",
      );

  Widget get termsCheckbox => Checkbox(
        child: Text.rich(
          TextSpan(
            text: "Agree with  ",
            children: [
              TextSpan(
                text: "terms of reference",
                style: TextStyle(color: Style.colors.primary),
                recognizer: termsTapRecognizer,
              ),
            ],
          ),
          style: Style.caption,
        ),
        value: acceptTerms,
        onChanged: (value) {
          acceptTerms = value;
          setState(() {});
        },
      );

  Widget submitButton() => Button.primary(
        text: "Next",
        onPressed: submit,
      );

  Widget get loginLink => Text.rich(
        TextSpan(
          text: "Do you have an account? ",
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(color: Style.colors.primary),
              recognizer: loginLinkTapRecognizer,
            ),
          ],
        ),
        style: Style.caption,
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
            nameTextField,
            const SizedBox(height: 12.0),
            lastNameTextField,
            const SizedBox(height: 12.0),
            mailTextField,
            const SizedBox(height: 12.0),
            passwordTextField,
            const SizedBox(height: 8.0),
            Text(
              "Password must be at least 6 characters",
              style: Style.caption,
            ),
            const SizedBox(height: 32.0),
            termsCheckbox,
            const SizedBox(height: 24.0),
            submitButton(),
            const SizedBox(height: 16.0),
            loginLink,
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
              "Register",
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
