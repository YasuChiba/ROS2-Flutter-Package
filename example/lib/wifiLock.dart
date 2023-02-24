import 'package:flutter/services.dart';


class WifiLock {
  static const platform = MethodChannel('wifi_lock');

  Future<void> acquire() async {
    try {
      await platform.invokeMethod('acquire');
    } on PlatformException {}
  }
}