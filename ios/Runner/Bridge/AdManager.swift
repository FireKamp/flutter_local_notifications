//
//  AdManager.swift
//  Runner
//
//  Created by Kamran Pirwani on 3/21/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import MoPub

#if DEBUG || ((arch(i386) || arch(x86_64)) && os(iOS))
private enum AdIdentifier: String {
    case banner = "0ac59b0996d947309c33f59d6676399f"
    case interstitial = "4f117153f5c24fa6a3a92b818a5eb630"
    case reward = "8f000bd5e00246de9c789eed39ff6096"
}
#else
private enum AdIdentifier: String {
    case banner = "d461add2090246fc8cc90e1013fea995"
    case interstitial = "47ac05ce10a740379c97eb8bb538cb26"
    case reward = "b16545998e534585aee852322bdf253a"
}
#endif

private enum AdAdapterValueConstants: String {
    case gameId = "gameId"
    case appId = "appId"
    case applicationKey = "applicationKey"
}

private enum AdAdapterConstants: String {
    case unity = "UnityAdsAdapterConfiguration"
    case ironSource = "IronSourceAdapterConfiguration"
    case vungle = "VungleAdapterConfiguration"
}

public enum InterstitialAdEvent: Int {
    case willAppear = 0
    case didAppear = 1
    case willDisappear = 2
    case didDisappear = 3
}

public enum RewardAdEvent: Int {
    case notFetched = 0
    case failed = 1
    case willAppear = 2
    case didAppear = 3
    case willDisappear = 4
    case didDisappear = 5
    case reward = 6
}

@objcMembers
public class AdManager: NSObject {
    static let shared = AdManager()
    
    public var interstitialStream: ((_ status: InterstitialAdEvent) -> (Void))?
    public var rewardStream: ((_ status: RewardAdEvent) -> (Void))?

    private var bannerView: MPAdView
    private var interstitial: MPInterstitialAdController
    
    public var rootViewController: UIViewController!
    
    private var bannerAdSize: CGSize {
        let preset = UIDevice.current.userInterfaceIdiom == .pad ? kMPPresetMaxAdSize90Height : kMPPresetMaxAdSize50Height
        return preset
    }
    public override init() {
        bannerView = MPAdView(adUnitId: AdIdentifier.banner.rawValue)
        interstitial = MPInterstitialAdController(forAdUnitId: AdIdentifier.interstitial.rawValue)
        
        super.init()

        bannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.bannerAdSize.height)
        
        let config = MPMoPubConfiguration(adUnitIdForAppInitialization: AdIdentifier.banner.rawValue)
        let unitySettings = [AdAdapterValueConstants.gameId.rawValue: "3515410"]
        let ironsourceSettings = [AdAdapterValueConstants.applicationKey.rawValue: "b93ac8d5"]
        let vungleSettings = [AdAdapterValueConstants.appId.rawValue: "5e7761beaf441d0001b7e332"]

        config.mediatedNetworkConfigurations = [AdAdapterConstants.unity.rawValue: unitySettings,
                                                AdAdapterConstants.ironSource.rawValue: ironsourceSettings,
                                                AdAdapterConstants.vungle.rawValue: vungleSettings]
        config.globalMediationSettings = []
        config.loggingLevel = .info

        MoPub.sharedInstance().initializeSdk(with: config) {
            print("Initialized MP")
        }
        
        interstitial.delegate = self
        bannerView.delegate = self
        
        MPRewardedVideo.setDelegate(self, forAdUnitId: AdIdentifier.reward.rawValue)

    }
    
    func fetchAndLoadBanner() {
        if let _ = bannerView.superview {
            print("Fetching and loading when already visible")
        } else {
            print("Fetching banner ad")
            bannerView.loadAd(withMaxAdSize: bannerAdSize)
        }
    }
    
    func stopBannerRefresh() {
//        print("stopping ad refresh")
        //TODO: kpirwani dont do for now
//        bannerView.stopAutomaticallyRefreshingContents()
    }
    
    func resumeBannerRefresh() {
//        print("resuming ad refresh")
        //TODO: kpirwani dont do for now
//        bannerView.startAutomaticallyRefreshingContents()
    }
    
    func prefetchInterstitial() {
        print("Fetching interstitial ad")
        interstitial.loadAd()
    }
    
    func prefetchReward() {
        print("Fetching reward ad")
        MPRewardedVideo.loadAd(withAdUnitID: AdIdentifier.reward.rawValue, withMediationSettings: [])
    }
    
    func showInterstitialAd() {
        if interstitial.ready {
            print("Showing interstitial ad")
            interstitial.show(from: rootViewController)
        } else {
            prefetchInterstitial()
        }
    }
    
    func showRewardAd() {
        let adId = AdIdentifier.reward.rawValue
        if MPRewardedVideo.hasAdAvailable(forAdUnitID: adId) {
            guard let reward = MPRewardedVideo.availableRewards(forAdUnitID: adId)?.first, let mpReward = reward as? MPRewardedVideoReward else {
                assert(false, "Busted reward")
                return
            }
            print("Showing reward ad")
            MPRewardedVideo.presentAd(forAdUnitID: adId, from: rootViewController, with: mpReward)
        } else {
            prefetchReward()
            print("Tried to show reward ad, but not fetched")
            rewardStream?(.notFetched)
        }
    }
}

