//
//  SwiftUIMobileAdsExampleApp.swift
//  SwiftUIMobileAdsExample
//
//  Created by Patrick Haertel on 5/24/21.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds

@main
struct SwiftUIMobileAdsExampleApp: App {
    
    init() {
        ATTrackingManager.requestTrackingAuthorization { status in
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
