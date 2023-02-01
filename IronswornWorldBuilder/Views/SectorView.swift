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
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                
                //TITLE
                HStack {
                    TextField(campaign.world.sectorIsLand ? "Enter Land name" : "Enter Sector name", text: $sector.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                    if sector.mode == "Generation" && campaign.world.sectorIsLand == false {
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
                                    NavigationLink(destination: LocationView(location: $location, campaign: self.campaign)) {
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
                                sector.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: sector.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenDescription {
                                TextEditor(text: $sector.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                    // CLOCK
                    if sector.clocks != [] {
                        Section(header:
                                    HStack {
                            Text("Clocks").font(.title)
                            Spacer()
                            Button {
                                sector.hiddenClock.toggle()
                            } label: {
                                Image(systemName: sector.hiddenClock ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if sector.hiddenClock {
                                ForEach($sector.clocks, id: \.id) { $clock in
                                    NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                        Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                   }
                               }.onDelete { (indexSet) in
                                   sector.clocks.remove(atOffsets: indexSet)
                               }

                            }
                        }
                    }
                }.listStyle(.inset)
            }
            .navigationTitle(sector.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        Group {
                            if sector.waitingForFaction {
                                Button {
                                    sector.factions.insert(buffer.factionBuffer[0], at: 0)
                                    buffer.factionBuffer = []
                                    sector.waitingForFaction = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the faction")
                                }
                            }
                            if sector.waitingForStarship {
                                Button {
                                    sector.vehicles.insert(buffer.starshipBuffer[0], at: 0)
                                    sector.vehicles[0].homeSector = sector.name
                                    buffer.starshipBuffer = []
                                    sector.waitingForStarship = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the starship")
                                }
                            }
                            if sector.waitingForSettlement {
                                Button {
                                    sector.settlements.insert(buffer.settlementBuffer[0], at: 0)
                                    sector.settlements[0].homeSector = sector.name
                                    buffer.settlementBuffer = []
                                    sector.waitingForSettlement = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the settlement")
                                }
                            }
                            if sector.waitingForCreature {
                                Button {
                                    sector.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                    sector.creatures[0].homeSector = sector.name
                                    buffer.creatureBuffer = []
                                    sector.waitingForCreature = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the ctreature")
                                }
                            }
                        }
                        Group {
                            if campaign.world.sectorIsLand == false {
                                Toggle(isOn: $sector.travelMode) {
                                    Text("Travel Mode")
                                }
                            }
                            if campaign.world.sectorIsLand == false {
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
                            }
                        }
                        Menu {
                            if sector.description == "" {
                                Button {
                                    sector.description = " "
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Description")
                                }
                            }

                            if campaign.world.sectorIsLand == false {
                                Button {
                                    sector.stellarObjects.insert(StellarObject(name: sector.randomStarName(), homeSector: sector.name), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Stellar Object")
                                }
                            }
                            
                            if campaign.world.sectorIsLand == false {
                                Button {
                                    sector.planets.insert(Planet(homeSector: sector.name, homeStar: "Wandering", name: sector.randomRoguePlanetName()), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Wandering Planet")
                                }
                            }
                            
                            Button {
                                sector.settlements.insert(Settlement(name: NSLocalizedString("Unknown", comment: ""), subName: NSLocalizedString("Settlement", comment: ""), homeSector: sector.name), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Add Settlement")
                            }
                            if campaign.world.sectorIsLand == false {
                                Button {
                                    sector.vaults.insert(PrecursorVaults(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Precursor Vault")
                                }
                            }
                            
                            Button {
                                sector.locations.insert(Location(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Add Location")
                            }
                            Button {
                                sector.factions.insert(Faction(), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Add Faction")
                            }
                            Button {
                                sector.creatures.insert(Creature(homeSector: sector.name, name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Add Creature")
                            }
                            
                            if campaign.world.sectorIsLand == false {
                                Button {
                                    sector.vehicles.insert(Starship(name: Starship.randomName(mod: ""), homeSector: sector.name), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Starship")
                                }
                            }
                            Button {
                                sector.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                                sector.hiddenClock = true
                                campaign.writeToFile()
                            } label: {
                                Text("Add Clock")
                            }
                        } label: {
                            Text("Add")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            if buffer.starshipBuffer != [] {
                sector.waitingForStarship = true
            } else {
                sector.waitingForStarship = false
            }
            if buffer.settlementBuffer != [] {
                sector.waitingForSettlement = true
            } else {
                sector.waitingForSettlement = false
            }
            if buffer.creatureBuffer != [] {
                sector.waitingForCreature = true
            } else {
                sector.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                sector.waitingForFaction = true
            } else {
                sector.waitingForFaction = false
            }
            
            for _ in sector.factions {
                if let index = sector.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    sector.factions.remove(at: index)
                }
            }
            for _ in sector.creatures {
                if let index = sector.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    sector.creatures.remove(at: index)
                }
            }
            for _ in sector.vehicles {
                if let index = sector.vehicles.firstIndex(where: { $0.name == "toDelate" }) {
                    sector.vehicles.remove(at: index)
                }
            }
            for _ in sector.settlements {
                if let index = sector.settlements.firstIndex(where: { $0.name == "toDelate" }) {
                    sector.settlements.remove(at: index)
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
