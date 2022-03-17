
import 'dart:async';

import 'package:flutter/services.dart';

class IovationFlutter {
  static const MethodChannel _channel = MethodChannel('iovation_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<String?> get initializeIovation async {
    final String? version = await _channel.invokeMethod('initializeIovation');
    return version;
  }
}
