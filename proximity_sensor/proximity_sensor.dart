import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<dynamic>? streamSubscription;
  bool isNear = false;

  @override
  void initState() {
    super.initState();
    proximityListener();
  }

  void proximityListener() {
    streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        isNear = (event > 0);
      });
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Proximity Sensor Example')),
        body: isNear
            ? Container(color: Colors.black)
            : Center(child: Text('Screen On')),
      ),
    );
  }
}
