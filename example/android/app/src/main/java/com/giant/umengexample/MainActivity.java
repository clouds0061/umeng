package com.giant.umengexample;

import android.content.Intent;
import android.os.Bundle;

import com.giant.umeng.UmengPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
//    GeneratedPluginRegistrant.
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UmengPlugin.myOnActivityResult(this.registrarFor("com.giant.umeng.UmengPlugin"), requestCode, resultCode, data);
    }
}
