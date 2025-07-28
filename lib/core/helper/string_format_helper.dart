import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Converter {
  static String toCapitalized(String value) {
    return value.toLowerCase().capitalizeFirst ?? '';
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';

    return parsedString;
  }

  static String roundDoubleAndRemoveTrailingZero(String value) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
      return b;
    } catch (e) {
      return value;
    }
  }

  static String projectStatusString(String state) {
    String status = '';
    switch (state) {
      case '1':
        status = "notStarted".tr;
        break;
      case '2':
        status = "inProgress".tr;
        break;
      case '3':
        status = "onHold".tr;
        break;
      case '4':
        status = "finished".tr;
        break;
      case '5':
        status = "cancelled".tr;
        break;
    }
    return status;
  }

  static String invoiceStatusString(String state) {
    String status = '';
    switch (state) {
      case '1':
        status = "unpaid".tr;
        break;
      case '2':
        status = "paid".tr;
        break;
      case '3':
        status = "partialPaid".tr;
        break;
      case '4':
        status = "overdue".tr;
        break;
      case '5':
        status = "cancelled".tr;
        break;
      case '6':
        status = "draft".tr;
        break;
    }
    return status;
  }

  static String estimateStatusString(String state) {
    String status = '';
    switch (state) {
      case '1':
        status = "draft".tr;
        break;
      case '2':
        status = "sent".tr;
        break;
      case '3':
        status = "declined".tr;
        break;
      case '4':
        status = "accepted".tr;
        break;
      case '5':
        status = "expired".tr;
        break;
    }
    return status;
  }

  static String proposalStatusString(String state) {
    String status = '';
    switch (state) {
      case '1':
        status = "open".tr;
        break;
      case '2':
        status = "declined".tr;
        break;
      case '3':
        status = "accepted".tr;
        break;
      case '4':
        status = "sent".tr;
        break;
      case '5':
        status = "revised".tr;
        break;
      case '6':
        status = "draft".tr;
        break;
    }
    return status;
  }

  static String taskStatusString(String state) {
    String status = '';
    switch (state) {
      case '1':
        status = "notStarted".tr;
        break;
      case '2':
        status = "awaitingFeedback".tr;
        break;
      case '3':
        status = "testing".tr;
        break;
      case '4':
        status = "inProgress".tr;
        break;
      case '5':
        status = "completed".tr;
        break;
    }
    return status;
  }

  static String taskPriorityString(String state) {
    String status = '';
    switch (state) {
      case '1': // Low
        status = "priorityLow".tr;
        break;
      case '2': // Medium
        status = "priorityMedium".tr;
        break;
      case '3': // High
        status = "priorityHigh".tr;
        break;
      case '4': // Urgent
        status = "priorityUrgent".tr;
        break;
    }
    return status;
  }

  static String formatNumber(String value, {int precision = 2}) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(precision);
      return b;
    } catch (e) {
      return value;
    }
  }

  static Color hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    } else {
      hexColor = "FF0D47A1";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static IconData fileType(String fileType) {
    IconData type = Icons.image_outlined;
    switch (fileType) {
      case 'application/pdf':
        type = Icons.insert_drive_file_outlined;
        break;
      case 'application/msword':
        type = Icons.insert_drive_file_outlined;
        break;
      case 'application/x-zip-compressed':
        type = Icons.folder_zip_outlined;
        break;
    }
    return type;
  }

  static String removeQuotationAndSpecialCharacterFromString(String value) {
    try {
      String formatedString =
      value.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '');
      return formatedString;
    } catch (e) {
      return value;
    }
  }

  static String replaceUnderscoreWithSpace(String value) {
    try {
      String formatedString = value.replaceAll('_', ' ');
      String v =
      formatedString.split(" ").map((str) => str.capitalize).join(" ");
      return v;
    } catch (e) {
      return value;
    }
  }

  static String getFormatedDateWithStatus(String inputValue) {
    String value = inputValue;
    try {
      var list = inputValue.split(' ');
      var dateSection = list[0].split('-');
      var timeSection = list[1].split(':');
      int year = int.parse(dateSection[0]);
      int month = int.parse(dateSection[1]);
      int day = int.parse(dateSection[2]);
      int hour = int.parse(timeSection[0]);
      int minute = int.parse(timeSection[1]);
      int second = int.parse(timeSection[2]);
      final startTime = DateTime(year, month, day, hour, minute, second);
      final currentTime = DateTime.now();

      int dayDef = currentTime.difference(startTime).inDays;
      int hourDef = currentTime.difference(startTime).inHours;
      final minDef = currentTime.difference(startTime).inMinutes;
      final secondDef = currentTime.difference(startTime).inSeconds;

      if (dayDef == 0) {
        if (hourDef <= 0) {
          if (minDef <= 0) {
            value = '$secondDef ${"secondAgo".tr}';
          } else {
            value = '$hourDef ${"minutesAgo".tr}';
          }
        } else {
          value = '$hourDef ${"hourAgo".tr}';
        }
      } else {
        value = '$dayDef ${"daysAgo".tr}';
      }
    } catch (e) {
      value = inputValue;
    }

    return value;
  }

  static String getTrailingExtension(int number) {
    List<String> list = [
      'th',
      'st',
      'nd',
      'rd',
      'th',
      'th',
      'th',
      'th',
      'th',
      'th'
    ];
    if (((number % 100) >= 11) && ((number % 100) <= 13)) {
      return '${number}th';
    } else {
      int value = (number % 10).toInt();
      return '$number${list[value]}';
    }
  }

  static String addLeadingZero(String value) {
    return value.padLeft(2, '0');
  }

  static String sum(String first, String last, {int precision = 2}) {
    double firstNum = double.tryParse(first) ?? 0;
    double secondNum = double.tryParse(last) ?? 0;
    double result = firstNum + secondNum;
    String formatedResult =
    formatNumber(result.toString(), precision: precision);
    return formatedResult;
  }

  static String showPercent(String curSymbol, String s) {
    double value = 0;
    value = double.tryParse(s) ?? 0;
    if (value > 0) {
      return ' + $curSymbol$value';
    } else {
      return '';
    }
  }

  static mul(String first, String second) {
    double result =
        (double.tryParse(first) ?? 0) * (double.tryParse(second) ?? 0);
    return Converter.formatNumber(result.toString());
  }

  static calculateRate(String amount, String rate, {int precision = 2}) {
    double result =
        (double.tryParse(amount) ?? 0) / (double.tryParse(rate) ?? 0);
    return Converter.formatNumber(result.toString(), precision: precision);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}