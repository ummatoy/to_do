import 'dart:core';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:to_do/cells/button.dart';
import 'package:to_do/dashboard/calendar_model.dart';
import 'package:to_do/dashboard/db.dart';
import 'package:to_do/routes.dart';
import 'package:to_do/theme/styles.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = {};
  List<CalendarItem> _data = [];

  List<dynamic> _selectedEvents = [];
  List<Widget> get _eventWidgets =>
      _selectedEvents.map((e) => events(e)).toList();

  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEvents());
    _calendarController = CalendarController();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void logOut() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }

  Widget logOutIcon() => IconButton(
        icon: Icon(Icons.logout),
        onPressed: logOut,
      );

  Widget events(var d) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          )),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(d, style: Style.subtitle1),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Style.colors.primary,
                  size: 15,
                ),
                onPressed: () => _deleteEvent(d))
          ])),
    );
  }

  void _onDaySelected(DateTime day, List events, _) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _createTask(BuildContext context) {
    String _name = "";
    var content = TextField(
      style: Style.caption,
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: Style.body.copyWith(color: Style.colors.primary),
        labelText: 'Description',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
    var saveButton = Button.primary(
      text: 'Save',
      onPressed: () => _addEvent(_name),
    );
    var cancelButton = Button.primary(
        text: "Cancel", onPressed: () => Navigator.of(context).pop(false));
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Text("Create Task",
                      style: Style.headline5
                          .copyWith(color: Style.colors.primary)),
                  Container(padding: EdgeInsets.all(20), child: content),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[saveButton, cancelButton]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchEvents() async {
    _events = {};
    List<Map<String, dynamic>> _results = await DB.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
    _data.forEach((element) {
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(element.date.toString())));
      if (_events.containsKey(formattedDate)) {
        _events[formattedDate].add(element.name.toString());
      } else {
        _events[formattedDate] = [element.name.toString()];
      }
    });
    setState(() {});
  }

  void _addEvent(String event) async {
    CalendarItem item =
        CalendarItem(date: _selectedDay.toString(), name: event);
    await DB.insert(CalendarItem.table, item);
    _selectedEvents.add(event);
    _fetchEvents();

    Navigator.pop(context);
  }

  void _deleteEvent(String s) {
    List<CalendarItem> d = _data.where((element) => element.name == s).toList();
    if (d.length == 1) {
      DB.delete(CalendarItem.table, d[0]);
      _selectedEvents.removeWhere((e) => e == s);
      _fetchEvents();
    }
  }

  Widget calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.colors.primary,
          borderRadius: Style.border24,
        ),
        child: TableCalendar(
//onDaySelected: onDaySelected,
          calendarController: _calendarController,
          events: _events,
          calendarStyle: CalendarStyle(
            canEventMarkersOverflow: false,
            markersColor: Colors.white,
            weekdayStyle: Style.body,
            todayColor: Colors.white54,
            todayStyle: Style.body,
            selectedColor: Style.colors.shadow,
            outsideWeekendStyle: Style.body2,
            outsideStyle: Style.body2,
            weekendStyle: Style.body2,
            renderDaysOfWeek: true,
          ),
          headerStyle: HeaderStyle(
            leftChevronIcon:
                Icon(Icons.arrow_back_ios, size: 15, color: Colors.white),
            rightChevronIcon:
                Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
            titleTextStyle: Style.body,
            formatButtonDecoration: BoxDecoration(
              color: Style.colors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: Style.body,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Style.body,
            weekendStyle: Style.body,
          ),
        ));
  }

  Widget taskTitle() {
    if (_selectedEvents.length == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Text("No any tasks to do", style: Style.headline5),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Text("Tasks to do",
          style: Style.headline5.copyWith(color: Style.colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: logOutIcon(),
          ),
          calendar(),
          taskTitle(),
          Column(children: _eventWidgets),
          SizedBox(height: 60)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.colors.primary,
        onPressed: () => _createTask(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
