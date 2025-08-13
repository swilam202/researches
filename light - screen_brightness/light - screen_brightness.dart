import 'package:flutter/material.dart';
import 'dart:async';
import 'package:light/light.dart';
import 'package:screen_brightness/screen_brightness.dart';

///  screen_brightness: ^2.1.6
///   light: ^4.1.0

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  StreamSubscription<int>? _lightEvents;

  int currentLux = 0;

  Future<void> brightnessListener() async {
    try {
      _lightEvents = Light().lightSensorStream.listen(
        (luxValue) => setState(() {
          double brightness = (luxValue / 100).clamp(0, 1);
          ScreenBrightness.instance.setApplicationScreenBrightness(brightness);
        }),
      );
    } catch (exception) {
      ///TODO: Handle exception
    }
  }

  @override
  void initState() {
    super.initState();
    brightnessListener();
  }

  @override
  void dispose() {
    _lightEvents?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Light Example')),
        body: Center(child: Text('Current Lux value: $currentLux')),
      ),
    );
  }
}
