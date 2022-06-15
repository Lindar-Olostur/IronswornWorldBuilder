//
//  FirstLaunchView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 15.06.2022.
//

import SwiftUI

struct FirstLaunchView: View {
    @ObservedObject var campaign: Campaign
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 60) {
            Button {
                campaign.getStarforged()
                UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
                self.presentationMode.wrappedValue.dismiss()
                campaign.writeToFile()
            } label: {
                Text("New Strforged Campaign")
                    .font(.system(size: 30))
            }.buttonStyle(.bordered)
            
            Button {
                campaign.getStarSystem()
                UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
                self.presentationMode.wrappedValue.dismiss()
                campaign.writeToFile()
            } label: {
                Text("New Custom Star System")
                    .font(.system(size: 30))
            }.buttonStyle(.bordered)
            
            Button {
                campaign.getIronsworn()
                UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
                self.presentationMode.wrappedValue.dismiss()
                campaign.writeToFile()
            } label: {
                Text("New Ironsworn Campaign")
                    .font(.system(size: 30))
            }.buttonStyle(.bordered)
            
            Button {
                campaign.getWorld()
                UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
                self.presentationMode.wrappedValue.dismiss()
                campaign.writeToFile()
            } label: {
                Text("New Custom World")
                    .font(.system(size: 30))
            }.buttonStyle(.bordered)

        }
    }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView(campaign: Campaign())
    }
}
