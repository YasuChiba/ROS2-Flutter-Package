import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ros2_flutter_package/ros2_flutter_package.dart'
    as ros2_flutter_package;
import 'package:ros2_flutter_package/ros2_publisher.dart' as ros2_publisher;
import 'package:ros2_flutter_package_example/wifiLock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int sumResult;
  late Future<int> sumAsyncResult;

  void start() async {
    print("starting");
    WifiLock().acquire();
    ros2_publisher.startPublisher();
    print("started");
  }

  @override
  void initState() {
    super.initState();
    sumResult = ros2_flutter_package.addTwo(1, 2);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nativeaaa Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  'sum(1, 2) = $sumResult',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                ElevatedButton(
                  onPressed: start,
                  child: const Text('start!!'),
                ), // This trailing comma makes auto-formatting nicer for build methods.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
