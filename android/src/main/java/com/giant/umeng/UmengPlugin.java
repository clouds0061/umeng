package com.giant.umeng;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;

import com.umeng.analytics.MobclickAgent;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.*;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * UmengPlugin
 */
public class UmengPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "umeng");
        channel.setMethodCallHandler(new UmengPlugin(registrar));
    }

    public static void myOnActivityResult(Registrar registrar,int requestCode,int resultCode,Intent data){
        UMShareAPI.get(registrar.context()).onActivityResult(requestCode, resultCode, data);
    }

    private Registrar registrar;

    private UmengPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        OneListener listener = new OneListener();
        registrar.addActivityResultListener(listener);
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "initPhone":
                String appId = call.argument("androidAppId");
                if (appId == null) appId = "12312312312";
                try {
                    UMConfigure.setLogEnabled(true);
                    UMConfigure.init(registrar.context(), UMConfigure.DEVICE_TYPE_PHONE, appId);
                    MobclickAgent.setScenarioType(registrar.context(), MobclickAgent.EScenarioType.E_UM_NORMAL);
                    MobclickAgent.setSessionContinueMillis(1000 * 5);
                    result.success("--------" + appId + "-------");
                    System.err.print("----------------");
                } catch (Exception e) {
                    result.success("--------failed when init Umeng-------");
                    System.err.print("----------------");
                }
                break;
            case "onEvent":
                String eventId = call.argument("eventId");
                try{
                    MobclickAgent.onEvent(registrar.context(),eventId);
                    result.success("--------" + eventId + "-------");
                }catch (Exception e){
                    result.success("--------failed when onEvent-------");
                }
                break;
            case "onResume":
                try {
                    Activity activity = registrar.activity();
                    MobclickAgent.onResume(activity);
                    result.success("--------success when onResume-------");
                } catch (Exception e) {
                    result.success("--------failed when onResume-------");
                }
                break;
            case "onPause":
                try {
                    Activity activity = registrar.activity();
                    MobclickAgent.onPause(activity);
                    result.success("--------success when onPause-------");
                } catch (Exception e) {
                    result.success("--------failed when onPause-------");
                }
                break;

            case "initWXShare":
//                if (Build.VERSION.SDK_INT >= 23) {
//                    String[] mPermissionList = new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.CALL_PHONE, Manifest.permission.READ_LOGS, Manifest.permission.READ_PHONE_STATE, Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.SET_DEBUG_APP, Manifest.permission.SYSTEM_ALERT_WINDOW, Manifest.permission.GET_ACCOUNTS, Manifest.permission.WRITE_APN_SETTINGS};
//                    ActivityCompat.requestPermissions(this, mPermissionList, 123);
//
//                }
                try {
                    String appIds = call.argument("appId");
                    String appKeys = call.argument("appKey");
                    PlatformConfig.setWeixin(appIds, appKeys);
                } catch (Exception e) {

                }

                break;
            case "wxShare":
                try {
                    Activity activity = registrar.activity();
                    String shareString = call.argument("shareString");
                    new ShareAction(activity)
                            .withText(shareString)
                            .setDisplayList(SHARE_MEDIA.SINA, SHARE_MEDIA.QQ, SHARE_MEDIA.WEIXIN)
                            .setCallback(listener).share();
                    result.success("--------success when share: " + shareString + "-------");
                } catch (Exception e) {
                    result.success("--------failed when wxShare-------");
                }

                break;
        }
//    if (call.method.equals("getPlatformVersion")) {
//      result.success("Android " + android.os.Build.VERSION.RELEASE);
//    } else {
//      result.notImplemented();
//    }
    }

//    private void initUm(MethodCall call,final  OneListener listener){
//        String androidAppId = call.argument("androidAppId");
//
//    }

    private UMShareListener shareListener = new UMShareListener() {
        @Override
        public void onStart(SHARE_MEDIA share_media) {

        }

        @Override
        public void onResult(SHARE_MEDIA share_media) {

        }

        @Override
        public void onError(SHARE_MEDIA share_media, Throwable throwable) {

        }

        @Override
        public void onCancel(SHARE_MEDIA share_media) {

        }
    };

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        return false;
    }

    private class OneListener implements PluginRegistry.ActivityResultListener,UMShareListener{

        @Override
        public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
            return false;
        }

        @Override
        public void onStart(SHARE_MEDIA share_media) {

        }

        @Override
        public void onResult(SHARE_MEDIA share_media) {

        }

        @Override
        public void onError(SHARE_MEDIA share_media, Throwable throwable) {

        }

        @Override
        public void onCancel(SHARE_MEDIA share_media) {

        }
    }
}
