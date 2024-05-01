import 'package:flutter/foundation.dart';

class MyLog {
  static void log(dynamic value) {
    if (kDebugMode) {
      print('----------------  Log  ------------------');
      print('Value : $value');
    }
  }

  static void logWithCount(int number, dynamic value) {
    if (kDebugMode) {
      print('----------------  $number  ------------------');

      print('Value : $value');
    }
  }

  static void logWithTitle(String title, dynamic value) {
    if (kDebugMode) {
      print('----------------  Log  ------------------');
      print('Title :  $title');

      print('Value : $value');
    }
  }
}
