import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DefaultMaterialLocalizations;
import 'package:to_do/dashboard/calendar.dart';
import 'package:to_do/routes.dart';
import 'package:to_do/theme/theme.dart';

class ToDoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final router = FluroRouter();

  @override
  void initState() {
    super.initState();
    AppRoutes.defineRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) => CupertinoApp(
        theme: theme,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        onGenerateRoute: Application.router.generator,
        home: Calendar(),
      );
}
