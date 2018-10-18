#import "UmengPlugin.h"
#import "UMCommon.h"
#import "MobClick.h"
#import "UMCommonLogManager.h"

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
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
