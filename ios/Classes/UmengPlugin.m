#import "UmengPlugin.h"
#import "UMCommon.h"
#import "MobClick.h"
#import "UMCommonLogManager.h"
#import "UMShare.h"
#import "UShareUI.h"

@implementation UmengPlugin



+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"umeng"
            binaryMessenger:[registrar messenger]];
  UmengPlugin* instance = [[UmengPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"initPhone" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *appId = dict[@"iosAppId"];
      NSString *channel = dict[@"channel"];
      [UMConfigure setLogEnabled:YES];
      //开发者需要显式的调用此函数，日志系统才能工作
      [UMCommonLogManager setUpUMCommonLogManager];
      [UMConfigure initWithAppkey:appId channel:channel];
//      [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
//      [MobClick setCrashReportEnabled:YES];   // 开启Crash收集 默认是开启状态
    
      
      NSLog(@"成功进入初始化逻辑部分iosAppId：%@",appId);
      result([@"iiiiOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"getDeviceId" isEqualToString:call.method]){
      NSString *deviceId = [UMConfigure deviceIDForIntegration];
      if([deviceId isKindOfClass:[NSString class]]){
          NSLog(@"服务器返回deviceId:%@",deviceId);
      }else{
          NSLog(@"服务器没有返回deviceId");
      }
      result(deviceId);
  }else if([@"onEvent" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *eventId = dict[@"eventId"];
      [MobClick event:eventId];
      result(eventId);
  }else if([@"onPageStart" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *pageName = dict[@"pagename"];
    [MobClick beginLogPageView:pageName]; //("Pagename"为页面名称，可自定义)
      result([@"pageStart收到传入页面名称--" stringByAppendingString:pageName]);
  }else if([@"onPageEnd" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *pageName = dict[@"pagename"];
      [MobClick endLogPageView:pageName];
      result([@"pageEnd收到传入页面名称--" stringByAppendingString:pageName]);
  }else if([@"initPlatforms" isEqualToString:call.method]){//初始化平台
//      NSDictionary *dict = call.arguments;

  }else if([@"initWXShare" isEqualToString: call.method]){//初始化微信分享
      NSDictionary *dict = call.arguments;
      NSString *appId = dict[@"wxAppId"];
      NSString *wbAppId = dict[@"wbAppId"];
      
      [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appId appSecret:@"" redirectURL:@"http://mobile.umeng.com/social" ];
      if(wbAppId != nil && wbAppId !=NULL)
           [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:appId appSecret:@"" redirectURL:@"https://sns.whalecloud.com/sina2/callback" ];
      [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_WechatTimeLine)]];
      result([@"成功获取到appId" stringByAppendingString:appId]);
  }else if([@"isWeChatInstalled" isEqualToString:call.method]){//判断是否安装微信
      NSString *reslut = @"0";//0 是未安装， 1是安装了
      if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) result = "1";
      result(result);
  }
  else if([@"wxShareWeb" isEqualToString:call.method]){//微信分享web
      NSDictionary *dict = call.arguments;
      NSString *imgUrl = dict[@"imgUrl"];
      NSString *title = dict[@"title"];
      NSString *shareUrl = dict[@"shareUrl"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
          [self shareWebPage:type imgUrl:imgUrl title:title shareUrl:shareUrl flutterReslut:result];
          
      }];
  }
  else if([@"wxShareText" isEqualToString:call.method]){//分享文字
      NSDictionary *dict = call.arguments;
      NSString *text = dict[@"text"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
          [self shareText:text result:result type:type];
          
      }];
  }
  else if([@"wxShareImage" isEqualToString:call.method]){//分享图片
      NSDictionary *dict = call.arguments;
      NSString *imgUrl = dict[@"imgUrl"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
          
          [self shareImage:type reslut:result imgUrl:imgUrl icon:@""];
          
      }];
  }
  else if([@"wxShareImageAndText" isEqualToString:call.method]){//分享图文混合.
//      NSDictionary *dict = call.arguments;
//      NSString *imgUrl = dict[@"imgUrl"];
//      NSString *title = dict[@"title"];
//      NSString *shareUrl = dict[@"shareUrl"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
//          [self share];
          
      }];
  }
  else if([@"wxShareMusic" isEqualToString:call.method]){//分享 音乐
      NSDictionary *dict = call.arguments;
      NSString *musicUrl = dict[@"musicUrl"];
      NSString *musicDataUrl = dict[@"musicDataUrl"];
      NSString *title = dict[@"title"];
      NSString *content = dict[@"content"];
       NSString *iconUrl = dict[@"iconUrl"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
          [self shareMusic:type reslut:result musicUrl:musicUrl title:title content:content musicDataUrl:musicDataUrl icon:iconUrl];
          
      }];
  }
  else if([@"wxShareVedio" isEqualToString:call.method]){//分享 视屏
      NSDictionary *dict = call.arguments;
      NSString *content = dict[@"content"];
      NSString *title = dict[@"title"];
      NSString *vedio = dict[@"vedio"];
      NSString *iconUrl = dict[@"iconUrl"];
      [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType type
                                                                               ,NSDictionary *uerInfo){
          [self shareVedio:type result:result title:title conten:content vedio:vedio icon:iconUrl];
          
      }];
  }
  else if([@"wxShareEmotiocon" isEqualToString:call.method]){//分享 表情
      
  }
  else if([@"uShareSetting" isEqualToString:call.method]){//初始化设置
      NSDictionary *dict = call.arguments;
      NSString *flagWaterMark = dict[@"flagWaterMark"];
      NSString *flagHttps = dict[@"flagHttps"];
      if ([flagWaterMark isEqualToString:@"1"]) {
          if([flagHttps isEqualToString:@"1"]){
              [self configUShareSettingsMarkFlag:YES configUShareSettingsUsingHttps:YES];
          }else{
              [self configUShareSettingsMarkFlag:YES configUShareSettingsUsingHttps:NO];
          }
      }else{
          if([flagHttps isEqualToString:@"1"]){
              [self configUShareSettingsMarkFlag:NO configUShareSettingsUsingHttps:YES];
          }else{
              [self configUShareSettingsMarkFlag:NO configUShareSettingsUsingHttps:NO];
          }
      }
  }else if([@"" isEqualToString:call.method]){
      
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}


