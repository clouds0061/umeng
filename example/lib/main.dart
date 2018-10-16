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
  String _result = 'failed';
  String _resultOnResume = 'failed';
  String _resultOnPause = 'failed';
  String _resultWxShare = 'failed';
  String _resultOnEvent = 'failed';
  static const MethodChannel channel = const MethodChannel('umeng');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initUm();
    Umeng.initShare('111', '111');
    Umeng.onResume();
  }

  @override
  void dispose(){
    try {
      Umeng.onPause();
    } on PlatformException {
    }

  }

  //自定义点击事件  20181015001是分享按钮点击事件
  Future<void> onEvent() async{
    String _string;
    try{
      _string = await Umeng.onEvent("20181015001");
    }on Exception{
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultOnEvent = _string;
    });
  }

  Future<void> wxShare() async {
    String strings;
    try{
      strings = await Umeng.wxShare("hello!");
    }on Exception{
      strings = 'wxShare failed!';
    }
    setState(() {
      _resultWxShare = strings;
    });
  }

  Future<void> initPlatformState() async {
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

  Future<void> initUm() async {
    String res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await Umeng.initUm('5bc44da0f1f556a593000135');
    } on PlatformException {
      res = 'Failed to get init Umeng.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _result = res;
    });
  }

  Future<void> onResume() async {
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
      _result = res;
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
                  'initReslut:$_result\n'
                  'WXShare:$_resultWxShare\n'
                  'onEvent:$_resultOnEvent')),
          new Center(
            child: new IconButton(icon: new Icon(Icons.android), onPressed: (){
              onEvent();
              wxShare();
            }),
          )
        ],)
      ),
    );
  }
}
