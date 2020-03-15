import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class AdMobIntegration {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: [],
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Sudoku'],
  );

  static BannerAd _bannerAd;

  static initAd() {
    FirebaseAdMob.instance.initialize(appId: _getAdAccountId());
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
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return kBannerAdIDAndroid;
      } else {
        return kBannerAdIDiOS;
      }
    } else {
      return BannerAd.testAdUnitId;
    }
  }

  static String _getAdAccountId() {
    if (Platform.isAndroid) {
      return kAppIDAndroid;
    } else {
      return kAppIDiOS;
    }
  }
}
