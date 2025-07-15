import 'package:flutter/services.dart';

class PrinterService {
  static const MethodChannel platform = MethodChannel(
    'com.example.minipos_app/printer',
  );

  static Future<String> getPrinterType() async {
    try {
      final result = await platform.invokeMethod<String>('getPrinterType');
      return result ?? 'generic';
    } catch (e) {
      print('Fail');
      return 'generic';
    }
  }

  static Future<void> printText(String text) async {
    try {
      final bool success = await platform.invokeMethod("printText", {
        "text": text ,
      });
      print("Print: $success");
    } on PlatformException catch (e) {
      print("❌ Print failed: ${e.message}");
    }
  }
}
