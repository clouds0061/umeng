import 'dart:async';

import 'package:flutter/services.dart';

class Umeng {
  static const MethodChannel _channel = const MethodChannel('umeng');


  //自定义点击事件  20181015001是分享按钮点击事件
  static Future<String> onEvent(String eventId) async {
    final String _return = await _channel.invokeMethod(
        "onEvent", {"eventId":eventId});
    return _return;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> initShare(String appId, String appKey) async {
    final String result = await _channel.invokeMethod(
        'initWXShare', {'appId': appId, 'appKey':appKey});
    return result;
  }

  static Future<String> wxShare(String shareString) async {
    final String result = await _channel.invokeMethod(
        'wxShare', {'shareString': shareString});
    return result;
  }

  static Future<String> initUm(String appId) async {
    final String result = await _channel.invokeMethod(
        'initPhone', {'androidAppId': appId});
    return result;
  }

  //ios 初始化
  static Future<String> initUmIos(String appId, String channel) async {
    final String result = await _channel.invokeMethod(
        'initPhone', {'iosAppId': appId, "channel":channel});
    return result;
  }

  //获取集成厕所所需 deviceId
  static Future<String> getDeviceId() async {
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
    final String result = await _channel.invokeMethod(
        'onPageStart', {'pagename':pageName});
    return result;
  }

  //iOS 页面统计
  static Future<String> onPageEnd(String pageName) async {
    final String result = await _channel.invokeMethod(
        'onPageEnd', {'pagename':pageName});
    return result;
  }

  //ios 初始化设置 1为YES 0为NO
  static Future<String> initUMShareConfigSetting(String flagWaterMark,
      String flagHttps) async {
    final String result = await _channel.invokeMethod('uShareSetting',
        {'flagWaterMark':flagWaterMark, 'flagHttps':flagHttps});
    return result;
  }

  //初始化个平台appid
  static Future<String> initSharePlatforms(
      Map<String, String> platforms) async {
    final String result = await _channel.invokeMethod(
        'initPlatforms', platforms);
    return result;
  }

  //初始化微信分享
  static Future<String> initWXShare(String appId, String wbAppId) async {
    final String result = await _channel.invokeMethod(
        'initWXShare', {'wxAppId':appId, 'wbAppId':wbAppId});
    return result;
  }

  //微信分享web ios wxShareWebWithDescr
  static Future<String> wXShareWebDescr(String imgUrl, String shareUrl,
      String title,String descr) async {
    final String result = await _channel.invokeMethod(
        'wxShareWebWithDescr', {'imgUrl':imgUrl,'descr':descr, 'shareUrl':shareUrl
      , 'title':title,});
    return result;
  }

  //微信分享web ios
  static Future<String> wXShareWeb(String imgUrl, String shareUrl,
      String title) async {
    final String result = await _channel.invokeMethod(
        'wxShareWeb', {'imgUrl':imgUrl, 'shareUrl':shareUrl
      , 'title':title,});
    return result;
  }

  //微信分享文本 ios
  static Future<String> wXShareText(String text) async {
    final String result = await _channel.invokeMethod(
        'wxShareText', {'text':text});
    return result;
  }

  //微信分享image ios
  static Future<String> wXShareImage(String imgUrl) async {
    final String result = await _channel.invokeMethod(
        'wxShareImage', {'imgUrl':imgUrl});
    return result;
  }

  //微信分享Music ios
  /*
   */
  static Future<String> wXShareMusic(String musicUrl,String musicDataUrl,String title,String content,String icon) async {
    final String result = await _channel.invokeMethod(
        'wxShareMusic', {'musicUrl':musicUrl, 'musicDataUrl':musicDataUrl
      , 'title':title,'content':content,'iconUrl':icon});
    return result;
  }

  //微信分享vedio ios
  static Future<String> wXShareVedio(String content, String vedio,
      String title,String iconUrl) async {
    final String result = await _channel.invokeMethod(
        'wxShareVedio', {'content':content, 'vedio':vedio
      , 'title':title,'iconUrl':iconUrl});
    return result;
  }

  static Future<String> isWeChatInstalled() async{
    final String result = await _channel.invokeMethod('isWeChatInstalled');
    return result;
  }
//  static Future<String> wXShareTest() async {
//    final String result = await _channel.invokeMethod(
//        'wxShareVedio', {'content':content, 'vedio':vedio
//      , 'title':title,});
//    return result;
//  }

}
