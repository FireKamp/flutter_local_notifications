import 'package:firebase_admob/firebase_admob.dart';

class AdMobIntegration {
  static String testDevice = 'MobileId';
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Sudoku'],
  );

  static BannerAd _bannerAd;

  static initAd() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = _createBannerAd()
      ..load()
      ..show();
  }

  static BannerAd _createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  static dispose() {
    if (_bannerAd != null) _bannerAd.dispose();
  }
}
