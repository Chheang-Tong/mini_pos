import 'package:flutter/services.dart' show rootBundle, ByteData, Uint8List;
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  Future<void> sample() async {
    try {
      bool? isConnected = await bluetooth.isConnected;
      List<BluetoothDevice> devices = [];
      devices = await bluetooth.getBondedDevices();
      print(devices);

      // Load logo from assets
      // final ByteData bytes = await rootBundle.load('assets/images/cambodia_flag.jpg');
      // final Uint8List imageData = bytes.buffer.asUint8List();
      //
      // // Print logo
      // await bluetooth.printImageBytes(imageData);
      //
      // // Print some text
      // await bluetooth.printCustom("Hello from MiniPOS!", 3, 1); // size 3, center
      // await bluetooth.printNewLine();
      // await bluetooth.printCustom("Thank you!", 2, 1);
      // await bluetooth.printNewLine();
    } catch (e) {
      print("Print error: $e");
    }
  }
}
