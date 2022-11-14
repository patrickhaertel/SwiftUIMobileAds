//
//  RewardedAd.swift
//  SwiftUIMobileAds
//
//  Created by Patrick Haertel on 5/23/21.
//

import GoogleMobileAds
import SwiftUI
import UIKit

class RewardedAd: NSObject {
    var rewardedAd: GADRewardedAd?
    
    static let shared = RewardedAd()
    
    func loadAd(withAdUnitId id: String) {
        let req = GADRequest()
        GADRewardedAd.load(withAdUnitID: id, request: req) { rewardedAd, err in
            if let err = err {
                print("Failed to load ad with error: \(err)")
                return
            }
            
            self.rewardedAd = rewardedAd
        }
    }
}

struct RewardedAdView: UIViewControllerRepresentable {
    
    let rewardedAd = RewardedAd.shared.rewardedAd
    @Binding var isPresented: Bool
    let adUnitId: String
    let rewardFunc: (() -> Void)
    
    init(isPresented: Binding<Bool>, adUnitId: String, rewardFunc: @escaping (() -> Void)) {
        self._isPresented = isPresented
        self.adUnitId = adUnitId
        self.rewardFunc = rewardFunc
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.showAd(from: view)
        }
        
        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func showAd(from root: UIViewController) {
        
        if let ad = rewardedAd {
            ad.present(fromRootViewController: root) {
                self.rewardFunc()
            }
        } else {
            print("Ad not ready")
            self.isPresented.toggle()
        }
    }
    
    class Coordinator: NSObject, GADFullScreenContentDelegate {
        let parent: RewardedAdView
        
        init(parent: RewardedAdView) {
            self.parent = parent
            super.init()
            parent.rewardedAd?.fullScreenContentDelegate = self
        }
        
        func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            RewardedAd.shared.loadAd(withAdUnitId: parent.adUnitId)
            
            parent.isPresented.toggle()
        }
    }
}
