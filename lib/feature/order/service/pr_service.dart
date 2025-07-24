// import 'package:flutter/services.dart';
//
// class PrinterService {
//   static const MethodChannel platform = MethodChannel(
//     'com.example.minipos_app/printer',
//   );
//
//   static Future<String> getPrinterType() async {
//     try {
//       final result = await platform.invokeMethod<String>('getPrinterType');
//       return result ?? 'generic';
//     } catch (_) {
//       return 'generic';
//     }
//   }
//
//   static Future<void> printText(String text) async {
//     try {
//       final bool success = await platform.invokeMethod("printText", {
//         "text": text
//       });
//       print("Print: $success");
//     } on PlatformException catch (e) {
//       print("Print failed: ${e.message}");
//     }
//   }
//
//   static Future<void> printSomething() async {
//     try {
//       final isConnected = await platform.invokeMethod('checkPrinter');
//       if (!isConnected) {
//         print('❌ Printer not connected');
//         return;
//       }
//
//       await platform.invokeMethod('printText', {'text': 'Hello Sunmi'});
//     } catch (e) {
//       print('❌ Error printing: $e');
//     }
//   }
//   static Future<void> checkPrinterStatus() async {
//     await Future.delayed(Duration(seconds: 2)); // Wait for binding to complete
//     try {
//       final isConnected = await platform.invokeMethod<bool>('checkPrinter') ?? false;
//       print('Printer connected: $isConnected');
//     } catch (e) {
//       print('❌ Error checking printer: $e');
//     }
//   }
//   static Future<void>test()async{
//     final result = await platform.invokeMethod("printText", {
//       "data": {
//         "text": "Hello Sunmi",
//         "align": "CENTER",
//         "bold": true,
//         "fontSize": 28
//       }
//     });
//
//   }
//
// }
