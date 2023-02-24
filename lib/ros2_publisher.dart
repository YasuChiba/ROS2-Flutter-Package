import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:ffi/ffi.dart';

import 'ros2_flutter_package_rcl_bindings_generated.dart';

const String _libName = 'rcl';

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

final Ros2FlutterPackageRclBindings _bindings =
    Ros2FlutterPackageRclBindings(_dylib);

void startPublisher() {
  print("START!!!");
  var initOptions = malloc<rcl_init_options_t>()..ref = _bindings.rcl_get_zero_initialized_init_options();
  var allocator = _bindings.rcutils_get_default_allocator();

  print("START!!!2");

  var initOptionsResult = _bindings.rcl_init_options_init(initOptions, allocator);
  print(initOptionsResult);
  print("START!!!3");

  var context = malloc<rcl_context_s>()..ref = _bindings.rcl_get_zero_initialized_context();
  print("START!!!4");
  var initResult = _bindings.rcl_init(0, nullptr, initOptions, context);
  print(initResult);
  print("START!!!5");
  var node = malloc<rcl_node_s>()..ref = _bindings.rcl_get_zero_initialized_node();

  var nodeOptions = malloc<rcl_node_options_s>()..ref = _bindings.rcl_node_get_default_options();

  final nodeName = 'samplePublisher'.toNativeUtf8().cast<Char>();
  final namespace = "".toNativeUtf8().cast<Char>();

  print("START!!!6");
  var nodeinitResult = _bindings.rcl_node_init(node, nodeName, namespace, context, nodeOptions);
  print(nodeinitResult);
  print("START!!!7");

  //malloc.free(initOptions);
  //malloc.free(context);
}
