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
                            Text("Sectors").font(.title)
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        Button {
                            campaign.writeToFile()
                            region.factions.append(Faction())
                        } label: {
                            Text("Add Faction")
                        }
                        if region.description == "" {
                            Button {
                                campaign.writeToFile()
                                region.description = " "
                            } label: {
                                Text("Add Description")
                            }
                        }

                        Button {
                            campaign.writeToFile()
                            region.sectors.insert(Sector(name: "Unknown Sector", homeRegion: region.name), at: 0)
                        } label: {
                            Text("Add Sector")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
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
