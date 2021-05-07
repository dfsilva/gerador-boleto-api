import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

isToday(DateTime date) {
  final now = DateTime.now();
  return now.day == date.day && now.month == date.month && now.year == date.year;
}

isSameDay(DateTime date1, DateTime date2) {
  return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
}

DateTime? parseDateTime(dynamic obj, {bool time = false}) {
  if (obj == null) return null;
  if (obj is Timestamp) return DateTime.fromMillisecondsSinceEpoch(obj.millisecondsSinceEpoch);
  if (obj is String) return time ? DateFormat("dd/MM/yyyy HH:mm").parse(obj) : DateFormat("dd/MM/yyyy").parse(obj);
  return null;
}

String? formatDateTime(DateTime obj, {bool time = false}) {
  if (obj == null) return null;
  return time ? DateFormat("dd/MM/yyyy HH:mm").format(obj) : DateFormat("dd/MM/yyyy").format(obj);
}

TimeOfDay? parseTimeOfDay(Object time) {
  if (time == null) return null;
  if (time is String) {
    if (time.isNotEmpty)
      try {
        return TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
      } catch (e) {
        return null;
      }
  }
  return null;
}

String? formatTimeOfDay(TimeOfDay time) {
  if (time == null) return null;
  return "${time.hour < 10 ? "0" + time.hour.toString() : time.hour}:${time.minute < 10 ? "0" + time.minute.toString() : time.minute}";
}

bool isBetween(TimeOfDay start, TimeOfDay end, TimeOfDay middle) {
  final startdbl = start.hour + start.minute / 60.0;
  final enddbl = end.hour + end.minute / 60.0;
  final middledbl = middle.hour + middle.minute / 60.0;

  return (middledbl >= startdbl && middledbl <= enddbl);
}

int compareTimes(TimeOfDay t1, TimeOfDay t2) {
  final startdbl = t1.hour + t1.minute / 60.0;
  final enddbl = t2.hour + t2.minute / 60.0;
  return startdbl.compareTo(enddbl);
}
