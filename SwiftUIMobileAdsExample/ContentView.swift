//
//  ContentView.swift
//  SwiftUIMobileAdsExample
//
//  Created by Patrick Haertel on 5/24/21.
//

import SwiftUI
import SwiftUIMobileAds

struct ContentView: View {
    @State var showRewardedAd: Bool = false
    @State var showIntersitialAd: Bool = false
    @State var rewardGranted: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if rewardGranted {
                    Text("Here's a gift 🎁")
                } else {
                    Button("Get a Reward") {
                        showRewardedAd.toggle()
                    }
                }
                
                Button("Show Interstitial Ad") {
                    showIntersitialAd.toggle()
                }
                .padding()
                .foregroundColor(Color(.systemPurple))
            }
            
            SwiftUIBannerAd(adPosition: .bottom, adUnitId: SwiftUIMobileAds.testBannerId)
        }
        .presentRewardedAd(isPresented: $showRewardedAd, adUnitId: SwiftUIMobileAds.testRewardedId) {
            print("Reward Granted")
            rewardGranted.toggle()
        }
        .presentInterstitialAd(isPresented: $showIntersitialAd, adUnitId: SwiftUIMobileAds.testInterstitialId)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
