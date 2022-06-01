//
//  SectorView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 06.05.2022.
//

import SwiftUI

struct SectorView: View {
    
    @Binding var sector: Sector
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                
                //TITLE
                HStack {
                    TextField("Enter Sector name", text: $sector.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                    if sector.mode == "Generation" {
                        Spacer()
                        Button {
                            sector.name = sector.randomSectorName()
                        } label: {
                            Image(systemName: "dice").font(.system(size: 20))
                        }
                        .padding(.trailing)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                    }
                }
               
                //TRAVEL BUTTONS
                if sector.travelMode {
                    VStack {
                        HStack(spacing: 15) {
                            Button {
                                displayText = sector.randomEncounter()
                            } label: {
                                Text("Space\n Encounters")
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                displayText = sector.randomPeril()
                            } label: {
                                Text("Spaceborne\n Peril")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                displayText = sector.randomOpportunity()
                            } label: {
                                Text("Spaceborne\n Opportunity")
                            }
                            .buttonStyle(BorderedButtonStyle())
                        }
                        ZStack(alignment: .center) {
                            Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6))
                                .frame(maxWidth: .infinity)
                                //.border(.gray, width: 2.5).opacity(0.5)
                                    VStack(alignment: .leading) {
                                        Text(displayText)
                                            .padding(.vertical, 7)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                        .padding(.top, 5)
                        .frame(minHeight: 40)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                List {
                    //STELLARS
                    if sector.stellarObjects != [] {
                        Section(header:
                                    HStack {
                            Text("Stellar Objects").font(.title)
                        Spacer()
                        Button {
                            sector.hiddenStellar.toggle()
                        } label: {
                            Image(systemName: sector.hiddenStellar ? "chevron.down" : "chevron.right")
                        }
                        }
                        ) {
                            if sector.hiddenStellar {
                                ForEach($sector.stellarObjects, id: \.id) { $stellarObject in
                                    NavigationLink(destination: StellarObjectView(stellarObject: $stellarObject, campaign: self.campaign)) {
                                        Text(stellarObject.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.stellarObjects.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //PLANETS
                    if sector.planets != [] {
                        Section(header:
                                    HStack {
                            Text("Planets").font(.title)
                        Spacer()
                        Button {
                            sector.hiddenPlanets.toggle()
                        } label: {
                            Image(systemName: sector.hiddenPlanets ? "chevron.down" : "chevron.right")
                        }
                        }
                        ) {
                            if sector.hiddenPlanets {
                                ForEach($sector.planets, id: \.id) { $planet in
                                        NavigationLink(destination: PlanetView(planet: $planet, campaign: self.campaign)) {
                                            Text(planet.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.planets.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //SETTLEMENTS
                    if sector.settlements != [] {
                        Section(header:
                                    HStack {
                            Text("Settlements").font(.title)
                        Spacer()
                        Button {
                            sector.hiddenSettlements.toggle()
                        } label: {
                            Image(systemName: sector.hiddenSettlements ? "chevron.down" : "chevron.right")
                        }
                        }
                        ) {
                            if sector.hiddenSettlements {
                                ForEach($sector.settlements, id: \.id) { $settlement in
                                    NavigationLink(destination: SettlementView(settlement: $settlement, campaign: self.campaign)) {
                                        Text(settlement.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.settlements.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //LOCATIONS
                    if sector.locations != [] {
                        Section(header:
                                    HStack {
                            Text("Locations").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenLocations.toggle()
                            } label: {
                                Image(systemName: sector.hiddenLocations ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenLocations {
                                ForEach($sector.locations, id: \.id) { $location in
                                    NavigationLink(destination: LocationView()) {
                                        Text(location.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.locations.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //PRECURSOR VAULT
                    if sector.vaults != [] {
                        Section(header:
                                    HStack {
                            Text("Precursor Vaults").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenVault.toggle()
                            } label: {
                                Image(systemName: sector.hiddenVault ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenVault {
                                ForEach($sector.vaults, id: \.id) { $vault in
                                    NavigationLink(destination: PrecursorVaultsView(vault: $vault, campaign: self.campaign)) {
                                        Text(vault.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.vaults.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //FACTIONS
                    if sector.factions != [] {
                        Section(header:
                                    HStack {
                            Text("Factions").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenFactions.toggle()
                            } label: {
                                Image(systemName: sector.hiddenFactions ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenFactions {
                                ForEach($sector.factions, id: \.id) { $faction in
                                   NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                       Text(faction.name)
                                   }
                               }.onDelete { (indexSet) in
                                   sector.factions.remove(atOffsets: indexSet)
                               }
                            }
                        }
                    }
                    
                    //CREATURES
                    if sector.creatures != [] {
                        Section(header:
                                    HStack {
                            Text("Creatures").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenCreatures.toggle()
                            } label: {
                                Image(systemName: sector.hiddenCreatures ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenCreatures {
                                ForEach($sector.creatures, id: \.id) { $creature in
                                    NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                        Text(creature.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.creatures.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //VEHICLES
                    if sector.vehicles != [] {
                        Section(header:
                                    HStack {
                            Text("Starships").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenVehicles.toggle()
                            } label: {
                                Image(systemName: sector.hiddenVehicles ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenVehicles {
                                ForEach($sector.vehicles, id: \.id) { $vehicle in
                                    NavigationLink(destination: StarshipView(starship: $vehicle, campaign: Campaign())) {
                                        Text(vehicle.name)
                                    }
                                }.onDelete { (indexSet) in
                                    sector.vehicles.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }

                    //DESCRIPTIONS
                    if sector.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenVehicles.toggle()
                            } label: {
                                Image(systemName: sector.hiddenVehicles ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenDescription {
                                TextEditor(text: $sector.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                }.listStyle(.inset)
            }
            .navigationTitle(sector.name)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        Group {
                            Toggle(isOn: $sector.travelMode) {
                                Text("Travel Mode")
                            }
                            Menu {
                                if sector.mode != "Input" {
                                    Button {
                                        sector.mode = "Input"
                                    } label: {
                                        Text("Input")
                                    }
                                }
    //                            if sector.mode != "Selection" {
    //                                Button {
    //                                    sector.mode = "Selection"
    //                                } label: {
    //                                    Text("Selection")
    //                                }
    //                            }
                                if sector.mode != "Generation" {
                                    Button {
                                        sector.mode = "Generation"
                                    } label: {
                                        Text("Generation")
                                    }
                                }
                            } label: {
                                Text("Mode")
                            }
                            if sector.description == "" {
                                Button {
                                    campaign.writeToFile()
                                    sector.description = " "
                                } label: {
                                    Text("Add Description")
                                }
                            }

                            Button {
                                campaign.writeToFile()
                                sector.stellarObjects.insert(StellarObject(name: sector.randomStarName(), homeSector: sector.name), at: 0)
                            } label: {
                                Text("Add Stellar Object")
                            }
                            
                            Button {
                                campaign.writeToFile()
                                sector.planets.insert(Planet(homeSector: sector.name, homeStar: "Wandering", name: sector.randomRoguePlanetName()), at: 0)
                            } label: {
                                Text("Add Wandering Planet")
                            }
                            
                            Button {
                                campaign.writeToFile()
                                sector.settlements.insert(Settlement(homeSector: sector.name), at: 0)
                            } label: {
                                Text("Add Settlement")
                            }
                            
                        }
                        Group {
                            Button {
                                campaign.writeToFile()
                                sector.vaults.insert(PrecursorVaults(name: "Unknown Vault"), at: 0)
                            } label: {
                                Text("Add Precursor Vault")
                            }
                            Button {
                                campaign.writeToFile()
                                sector.locations.insert(Location(name: "Unknown Location"), at: 0)
                            } label: {
                                Text("Add Location")
                            }
                            Button {
                                campaign.writeToFile()
                                sector.factions.append(Faction())
                            } label: {
                                Text("Add Faction")
                            }
                            Button {
                                campaign.writeToFile()
                                sector.creatures.insert(Creature(homeSector: sector.name, name: "Unknown Creature"), at: 0)
                            } label: {
                                Text("Add Creature")
                            }
                            
                            Button {
                                campaign.writeToFile()
                                sector.vehicles.insert(Starship(name: Starship.randomName(mod: ""), homeSector: sector.name), at: 0)
                            } label: {
                                Text("Add Starship")
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct SectorView_Previews: PreviewProvider {
    static var previews: some View {
        SectorView(sector: .constant(Sector(travelMode: true)), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
