import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

BoxDecoration bodyCustom() {
  return (const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.all(Radius.circular(10))));
}

TableCalendar tableCalendarCustom(DateTime? rangeStart, DateTime? rangeFinish,
    onDaysSelected, DateTime today) {
  return (TableCalendar(
    locale: "en_US",
    rowHeight: 40,
    headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white),
        formatButtonDecoration: BoxDecoration(color: Colors.white),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 26, 57, 91),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        formatButtonVisible: false,
        titleCentered: true),
    availableGestures: AvailableGestures.all,
    rangeSelectionMode: RangeSelectionMode.toggledOn,
    rangeStartDay: rangeStart,
    rangeEndDay: rangeFinish,
    onRangeSelected: onDaysSelected,
    firstDay: DateTime.utc(2023, 1, 1),
    lastDay: DateTime.utc(2023, 12, 31),
    focusedDay: today,
    calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 54, 60, 102), shape: BoxShape.circle),
        defaultTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        defaultDecoration: BoxDecoration(),
        outsideDecoration: BoxDecoration(),
        holidayTextStyle: TextStyle(
            color: Color.fromARGB(255, 216, 15, 1),
            fontWeight: FontWeight.bold),
        holidayDecoration: BoxDecoration(),
        weekendTextStyle: TextStyle(
            color: Color.fromARGB(255, 216, 15, 1),
            fontWeight: FontWeight.bold),
        weekendDecoration: BoxDecoration(),
        selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 75, 82, 126), shape: BoxShape.circle),
        rangeStartDecoration: BoxDecoration(
            color: Color.fromARGB(255, 229, 195, 166), shape: BoxShape.circle),
        rangeEndDecoration: BoxDecoration(
            color: Color.fromARGB(255, 229, 195, 166), shape: BoxShape.circle),
        rangeHighlightColor: Color.fromARGB(159, 75, 82, 126)),
  ));
}
