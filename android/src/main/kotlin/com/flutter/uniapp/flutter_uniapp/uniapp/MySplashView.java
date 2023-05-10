package com.flutter.uniapp.flutter_uniapp.uniapp;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import io.dcloud.feature.sdk.Interface.IDCUniMPAppSplashView;

public class MySplashView implements IDCUniMPAppSplashView {
    FrameLayout splashView;

    @Override
    public View getSplashView(Context context, String appid, String s1, String s2) {
        splashView = new FrameLayout(context);
        splashView.setBackgroundColor(Color.BLUE);
        TextView textView = new TextView(context);
        textView.setText(appid);
        textView.setTextColor(Color.WHITE);
        textView.setTextSize(20);
        textView.setGravity(Gravity.CENTER);
        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 100);
        lp.gravity = Gravity.CENTER;
        splashView.addView(textView, lp);
        return splashView;
    }

    @Override
    public void onCloseSplash(ViewGroup rootView) {
        if(rootView != null)
            rootView.removeView(splashView);
    }
}
