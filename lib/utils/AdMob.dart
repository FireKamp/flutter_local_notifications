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
  static InterstitialAd _interstitialAd;

  static initBannerAd() {
    FirebaseAdMob.instance.initialize(appId: _getAdAccountId());
    _bannerAd = _createBannerAd()
      ..load()
      ..show();
  }

  static initInterstitialAd() {
    FirebaseAdMob.instance.initialize(appId: _getAdAccountId());
    _interstitialAd = _createInterstitialAd()
      ..load()
      ..show();
  }

  static initRewardAd() {
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
    RewardedVideoAd.instance.show();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
          print('eventUp: $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        print('event: $event');
      }
    };
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

  static InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: _getInterstitialAdID(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  static dispose() {
    if (_bannerAd == null) _bannerAd.dispose();
    if (_interstitialAd == null) _interstitialAd.dispose();
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

  static String _getInterstitialAdID() {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return kInterstitialAdIDAndroid;
      } else {
        return kInterstitialAdIDiOS;
      }
    } else {
      return InterstitialAd.testAdUnitId;
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
