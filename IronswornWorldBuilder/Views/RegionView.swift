//
//  RegionsView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct RegionView: View {
    @Binding var region: Region
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Enter Region name", text: $region.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
               
                List {
                    if region.sectors != [] {
                        Section(header:
                                    HStack {
                            Text(campaign.world.sectorIsLand ? "Lands" : "Sectors").font(.title)
                            Spacer()
                            Button {
                                region.hiddenSectors.toggle()
                            } label: {
                                Image(systemName: region.hiddenSectors ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if region.hiddenSectors {
                                ForEach($region.sectors, id: \.id) { $sector in
                                    NavigationLink(destination: SectorView(sector: $sector, campaign: self.campaign)) {
                                        Text(sector.name)
                                    }
                                }.onDelete { (indexSet) in
                                    region.sectors.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    if region.factions != [] {
                        Section(header:
                                    HStack {
                            Text("Factions").font(.title)
                            Spacer()
                            Button {
                                region.hiddenFactions.toggle()
                            } label: {
                                Image(systemName: region.hiddenFactions ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if region.hiddenFactions {
                                ForEach($region.factions, id: \.id) { $faction in
                                   NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                       Text(faction.name)
                                   }
                               }.onDelete { (indexSet) in
                                   region.factions.remove(atOffsets: indexSet)
                               }
                            }
                        }
                    }
                    if region.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                        region.hiddenDescription.toggle()
                    } label: {
                        Image(systemName: region.hiddenDescription ? "chevron.down" : "chevron.right")
                    }
                        }
                        ) {
                            if region.hiddenDescription {
                                TextEditor(text: $region.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                }.listStyle(.inset)
                
            }
            .navigationTitle(region.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        if region.waitingForFaction {
                            Button {
                                region.factions.insert(buffer.factionBuffer[0], at: 0)
                                buffer.factionBuffer = []
                                region.waitingForFaction = false
                                region.hiddenFactions = true
                                campaign.writeToFile()
                            } label: {
                                Text("Insert the faction")
                            }
                        }
                        Button {
                            region.factions.insert(Faction(), at: 0)
                            region.hiddenFactions = true
                            campaign.writeToFile()
                        } label: {
                            Text("Add Faction")
                        }
                        if region.description == "" {
                            Button {
                                region.description = "Enter your description"
                                campaign.writeToFile()
                            } label: {
                                Text("Add Description")
                            }
                        }

                        Button {
                            region.sectors.insert(Sector(name: campaign.world.sectorIsLand ? "Unknown Land" : "Unknown Sector", homeRegion: region.name), at: 0)
                            region.hiddenSectors = true
                            campaign.writeToFile()
                        } label: {
                            Text(campaign.world.sectorIsLand ? "Add Land" : "Add Sector")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            if buffer.factionBuffer != [] {
                region.waitingForFaction = true
            } else {
                region.waitingForFaction = false
            }
            
            for _ in region.factions {
                if let index = region.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    region.factions.remove(at: index)
                }
            }
        }
    }
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionView(region: .constant(Region()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
