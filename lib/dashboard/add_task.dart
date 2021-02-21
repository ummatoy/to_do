import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do/cells/button.dart';
import 'package:to_do/cells/text_field.dart';
import 'package:to_do/routes.dart';
import 'package:to_do/theme/styles.dart';

class TaskController extends StatefulWidget {
  @override
  _TaskControllerState createState() => _TaskControllerState();
}

class _TaskControllerState extends State<TaskController> {
  final taskController = TextEditingController();

  TapGestureRecognizer signUpLinkTapRecognizer;

  /// --- Life Cycles ---

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  /// --- Methods ---

  void submit() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (_) => false,
    );
  }

  /// --- Widgets ---

  Widget get taskField => TextInputField.large(
        controller: taskController,
        title: "Description",
      );

  Widget submitButton() => Button.primary(
        text: "Create task",
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
            taskField,
            submitButton(),
            const SizedBox(height: 16.0),
          ],
        ),
      );

  Widget get header => Padding(
        padding: Style.padding16.copyWith(top: 56.0, bottom: 56.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create task",
              style: Style.headline5.copyWith(color: Style.colors.white),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Name!",
              style: Style.subtitle1.copyWith(color: Style.colors.white),
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
