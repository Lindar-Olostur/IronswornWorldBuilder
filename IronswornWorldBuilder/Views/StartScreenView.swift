//
//  StartScreenView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct StartScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var campaign: Campaign
    @State private var openedLoadView = false {
        didSet {
            if oldValue == true {
                self.presentationMode.wrappedValue.dismiss()
                //print("Start changed - \(didLoaded)")
            }
        }
    }
    //@State var didLoaded: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Button {
                openedLoadView.toggle()
            } label: {
                Text("Load Campaign")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $openedLoadView) {
                LoadView(campaign: self.campaign)//, didLoaded: $didLoaded)
            }
            
            Button {
                campaign.getStarforged()
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("New Strforged Campaign")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                //
            } label: {
                Text("New Custom Star System")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            .disabled(true)
            
            Button {
                //
            } label: {
                Text("New Ironsworn Campaign")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            .disabled(true)
            
            Button {
                //
            } label: {
                Text("New Custom World")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            .disabled(true)
            
            Button {
                //print("Start - \(didLoaded)")
                //didLoaded = true
            } label: {
                Text("Back")
                    .font(.title)
                    .frame(width: 240, height: 70)
            }
            .buttonStyle(.borderedProminent)
            //.disabled(true)
        }
        .onAppear {
            //print("Start appear - \(didLoaded)")
        }
    }
}

struct StartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreenView(campaign: Campaign())
    }
}
