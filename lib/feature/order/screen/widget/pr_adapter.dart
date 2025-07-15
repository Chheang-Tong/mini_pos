abstract class PrinterAdabter {
  Future<bool> isAvailable();
  Future<void> printText(String text);
}
