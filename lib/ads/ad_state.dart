import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState({required this.initialization});

  static String get bannerAdUnitID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8875774011985639/5119385880';
    } else if(Platform.isIOS) {
      return "ios ad unit id";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded. $ad'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  static String get interstitialAdUnitID {
    if(Platform.isAndroid){
      return 'ca-app-pub-8875774011985639/1710376493';
    } else if(Platform.isIOS) {
      return 'ios ad unit id';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}
