import 'dart:async';
import 'package:flutter/services.dart';

enum InterstitialAdStatus {
  willAppear,
  didAppear,
  willDisappear,
  didDisappear
}

enum RewardAdStatus {
  notFetched,
  failed,
  willAppear,
  didAppear,
  willDisappear,
  didDisappear,
  reward
}

class AdManager {
  static Function(RewardAdStatus) rewardEvents;
  static Function(InterstitialAdStatus) interstitialEvents;

  static var _methodChannel = MethodChannel('com.matchalagames.sudokubrain/method_channel');
  static var _rewardStream = EventChannel('com.matchalagames.sudokubrain/reward_stream');
  static var _interstitialStream = EventChannel('com.matchalagames.sudokubrain/interstitial_stream');

  static StreamSubscription interstitialStream;
  static StreamSubscription rewardStream;

  static startListening() {
    rewardStream = _rewardStream.receiveBroadcastStream().listen(_updateRewardFromStream);
    interstitialStream = _interstitialStream.receiveBroadcastStream().listen(_updateInterstitialFromStream);
  }

  static void _updateRewardFromStream(statusValue) {
    print('Reward ad with value');
    print(statusValue);
    var status = RewardAdStatus.values[statusValue];
    if (rewardEvents != null) {
      rewardEvents(status);
    }
  }

  static void _updateInterstitialFromStream(statusValue) {
    var status = InterstitialAdStatus.values[statusValue];
    if (interstitialEvents != null) {
      interstitialEvents(status);
    }

  }
  static stopListening() {
    if (interstitialStream != null) {
      interstitialStream.cancel();
      interstitialStream = null;
    }

    if (rewardStream != null) {
      rewardStream.cancel();
      rewardStream = null;
    }
  }

  static showBannerAd() {
    try {
      print("Attempting to show banner ad");
      _methodChannel.invokeMethod('fetchAndLoadBanner');
    } on PlatformException catch (e) {
      print("Error showing banner from bridge ${e.message}");
    }
  }

  static precacheInterstitialAd() {
    try {
      print("Attempting to show precache interstitial ad");
      _methodChannel.invokeMethod('prefetchInterstitial');
    } on PlatformException catch (e) {
      print("Error precaching interstitial from bridge ${e.message}");
    }
  }

  static precacheRewardAd() {
    try {
      print("Attempting to show precache reward ad");
      _methodChannel.invokeMethod('prefetchReward');
    } on PlatformException catch (e) {
      print("Error precaching interstitial from bridge ${e.message}");
    }
  }

  static showInterstitialAd() {
    try {
      print("Attempting to show interstitial ad");
      _methodChannel.invokeMethod('showInterstitialAd');
    } on PlatformException catch (e) {
      print("Error showing interstitial from bridge ${e.message}");
    }
  }

  static showRewardAd() {
    try {
      print("Attempting to show reward ad");
      _methodChannel.invokeMethod('showRewardAd');
    } on PlatformException catch (e) {
      print("Error showing reward from bridge ${e.message}");
    }
  }

}