- (void)configUShareSettingsMarkFlag:(BOOL)isUsingWaterMarkFlag
      configUShareSettingsUsingHttps:(BOOL)isUsingHttps{
    /**
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = isUsingWaterMarkFlag;
    
    /**
     *关闭强制验证https，允许分享http图片。需要在info.plist设置安全域名
     *
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = isUsingHttps;
}

-(void)configUSharePlatforms:(NSDictionary*)platforms{
//    NSEnumerator *en = [platforms keyEnumerator];
//    NSInteger *count = [platforms count];
//    for (int *i; i++; i<count) {
//        en nextObject
//    }
}

//分享网页
-(void)shareWebPage:(UMSocialPlatformType)type imgUrl:(NSString*)imgUrl title:(NSString*)title shareUrl:(NSString*)shareUrl flutterReslut:(FlutterResult)result
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"测试分享" thumImage:imgUrl];
    shareObject.webpageUrl = shareUrl;
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data,NSError *error){
        if(error){
            UMSocialLogInfo(@"----share fail with error %@----",error);
            result(@"failed to share");
        }else{
            if([data isKindOfClass:[UMSocialShareResponse class]]){
                UMSocialShareResponse *resp = data;
                UMSocialLogInfo(@"response message is %@",resp.message);
                NSString *str =resp.message;
                result([@"response message is " stringByAppendingString:str]);
            }else{
                result([@"response data is " stringByAppendingString:data]);
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
    
}

//分享 文本
-(void)shareText:(NSString*)text result:(FlutterResult)reslut type:(UMSocialPlatformType)type{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    [[UMSocialManager defaultManager]shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data,NSError *error){
        if(error){
            reslut(@"failed to share text");
        }else{
            reslut(@"successed to share text");
        }
    }];
}

//分享图片
-(void)shareImage:(UMSocialPlatformType)type reslut:(FlutterResult)result imgUrl:(NSString *)imgUrl
             icon:(NSString*)iconUrl{
    //常见分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //吧url图片转换成UIImage类型缓存下来
    NSURL *url = [NSURL URLWithString:iconUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //如果有略缩图 则设置略缩图
    shareObject.thumbImage = image;
    [shareObject setShareImage:imgUrl];
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data,NSError *error){
        if(error){
            result(@"failed to share image");
        }else{
            result(@"success to share image");
        }
    }];
}

//分享音乐
-(void)shareMusic:(UMSocialPlatformType)type reslut:(FlutterResult)result musicUrl:(NSString*)musicUrl
            title:(NSString*)title content:(NSString *)content musicDataUrl:(NSString*)musicDataUrl
          icon:(NSString*)iconUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //吧url图片转换成UIImage类型缓存下来
    NSURL *url = [NSURL URLWithString:iconUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //创建音乐内容
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:content thumImage:image];
    //设置音乐网页播放地址
    shareObject.musicUrl = musicUrl;
    //设置音乐数据流地址(如果有的话，也要看分享的平台支不支持)
    shareObject.musicDataUrl = musicDataUrl;
    //设置分享消息对象内容
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data,NSError * error){
        if(error){
            result(@"failed to share music");
        }else{
            result(@"success to share music");
        }
    }];
}

//分享视屏
-(void)shareVedio:(UMSocialPlatformType)type result:(FlutterResult)result title:(NSString*)title conten:(NSString*)content vedio:(NSString*)vedioUrl icon:(NSString*)iconUrl{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //吧url图片转换成UIImage类型缓存下来
    NSURL *url = [NSURL URLWithString:iconUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //创建视屏内容
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:content thumImage:image];
    //视屏网页播放地址
    shareObject.videoUrl = vedioUrl;
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data,NSError *error){
        if(error){
            result(@"failed to share vedio");
        }else{
            result(@"success to share vedio");
        }
    }];
    
}

@end
