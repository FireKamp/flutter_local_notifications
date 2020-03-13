import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class AdMobIntegration {
  static String testDevice = 'MobileId';
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: [],
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Sudoku'],
  );

  static BannerAd _bannerAd;

  static initAd() {
    FirebaseAdMob.instance.initialize(appId: _getBannerID());
    _bannerAd = _createBannerAd()
      ..load()
      ..show();
  }

  static BannerAd _createBannerAd() {
    return BannerAd(
        adUnitId: _getBannerID(),
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  static dispose() {
    _bannerAd.dispose();
  }

  static String _getBannerID() {
    if (Platform.isAndroid) {
      return kBannerAdIDAndroid;
    } else {
      return kBannerAdIDiOS;
    }
  }
}
