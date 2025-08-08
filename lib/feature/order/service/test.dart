
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BluetoothPrintPlus'),
        ),
        body: SafeArea(
            child: Center(
              child: Text("TEST Printer"),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.red,
          child: Icon(Icons.stop),
        ),
    );
  }

  Widget buildBlueOffWidget() {
    return Center(
        child: Text(
          "Bluetooth is turned off\nPlease turn on Bluetooth...",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 16, color: Colors.red),
          textAlign: TextAlign.center,
        ));
  }



}
