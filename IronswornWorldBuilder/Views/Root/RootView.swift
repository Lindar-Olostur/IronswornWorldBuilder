//
//  RootView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var campaign: Campaign
    @State private var openedStartScreen = false
    @State private var openedLoadView = false
    @State private var openedRootEditView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                
                List {
                    if campaign.world.regions != [] {
                        Section(header: Text("Regions").font(.title)) { ForEach(campaign.world.regions, id: \.self) { region in
                            NavigationLink {
                                RegionView(campaign: self.campaign, region: region)
                            } label: {
                                Text(NSLocalizedString(region.name, comment: ""))
                            }
                            
                        }
                        }
                    }
                    if campaign.world.description != "" {
                        Section("Description") {
                            Text("\(campaign.world.description)")
                        }
                    }
                    
                }
                .listStyle(.sidebar)
                .navigationTitle(campaign.world.name)
                //.navigationTitle(campaign.world.subName)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem {
                        Button {
                            openedStartScreen.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
//                        .fullScreenCover(isPresented: $openedStartScreen) {
//                            StartScreenView(campaign: self.campaign)
//                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button {
                            campaign.writeToFile()
                            self.openedRootEditView.toggle()
                        } label: {
                            Text("Edit")
                        }
                        .fullScreenCover(isPresented: $openedRootEditView) {
                            RootEditView()
                        }
                    }
                }
            }
            //        .onAppear {
            //            print(UUID())
            //            if UserDefaults.standard.string(forKey: "lastCampaign") != "" {
            //                openedStartScreen = false
            //            } else {
            //                openedStartScreen = true
            //            }
            //        }
            
            
            
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    if let last = UserDefaults.standard.string(forKey: "lastCampaign") {
                        campaign.getData(file: "\(last).json")}
                }
                else if newPhase == .inactive {
                    campaign.writeToFile()
                }
                else if newPhase == .background {
                    campaign.writeToFile()
                }
            }
            
            if openedStartScreen {
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
                        LoadView(campaign: self.campaign)
                    }
                    
                    Button {
                        campaign.getStarforged()
                        //self.presentationMode.wrappedValue.dismiss()
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
                        openedStartScreen.toggle()
                    } label: {
                        Text("Back")
                            .font(.title)
                            .frame(width: 240, height: 70)
                    }
                    .buttonStyle(.borderedProminent)
                    //.disabled(true)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Campaign())
    }
}
