// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatefulWidget {
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
// CalendarController _calendarController = CalendarController();

//   @override
//   void initState() {
//     super.initState();
//     _calendarController = CalendarController();
//   }

//   @override
//   void dispose() {
//     _calendarController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           TableCalendar(
//             calendarController: _calendarController,
//             // Các thuộc tính và sự kiện của calendar
//             initialCalendarFormat: CalendarFormat.month,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             builders: CalendarBuilders(
//               selectedDayBuilder: (context, date, events) => Container(
//                 margin: const EdgeInsets.all(4.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   date.day.toString(),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               todayDayBuilder: (context, date, events) => Container(
//                 margin: const EdgeInsets.all(4.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   date.day.toString(),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }
