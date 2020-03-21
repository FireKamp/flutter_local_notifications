import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class AdMobIntegration {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: ["517603BE84183CF5E71EFA90A419FC0D"],
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Sudoku'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  final Function(bool) adRewarded;

  AdMobIntegration({this.adRewarded});

  initBannerAd() {
    FirebaseAdMob.instance.initialize(appId: _getAdAccountId());
    _bannerAd = _createBannerAd()
      ..load()
      ..show();
  }

  initInterstitialAd() {
    FirebaseAdMob.instance.initialize(appId: _getAdAccountId());
    _interstitialAd = _createInterstitialAd()
      ..load()
      ..show();
  }

  initRewardAd() {
    RewardedVideoAd.instance
        .load(adUnitId: _getRewardAdID(), targetingInfo: targetingInfo);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        adRewarded(true);
      } else if (event == RewardedVideoAdEvent.loaded) {
        RewardedVideoAd.instance.show();
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        adRewarded(true);
      } else if (event == RewardedVideoAdEvent.closed) {
        adRewarded(false);
      }
    };
  }

  BannerAd _createBannerAd() {
    return BannerAd(
        adUnitId: _getBannerID(),
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: _getInterstitialAdID(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }

  void dispose() {
//    if (_bannerAd != null) _bannerAd.dispose();
    if (_interstitialAd != null) _interstitialAd.dispose();
  }

  String _getBannerID() {
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

  String _getInterstitialAdID() {
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

  String _getRewardAdID() {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return kRewardAddIDAndroid;
      } else {
        return kRewardAddIDiOS;
      }
    } else {
      return RewardedVideoAd.testAdUnitId;
    }
  }

  String _getAdAccountId() {
    if (Platform.isAndroid) {
      return kAppIDAndroid;
    } else {
      return kAppIDiOS;
    }
  }
}
