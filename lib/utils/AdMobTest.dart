import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class AdMobIntegrationTest {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: [],
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Sudoku'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  final Function adRewarded;

  AdMobIntegrationTest({this.adRewarded});

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
    RewardedVideoAd.instance.load(
        adUnitId: _getRewardAdID(), targetingInfo: targetingInfo);
    RewardedVideoAd.instance.show();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('eventUp: $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        adRewarded();
      }
    };
  }

  BannerAd _createBannerAd() {
    return BannerAd(
        adUnitId: _getBannerID(),
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: _getInterstitialAdID(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  void dispose() {
    if (_bannerAd != null) _bannerAd.dispose();
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
