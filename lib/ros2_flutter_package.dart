import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'ros2_flutter_package_bindings_generated.dart';

const String _libName = 'sample_small_pkg';

/// The dynamic library in which the symbols for [SampleFlutterPkgBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final Ros2FlutterPackageBindings _bindings = Ros2FlutterPackageBindings(_dylib);

int addTwo(int a, int b) => _bindings.addTwo(a, b);
