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

  //ios 初始化
  static Future<String> initUmIos(String appId,String channel) async {
    final String result = await _channel.invokeMethod('initPhone', {'iosAppId': appId,"channel":channel});
    return result;
  }

  //获取集成厕所所需 deviceId
  static Future<String> getDeviceId() async{
    final String result = await _channel.invokeMethod('getDeviceId');
    return result;
  }


  //android  页面统计
  static Future<String> onResume() async {
    final String result = await _channel.invokeMethod('onResume');
    return result;
  }

  //android 页面统计
  static Future<String> onPause() async {
    final String result = await _channel.invokeMethod('onPause');
    return result;
  }



  //iOS  页面统计
  static Future<String> onPageStart(String pageName) async {
    final String result = await _channel.invokeMethod('onPageStart',{'pagename':pageName});
    return result;
  }

  //iOS 页面统计
  static Future<String> onPageEnd(String pageName) async {
    final String result = await _channel.invokeMethod('onPageEnd',{'pagename':pageName});
    return result;
  }


}
