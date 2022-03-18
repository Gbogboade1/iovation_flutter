
import 'dart:async';

import 'package:flutter/services.dart';

class IovationFlutter {
  static const MethodChannel _channel = MethodChannel('iovation_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<bool?>  initializeIovation(
      {required  String subscriberKey}) async {
    //TODO ('Implement initializeIovation')
final bool? isInitialized =  await _channel.invokeMethod('initializeIovation', {'subscriberKey':subscriberKey});
    return true;
  }

  static Future<String?> getBlackBoxString() async{
    //TODO ('Implement getBlackBoxString')
    final String? blackBoxValue =  await _channel.invokeMethod('getBlackBoxString');
    return blackBoxValue;
  }
}
