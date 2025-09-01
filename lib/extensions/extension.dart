import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    // return '${month.toString().padLeft(2, '0')}-$day-${year.toString().padLeft(2, '0')}';
    return '${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  String formattedDateTime() {
    return '${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}T${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
  }
}

extension DateFormatting on String {
  String toDDMMYYYY() {
    try {
      DateTime date = DateFormat('yyyy-MM-dd').parse(this); // Change the format according to your input date format
      String formattedDate = DateFormat('dd-MM-yyyy').format(date);
      return formattedDate;
    } catch (e) {
      return 'Invalid date';
    }
  }

  String toformatOnDateAndTime() {
    try {
      DateTime date = DateTime.parse(this); // Parse the string to DateTime
      return DateFormat('dd MMMM, yyyy hh:mm a').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }
}

extension NumberFormatExtension on String {
  String formatToKMB() {
    double numValue = double.parse(this);
    if (numValue >= 1000000000) {
      return '${(numValue / 1000000000).toStringAsFixed(1)}B';
    } else if (numValue >= 1000000) {
      return '${(numValue / 1000000).toStringAsFixed(1)}M';
    } else if (numValue >= 1000) {
      return '${(numValue / 1000).toStringAsFixed(0)}K';
    } else {
      return numValue.toStringAsFixed(0);
    }
  }
}

extension TimeAgo on String {
  String get toAgo {
    try {
      final dateTime = DateTime.parse(this);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inSeconds < 1) {
        return "Just now";
      } else if (difference.inSeconds < 60) {
        return "${difference.inSeconds}s";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h";
      } else if (difference.inDays < 7) {
        return "${difference.inDays}d";
      } else {
        final formatter = DateFormat('yMMMMd');
        return formatter.format(dateTime);
      }
    } on FormatException {
      return "Invalid date time format";
    } catch (e) {
      return "Error formatting date time";
    }
  }
}

extension DateTimeExtensions on DateTime {
  String getTimeDifference() {
    final now = DateTime.now().toUtc();
    final difference = now.difference(this);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months > 1 ? '$months months ago' : '1 month ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks > 1 ? '$weeks weeks ago' : '1 week ago';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

extension StringToDateFormatter on String {
  String formatDateString() {
    DateTime date = DateTime.parse(this);
    return DateFormat('dd MMMM, yyyy').format(date);
  }
}

extension ListExtensions<T> on List<T> {
  List<T> filter(bool Function(T) test) {
    return where(test).toList();
  }

  List<R> mapIndexed<R>(R Function(int, T) f) {
    return asMap().entries.map((entry) => f(entry.key, entry.value)).toList();
  }
}

extension NavigationExtensions on BuildContext {
  Future push(Widget screen, {dynamic arg}) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  Future pushReplace(Widget screen, {dynamic arg}) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  Future pushReplaceAndRemoveUntil(Widget screen, {dynamic arg}) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
      (route) {
        return false;
      },
    );
  }

  Future pushNamed(String routeName, {dynamic arg}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arg);
  }

  void pushReplacementNamed(String routeName, {dynamic arg}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arg);
  }

  void pushNamedAndRemoveUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  void pop({bool? arg}) {
    Navigator.of(this).pop(arg);
  }
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;

  double get screenHeight => mediaQuery.size.height;

  double get statusBarHeight => mediaQuery.padding.top;

  double get appBarHeight => kToolbarHeight;

  double get navigationBarHeight => mediaQuery.padding.bottom;

  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  double responsiveWidth(double width) => width * screenWidth / 375;

  double responsiveHeight(double height) => height * screenHeight / 812;
}
