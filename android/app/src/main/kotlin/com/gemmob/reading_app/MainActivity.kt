package com.gemmob.reading_app

import io.flutter.embedding.android.FlutterActivity

// import for google ad
import android.graphics.Color;
import android.view.LayoutInflater;
import android.widget.TextView;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;
import java.util.Map;

// mainActivity.java
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

internal class NativeAdFactoryExample(layoutInflater: LayoutInflater) : NativeAdFactory {
    private val layoutInflater: LayoutInflater
    @Override
    fun createNativeAd(
            nativeAd: NativeAd, customOptions: Map<String?, Object?>?): NativeAdView {
        val adView: NativeAdView = layoutInflater.inflate(R.layout.my_native_ad, null) as NativeAdView
        val headlineView: TextView = adView.findViewById(R.id.ad_headline)
        val bodyView: TextView = adView.findViewById(R.id.ad_body)
        headlineView.setText(nativeAd.getHeadline())
        bodyView.setText(nativeAd.getBody())
        adView.setBackgroundColor(Color.YELLOW)
        adView.setNativeAd(nativeAd)
        adView.setBodyView(bodyView)
        adView.setHeadlineView(headlineView)
        return adView
    }

    init {
        this.layoutInflater = layoutInflater
    }
}

class MainActivity: FlutterActivity() {
    @Override
    fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.getPlugins().add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", NativeAdFactoryExample())
    }

    @Override
    fun cleanUpFlutterEngine(flutterEngine: FlutterEngine?) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample")
    }
}
