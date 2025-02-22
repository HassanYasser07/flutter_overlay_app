package com.example.flutter_overlay_window_example;

import android.content.SharedPreferences;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "overlay_channel";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("setOverlayType")) {
                        String overlayType = call.arguments.toString();
                        saveOverlayType(overlayType);

                        result.success("Overlay type set to " + overlayType);
                    } else {
                        result.notImplemented();
                    }
                });
    }

    private void saveOverlayType(String overlayType) {
        SharedPreferences sharedPref = getSharedPreferences("overlay_prefs", MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putString("overlay_type", overlayType);
        editor.apply();
    }
}