import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:umeng/umeng.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _resultInit = 'failed';
  String _resultOnResume = 'failed';
  String _resultOnPause = 'failed';
  String _resultWxShare = 'failed';
  String _resultOnEvent = 'failed';
  String _resultGetDeviceId = 'failed';
  String _resultPage = 'failed';
  static const MethodChannel channel = const MethodChannel('umeng');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initUm();
    getDevice();
//    onPageStart();
//    Umeng.initShare('111', '111');
//    Umeng.onResume();

  }

  @override
  void dispose() {
    try {
//      Umeng.onPause();
      onPageEnd();
    } on PlatformException {}
  }

  //ios 页面统计
  onPageStart() async {
    String _string;
    try {
      _string = await Umeng.onPageStart('测试页面首页');
    } on Exception {
      _string = 'page start failed';
    }
    _resultPage = _string;
  }

  //ios 页面统计
  onPageEnd() async {
    String _string;
    try {
      _string = await Umeng.onPageEnd('测试页面首页');
    } on Exception {
      _string = 'page start failed';
    }
    _resultPage = _string;
  }

  //自定义点击事件  20181015001是分享按钮点击事件
  onEvent() async {
    String _string;
    try {
      _string = await Umeng.onEvent("20181015001");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }

  //自定义点击事件  20181015001是分享按钮点击事件
  onEvent2() async {
    String _string;
    try {
      _string = await Umeng.onEvent("play");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }
  onEvent3() async {
    String _string;
    try {
      _string = await Umeng.onEvent("pause");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }
  onEvent4() async {
    String _string;
    try {
      _string = await Umeng.onEvent("reply");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }

  onEvent5() async {
    String _string;
    try {
      _string = await Umeng.onEvent("back_in_paly_page");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }

  //获取device id
  getDevice() async {
    String _string;
    try {
      _string = await Umeng.getDeviceId();
    } on Exception {
      _string = 'getDeviceId failed!';
    }
    setState(() {
      _resultGetDeviceId = _string;
    });
  }

  wxShare() async {
    String strings;
    try {
      strings = await Umeng.wxShare("hello!");
    } on Exception {
      strings = 'wxShare failed!';
    }
    setState(() {
      _resultWxShare = strings;
    });
  }

  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Umeng.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  initUm() async {
    String res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
//      res = await Umeng.initUm('5bc44da0f1f556a593000135');//android
//      res = await Umeng.initUmIos("5bc569f3f1f556e25a000245", "");//ipad
      res = await Umeng.initUmIos("5bc3ef79f1f55675130000af", "");//iPhone
    } on PlatformException {
      res = 'Failed to get init Umeng.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _resultInit = res;
    });
  }

  onResume() async {
    String res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await Umeng.onResume();
    } on PlatformException {
      res = 'Failed to get init Umeng.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
//      _result = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
                title: const Text('Plugin example app'),
                ),
            body: new Column(children: <Widget>[
              new Center(
                  child:
                  new Text('platforme:$_platformVersion\n'
                      'initReslut:$_resultInit\n'
                      'WXShare:$_resultWxShare\n'
                      'onEvent:$_resultOnEvent\n'
                      'deviceId:$_resultGetDeviceId\n'
                      'pageTest:$_resultPage')),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent();
//              wxShare();
                    }),
                    new Text('点击分享按钮:\n'
                        'onEvent:$_resultOnEvent\n')
                  ],)
                  ),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent();
                      onPageStart();
//              wxShare();
                    }),
                    new Text('点击分享按钮,并测试页面start:\n'
                        'onEvent:$_resultOnEvent\n'
                        'pageTest:$_resultPage')
                  ],)
                  ),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent2();
//              wxShare();
                    }),
                    new Text('点击进入播放页面播放按钮\n'
                        'onEvent2:$_resultOnEvent\n')
                  ],)
                  ),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent3();
//              wxShare();
                    }),
                    new Text('点击暂停播放按钮 '
                        'onEvent3:$_resultOnEvent\n')
                  ],)
                  ),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent4();
//                      onPageStart();
//              wxShare();
                    }),
                    new Text('点击恢复播放按钮 '
                        'onEvent4:$_resultOnEvent\n')
                  ],)
                  ),
              new Center(
                  child: new Row(children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.android), onPressed: () {
                      onEvent5();
                      onPageEnd();
//              wxShare();
                    }),
                    new Text('点击暂停播放按钮,并测试页面end:\n'
                        'onEvent5:$_resultOnEvent\n'
                        'pageTest:$_resultPage')
                  ],)
                  ),
            ],)
        ),
        );
  }
}
