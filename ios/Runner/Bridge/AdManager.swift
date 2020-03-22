//
//  AdManager.swift
//  Runner
//
//  Created by Kamran Pirwani on 3/21/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import MoPub

#if DEBUG
private enum AdIdentifier: String {
    case banner = "0ac59b0996d947309c33f59d6676399f"
    case interstitial = "4f117153f5c24fa6a3a92b818a5eb630"
    case reward = "8f000bd5e00246de9c789eed39ff6096"
}
#else
private enum AdIdentifier: String {
    case banner = "0ac59b0996d947309c33f59d6676399f"
    case interstitial = "4f117153f5c24fa6a3a92b818a5eb630"
    case reward = "8f000bd5e00246de9c789eed39ff6096"
//    case banner = "d461add2090246fc8cc90e1013fea995"
//    case interstitial = "47ac05ce10a740379c97eb8bb538cb26"
//    case reward = "b16545998e534585aee852322bdf253a"
}
#endif

public enum InterstitialAdEvent: Int {
    case willAppear = 1
    case didAppear = 2
    case willDisappear = 3
    case didDisappear = 4
}

public enum RewardAdEvent: Int {
    case notFetched = 1
    case failed = 2
    case willAppear = 3
    case didAppear = 4
    case willDisappear = 5
    case didDisappear = 6
    case reward = 7
}

@objcMembers
public class AdManager: NSObject {
    static let shared = AdManager()
    
    public var interstitialStream: ((_ status: InterstitialAdEvent) -> (Void))?
    public var rewardStream: ((_ status: RewardAdEvent) -> (Void))?

    private var bannerView = MPAdView(adUnitId: AdIdentifier.banner.rawValue)
    private var interstitial = MPInterstitialAdController(forAdUnitId: AdIdentifier.interstitial.rawValue)
    
    public var rootViewController: UIViewController!
    
    public override init() {
        super.init()
        MPRewardedVideo.setDelegate(self, forAdUnitId: AdIdentifier.reward.rawValue)
        bannerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
        bannerView?.delegate = self
        interstitial?.delegate = self
        
        let config = MPMoPubConfiguration(adUnitIdForAppInitialization: AdIdentifier.banner.rawValue)
        
        config.globalMediationSettings = []
        config.loggingLevel = .debug

        MoPub.sharedInstance().initializeSdk(with: config) {
            print("Initialized MP")
        }
    }
    
    func fetchAndLoadBanner() {
        if let _ = bannerView?.superview {
            print("Fetching and loading when already visible")
        } else {
            //TODO: Should factor in multi device sizes eventually
            print("Fetching banner ad")
            bannerView?.loadAd(withMaxAdSize: kMPPresetMaxAdSize50Height)
        }
    }
    
    func prefetchInterstitial() {
        print("Fetching interstitial ad")
        interstitial?.loadAd()
    }
    
    func prefetchReward() {
        print("Fetching reward ad")
        MPRewardedVideo.loadAd(withAdUnitID: AdIdentifier.reward.rawValue, withMediationSettings: [])
    }
    
    func showInterstitialAd() {
        if interstitial?.ready ?? false {
            print("Showing interstitial ad")
            interstitial?.show(from: rootViewController)
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
        print("banner did load")
        
        if bannerView?.superview == nil {
            guard let rootView = rootViewController.view else { return }
            view.frame = CGRect(x: (rootViewController.view.bounds.width - adSize.width)/2, y: rootViewController.view.bounds.height - adSize.height, width: adSize.width, height: adSize.height)
            rootView.addSubview(view)
            rootView.layoutIfNeeded()
        } else {
            print("banner ad refreshed")
        }
    }
    
    public func adView(_ view: MPAdView!, didFailToLoadAdWithError error: Error!) {
        print("banner failed to load: \(error.localizedDescription)")
        bannerView?.removeFromSuperview()
    }
}

extension AdManager: MPInterstitialAdControllerDelegate {

    public func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        print("Interstitial did load")
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
        print("reward did load")
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
