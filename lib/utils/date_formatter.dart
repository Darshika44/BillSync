import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_constant.dart';

Future<void> selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    // setState(() {
    controller.text = "${picked.toLocal()}".split(' ')[0];
    // });
  }
  AppConst.showConsoleLog(controller.text);
}

class DateTimeFormat {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTimeRange getTodayRange() {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getThisWeekRange() {
    final DateTime now = DateTime.now();
    final DateTime start = now.subtract(Duration(days: now.weekday - 1));
    final DateTime end = start.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getTomorrowRange() {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    final DateTime end = DateTime(now.year, now.month, now.day + 1, 23, 59, 59);
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getThisMonthRange() {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month, 1, 0, 0, 0);
    final DateTime end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    return DateTimeRange(start: start, end: end);
  }

  String formatDate(isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    // DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(dateTime);
  }

  String calculateTimeDifference(String? createdAt) {
    final createdDate = DateTime.parse(createdAt ?? '');
    final currentDate = DateTime.now();

    final duration = currentDate.difference(createdDate);

    if (duration.inDays >= 1) {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''} ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }
}
