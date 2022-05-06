//
//  IronswornWorldBuilderApp.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import SwiftUI

@main
struct IronswornWorldBuilderApp: App {
    @StateObject var campaign: Campaign = Campaign()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(campaign)
        }
    }
}
