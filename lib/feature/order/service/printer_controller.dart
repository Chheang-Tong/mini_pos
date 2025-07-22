import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_text.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class PrinterController {
  final SunmiPrinterPlus _printer;

  PrinterController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<String?> printText(String text, {SunmiTextStyle? style}) async {
    return await safeCall(() => _printer.printText(text: text, style: style));
  }

  Future<String?> safeCall(Future<String?> Function() fn) async {
    final isReady = await MethodChannel('sunmi_printer_plus').invokeMethod('printerReady') ?? false;
    if (!isReady) {
      debugPrint("❌ Sunmi printer not ready (native)");
      return null;
    }
    try {
      return await fn();
    } catch (e) {
      debugPrint("Printer error: $e");
      return null;
    }
  }


  Future<String?> printCustomText({required SunmiText sunmiText}) async {
    return await _printer.printCustomText(sunmiText: sunmiText);
  }

  Future<String?> addText({required List<SunmiText> sunmiTexts}) async {
    return await _printer.addText(sunmiTexts: sunmiTexts);
  }

  Future<String?> printQRCode(String text, {SunmiQrcodeStyle? style}) async {
    return await _printer.printQrcode(text: text, style: style);
  }

  Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    return await _printer.printBarcode(text, style: style);
  }

  Future<String?> line({SunmiPrintLine? style}) async {
    return await _printer.line(type: style?.name);
  }

  Future<String?> lineWrap([int times = 3]) async {
    return await _printer.lineWrap(times: times);
  }

  Future<String?> cutPaper() async {
    return await _printer.cutPaper();
  }

  Future<String?> printImage({required Uint8List image, SunmiPrintAlign align = SunmiPrintAlign.LEFT}) async {
    return await _printer.printImage(image, align: align);
  }

  Future<List<int>> customEscPos() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.reset();
    bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.qrcode('Barcode by escpos', size: QRSize.size4, cor: QRCorrection.H);
    bytes += generator.feed(2);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.reset();
    bytes += generator.cut();

    return bytes;
  }

  Future<String?> printEscPos({required List<int> data}) async {
    return await _printer.printEscPos(data);
  }

  Future<String?> printTSPL({required String data}) async {
    return await _printer.printTSPL(data: data);
  }

  Future<String?> printRow({required List<SunmiColumn> cols}) async {
    return await _printer.printRow(cols: cols);
  }
}

class CashDrawer {
  final SunmiPrinterPlus _printer;

  CashDrawer({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<String?> openDrawer() async {
    return await _printer.openDrawer();
  }

  Future<bool> isDrawerOpen() async {
    return await _printer.isDrawerOpen();
  }
}

class LcdController {
  final SunmiPrinterPlus _printer;

  LcdController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<String?> config({required SunmiLCDStatus status}) async {
    return await _printer.configLCD(status: status);
  }

  Future<String?> sendTextLCD(String text, {int size = 32, bool fill = false}) async {
    return await _printer.sendTextLCD(text: text, size: size, fill: fill);
  }

  Future<String?> showDigital(String digital) async {
    return await _printer.showDigital(digital);
  }

  Future<String?> lcdImage({required Uint8List image}) async {
    return await _printer.lcdImage(image: image);
  }
}
class StatusController {
  final SunmiPrinterPlus _printer;

  StatusController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<PrinterStatus> getStatus() async {
    final status = await _printer.getStatus();
    try {
      return PrinterStatus.values.firstWhere(
            (e) => e.toString().split('.').last == status,
      );
    } catch (e) {
      return PrinterStatus.UNKNOWN; // Return null if the string doesn't match any enum value
    }
  }

  Future<String?> getVersion() async => await _printer.getVersion();

  Future<String?> getPaper() async => await _printer.getPaper();

  Future<String?> getId() async => await _printer.getId();

  Future<String?> getType() async => await _printer.getType();
  Future<bool> isPrinterReady() async {
    try {
      return await MethodChannel('sunmi_printer_plus').invokeMethod('printerReady') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<PrinterStatus> getStatusSafely() async {
    for (var i = 0; i < 10; i++) {
      if (await isPrinterReady()) {
        return getStatus(); // from your existing method
      }
      await Future.delayed(Duration(milliseconds: 300));
    }
    return PrinterStatus.UNKNOWN;
  }




}