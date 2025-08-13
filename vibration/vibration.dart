import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

///<uses-permission android:name="android.permission.VIBRATE"/>
///vibration: ^3.1.3

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Vibration Example')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Vibration.vibrate(),
                child: Text('Basic Vibration'),
              ),
              ElevatedButton(
                onPressed: () => Vibration.vibrate(duration: 1000),
                child: Text('Vibration for 1 second'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Vibration.vibrate(pattern: [500, 1000, 500, 200]),
                child: Text('Vibration with pattern'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Vibration.vibrate(preset: VibrationPreset.tripleBuzz),
                child: Text('pre defined Vibration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
