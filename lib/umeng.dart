import 'dart:async';

import 'package:flutter/services.dart';

class Umeng {
  static const MethodChannel _channel = const MethodChannel('umeng');


  //自定义点击事件  20181015001是分享按钮点击事件
  static Future<String> onEvent(String eventId) async {
    final String _return = await _channel.invokeMethod("onEvent",{"eventId":eventId});
    return _return;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> initShare(String appId,String appKey) async {
    final String result = await _channel.invokeMethod('initWXShare', {'appId': appId,'appKey':appKey});
    return result;
  }

  static Future<String> wxShare(String shareString) async {
    final String result = await _channel.invokeMethod('wxShare', {'shareString': shareString});
    return result;
  }

  static Future<String> initUm(String appId) async {
    final String result = await _channel.invokeMethod('initPhone', {'androidAppId': appId});
    return result;
  }

  static Future<String> onResume() async {
    final String result = await _channel.invokeMethod('onResume');
    return result;
  }

  static Future<String> onPause() async {
    final String result = await _channel.invokeMethod('onPause');
    return result;
  }
}
