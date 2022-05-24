//
//  RootView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var campaign: Campaign// = Campaign()
    @State private var openedLoadView = false
    @State private var isShowingRegionView = false
    @FocusState private var fieldIsFocused: Bool
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.clear]
        }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Enter Campaign name", text: $campaign.world.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                    TextField("Another campaign info", text: $campaign.world.subName)
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
                List {
                    // REGIONS
                    if campaign.world.regions != [] {
                        Section(header:
                                    HStack {
                            Text("Regions").font(.title)
                            Spacer()
                            Button {
                                campaign.world.hiddenRegions.toggle()
                            } label: {
                                Image(systemName: campaign.world.hiddenRegions ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if campaign.world.hiddenRegions {
                                ForEach($campaign.world.regions, id: \.id) { $region in
                                   NavigationLink(destination: RegionView(region: $region, campaign: self.campaign)) {
                                       Text(region.name)
                                   }
                               }.onDelete { (indexSet) in
                                   campaign.world.regions.remove(atOffsets: indexSet)
                               }
                            }
                        }
                    }
                    
                    // DESCRIPTION
                    if campaign.world.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                campaign.world.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: campaign.world.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if campaign.world.hiddenDescription {
                                TextEditor(text: $campaign.world.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                    
                    // TRUTH
                    if campaign.world.truth != [] {
                        Section(header:
                                    HStack {
                            Text("Your Truth").font(.title)
                            Spacer()
                            Button {
                                campaign.world.hiddenTruth.toggle()
                            } label: {
                                Image(systemName: campaign.world.hiddenTruth ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if campaign.world.hiddenTruth {
                                ForEach($campaign.world.truth, id: \.id) { $truth in
                                    NavigationLink(destination: YourTruthView(campaign: self.campaign, truth: $truth)) {
                                       Text(truth.title)
                                   }
                               }.onDelete { (indexSet) in
                                   campaign.world.truth.remove(atOffsets: indexSet)
                               }

                            }
                        }
                    }
                }.listStyle(.inset)

            }
            .navigationTitle(campaign.world.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .cancellationAction) {
                    Menu  {
                        Button {
                            openedLoadView.toggle()
                        } label: {
                            Text("Load Campaign")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            campaign.getStarforged()
                        } label: {
                            Text("New Strforged Campaign")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            campaign.getStarSystem()
                        } label: {
                            Text("New Custom Star System")
                        }.disabled(true)
                        
                        Button {
                            //
                        } label: {
                            Text("New Ironsworn Campaign")
                        }.disabled(true)
                        
                        Button {
                            //
                        } label: {
                            Text("New Custom World")
                        }.disabled(true)
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        if campaign.world.type == "IS" || campaign.world.type == "SF" {
                            Menu {
                                Button {
                                    campaign.writeToFile()
                                    campaign.world.truth.insert(YourTruth(title: "New Truth"), at: 0)
                                } label: {
                                    Text("Add Truth")
                                }
                                Button {
                                    campaign.writeToFile()
                                    //
                                } label: {
                                    Text("Generate Truth")
                                }
                                .disabled(true)
                            } label: {
                                Text("Your Truth")
                            }
                        } else {
                            Button {
                                campaign.writeToFile()
                                campaign.world.truth.insert(YourTruth(title: "New Truth"), at: 0)
                            } label: {
                                Text("Add Truth")
                            }
                        }
                        if campaign.world.description == "" {
                            Button {
                                campaign.writeToFile()
                                campaign.world.description = " "
                            } label: {
                                Text("Add Description")
                            }
                        }
                        
                        Button {
                            campaign.writeToFile()
                            campaign.world.regions.append(Region(name: "New Region"))
                        } label: {
                            Text("Add Region")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $openedLoadView) {
            LoadView(campaign: self.campaign)
        }
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
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Campaign())
    }
}
