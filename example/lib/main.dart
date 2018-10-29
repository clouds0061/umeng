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

  String _resultText = 'failed'; //文本分享返回
  String _resultWeb = 'failed'; //web分享返回
  String _resultImage = 'failed'; //图片分享返回
  String _resultMusic = 'failed'; //音乐分享返回
  String _resultVideo = 'failed'; //视屏分享返回
  static const MethodChannel channel = const MethodChannel('umeng');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initUm();
    getDevice();
    models.add(new Model('初始化微信'));
    models.add(new Model('微信分享web'));
    models.add(new Model('微信分享text'));
    models.add(new Model('微信分享image'));
    models.add(new Model('微信分享music'));
    models.add(new Model('微信分享video'));
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

  //umeng 初始化微信
  String initWXReslut = 'failed';

  initWx() async {
    String _string;
    try {
      _string = await Umeng.initWXShare("wx3d58ea2fd48e25d1", "3470678730");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      initWXReslut = _string;
    });
  }

  //umeng 微信分享web
  String wxShareResult = 'failed';

  wXShare() async {
    String _string;
    try {
      _string = await Umeng.wXShareWeb(
          "https://wxapp.ztsafe.com/keyValue/static/image/mother_mini.png"
      , "https://www.baidu.com", "测试分享");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultWeb = _string;
    });
  }

  //分享文本
  wXShareText() async {
    String _string;
    try {
      _string = await Umeng.wXShareText('测试文本分享');
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultText = _string;
    });
  }


  //分享图片
  wXShareImage() async {
    String _string;
    try {
      _string = await Umeng.wXShareImage(
          'https://wxapp.ztsafe.com/keyValue/static/image/mother_mini.png');
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultImage = _string;
    });
  }

  //分享文本
  wXShareMusic() async {
    String _string;
    try {
      _string = await Umeng.wXShareMusic(
          'https://music.163.com/#/user/event?id=1652788794', '', '房间',
          '刘瑞琦的房间',
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540550772845&di=c98e6b72fea89c2ee6b62a3d515e50de&imgtype=0&src=http%3A%2F%2Fimge.kugou.com%2Fstdmusic%2F240%2F20160621%2F20160621011134921872.jpg");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultMusic = _string;
    });
  }

  //分享文本
  wXShareVideo() async {
    String _string;
    try {
      _string = await Umeng.wXShareVedio(
          '与神同行片段', 'https://movie.douban.com/trailer/224638/#content', '与神同行'
      , "");
    } on Exception {
      _string = 'wxShare failed!';
    }
    setState(() {
      _resultVideo = _string;
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

//
//  wxShare() async {
//    String strings;
//    try {
//      strings = await Umeng.wxShare("hello!");
//    } on Exception {
//      strings = 'wxShare failed!';
//    }
//    setState(() {
//      _resultWxShare = strings;
//    });
//  }

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
      res = await Umeng.initUmIos("5bc3ef79f1f55675130000af", ""); //iPhone
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


  List<Model> models = new List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        title: '',
        home: new Scaffold(
            appBar: new AppBar(
                title: new Text('测试umeng分享'),
                ),
            body: new Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: new ListView.builder(
                    itemCount: models.length, itemBuilder: buildItem,
                    scrollDirection: Axis.vertical,),
                ),
            ),
        );
  }


  Widget buildItem(BuildContext context, int index) {
    return new Container(
        height: 40.0,
        width: double.infinity,
        child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Text(
                      models[index].title, style: TextStyle(fontSize: 12.0),),
                  ),
//              new Text('Result: $_resultVideo'),
              new Container(
                  child: new GestureDetector(
                      onTap: () {
                        switch (models[index].title) {
                          case '初始化微信':
                            initWx();
                            break;
                          case '微信分享web':
                            wXShare();
                            break;
                          case '微信分享text':
                            wXShareText();
                            break;
                          case '微信分享image':
                            wXShareImage();
                            break;
                          case '微信分享music':
                            wXShareMusic();
                            break;
                          case '微信分享video':
                            wXShareVideo();
                            break;
                        }
                      },
                      child: new Icon(Icons.share),
                      )
              )
            ],
            ),
        );
  }
}

class Model {
  String title;

//  Function function;


  Model(this.title);

}