extension AdManager: MPAdViewDelegate {
    public func viewControllerForPresentingModalView() -> UIViewController! {
        return rootViewController
    }
    
    public func adViewDidLoadAd(_ view: MPAdView!, adSize: CGSize) {
        print("banner did load for id: \(view.adUnitId)")
        
        if bannerView.superview == nil {
            addBannerViewToView(bannerView)
        } else {
            print("banner ad refreshed")
        }
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        guard let rootView = rootViewController.view else { return }
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(bannerView)
        
        if #available(iOS 11.0, *) {
            let guide: UILayoutGuide = rootView.safeAreaLayoutGuide
            bannerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            bannerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            bannerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            bannerView.heightAnchor.constraint(equalToConstant: bannerView.bounds.size.height).isActive = true
        } else {
            let guide: UILayoutGuide = rootView.layoutMarginsGuide
            let left = NSLayoutConstraint(item: bannerView,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: guide,
                                                  attribute: .leading,
                                                  multiplier: 1,
                                                  constant: 0)
            let right = NSLayoutConstraint(item: bannerView,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: guide,
                                                  attribute: .trailing,
                                                  multiplier: 1,
                                                  constant: 0)
            let bottom = NSLayoutConstraint(item: bannerView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: guide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
            let height = NSLayoutConstraint(item: bannerView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: bannerView.bounds.size.height)
            NSLayoutConstraint.activate([
                left,
                right,
                bottom,
                height
            ])
      }
        rootView.layoutIfNeeded()
    }
    
    public func adView(_ view: MPAdView!, didFailToLoadAdWithError error: Error!) {
        print("banner failed to load: \(error.localizedDescription)")
        bannerView.removeFromSuperview()
    }
}

extension AdManager: MPInterstitialAdControllerDelegate {

    public func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial did load for id \(interstitial.adUnitId)")
    }
    
    public func interstitialWillAppear(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial will appear")
        interstitialStream?(.willAppear)
    }
    
    public func interstitialWillDisappear(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial will disappear")
        interstitialStream?(.willDisappear)
    }
    
    public func interstitialDidAppear(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial did appear")
        interstitialStream?(.didAppear)
    }
    
    public func interstitialDidDisappear(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial did disappear")
        interstitialStream?(.didDisappear)
    }
    
}

extension AdManager: MPRewardedVideoDelegate {
    public func rewardedVideoAdDidLoad(forAdUnitID adUnitID: String!) {
        print("reward did load for id \(adUnitID)")
    }
    
    public func rewardedVideoAdDidFailToLoad(forAdUnitID adUnitID: String!, error: Error!) {
        print("reward failed to load: \(error)")
        rewardStream?(.failed)
    }
    
    public func rewardedVideoAdDidFailToPlay(forAdUnitID adUnitID: String!, error: Error!) {
        print("reward failed to play: \(error)")
        rewardStream?(.failed)
    }
    
    public func rewardedVideoAdShouldReward(forAdUnitID adUnitID: String!, reward: MPRewardedVideoReward!) {
        print("reward received: \(reward.currencyType)")
        rewardStream?(.reward)
    }
    
    public func rewardedVideoAdDidExpire(forAdUnitID adUnitID: String!) {
        print("reward expired")
        rewardStream?(.failed)
    }
    
    public func rewardedVideoAdDidAppear(forAdUnitID adUnitID: String!) {
        print("reward did appear")
        rewardStream?(.didAppear)
    }
    
    public func rewardedVideoAdWillAppear(forAdUnitID adUnitID: String!) {
        print("reward will appear")
        rewardStream?(.willAppear)
    }
    
    public func rewardedVideoAdWillDisappear(forAdUnitID adUnitID: String!) {
        print("reward will disappear")
        rewardStream?(.willDisappear)
    }
    
    public func rewardedVideoAdDidDisappear(forAdUnitID adUnitID: String!) {
        print("reward did disappear")
        rewardStream?(.didDisappear)
    }
    
}
