import 'package:floating/floating.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final Floating floating = Floating();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PiPSwitcher(
        childWhenDisabled: Scaffold(
          appBar: AppBar(title: Text('PIP Example')),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 350,
                      width: double.infinity,
                      child: Image.network('https://www.example.com/image.jpg'),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    PiPStatus status = await floating.pipStatus;

                    EnableArguments args = (status == PiPStatus.enabled)
                        ? OnLeavePiP()
                        : ImmediatePiP(aspectRatio: Rational.vertical());

                    await floating.enable(args);
                  },
                  child: const Text('Show PIP'),
                ),
              ],
            ),
          ),
        ),
        childWhenEnabled: Image.network('https://www.example.com/image.jpg'),
        floating: floating,
      ),
    );
  }
}

//<manifest>
//    <application>
//         <activity
//             android:name=".MainActivity"
//             android:supportsPictureInPicture="true"
//             ...