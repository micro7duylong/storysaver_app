import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      today = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "en_US",
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
        CalendarFormat.twoWeeks: '2 Weeks',
      },
      focusedDay: today,
      selectedDayPredicate: (day) => isSameDay(day, today),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      onDaySelected: _onDaySelected,
    );
  }
}
