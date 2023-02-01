//
//  StellarObjectView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct StellarObjectView: View {
    @Binding var stellarObject: StellarObject
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Enter Stellar Object name", text: $stellarObject.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
                
                
               
                List {
                    //TYPE
                    Section(header: Text("Type").font(.title)) {
                        if stellarObject.mode == "Input" {
                            TextField("Enter Stellar Object class", text: $stellarObject.type).focused($fieldIsFocused)
                        }
                        if stellarObject.mode == "Generation" {
                            HStack {
                                TextField("Enter Stellar Object class", text: $stellarObject.type).focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    stellarObject.type = stellarObject.randomType()
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            }
                        }
                        if stellarObject.mode == "Selection" {
                            Picker(selection: $stellarObject.type, label: EmptyView()) {
                                ForEach(stellarObject.typeList, id: \.self) { value in
                                    Text(value).font(.system(size: 50))
                                        .tag(value)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                    
                    //PLANETS
                    if stellarObject.planets != [] {
                        Section(header:
                                    HStack {
                            Text("Planets").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenPlanets.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenPlanets ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenPlanets {
                                ForEach($stellarObject.planets, id: \.id) { $planet in
                                        NavigationLink(destination: PlanetView(planet: $planet, campaign: self.campaign)) {
                                            Text(planet.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.planets.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //FACTIONS
                    if stellarObject.factions != [] {
                        Section(header:
                                    HStack {
                            Text("Factions").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenFactions.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenFactions ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenFactions {
                                ForEach($stellarObject.factions, id: \.id) { $faction in
                                   NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                       Text(faction.name)
                                   }
                               }.onDelete { (indexSet) in
                                   stellarObject.factions.remove(atOffsets: indexSet)
                               }
                            }
                        }
                    }
                    
                    //SETTLEMENTS
                    if stellarObject.settlements != [] {
                        Section(header:
                                    HStack {
                            Text("Settlements").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenSettlements.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenSettlements ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenSettlements {
                                ForEach($stellarObject.settlements, id: \.id) { $settlement in
                                    NavigationLink(destination: SettlementView(settlement: $settlement, campaign: self.campaign)) {
                                        Text(settlement.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.settlements.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //PRECURSOR VAULT
                    if stellarObject.vaults != [] {
                        Section(header:
                                    HStack {
                            Text("Precursor Vaults").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenVault.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenVault ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenVault {
                                ForEach($stellarObject.vaults, id: \.id) { $vault in
                                    NavigationLink(destination: PrecursorVaultsView(vault: $vault, campaign: self.campaign)) {
                                        Text(vault.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.vaults.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //ROUTES
                    if stellarObject.routes != [] {
                        Section(header:
                                    HStack {
                            Text("Routes").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenRoutes.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenRoutes ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenRoutes {
                                ForEach($stellarObject.routes, id: \.id) { $route in
                                    NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                        Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.routes.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }

//                    //LOCATION
//                    if stellarObject.locations != [] {
//                        Section(header:
//                                    HStack {
//                            Text("Locations").font(.title)
//                            Spacer()
//                            Button {
//                                stellarObject.hiddenLocations.toggle()
//                            } label: {
//                                Image(systemName: stellarObject.hiddenLocations ? "chevron.down" : "chevron.right")
//                            }
//                        }
//                        ) {
//                            if stellarObject.hiddenLocations {
//                                ForEach($stellarObject.locations, id: \.id) { $location in
//                                    NavigationLink(destination: LocationView(location: $location, campaign: self.campaign)) {
//                                        Text(location.name)
//                                    }
//                                }.onDelete { (indexSet) in
//                                    stellarObject.locations.remove(atOffsets: indexSet)
//                                }
//                            }
//                        }
//                    }
                    
                    //CREATURE
                    if stellarObject.creatures != [] {
                        Section(header:
                                    HStack {
                            Text("Creatures").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenCreatures.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenCreatures ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenCreatures {
                                ForEach($stellarObject.creatures, id: \.id) { $creature in
                                    NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                        Text(creature.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.creatures.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //VEHICLE
                    if stellarObject.vehicles != [] {
                        Section(header:
                                    HStack {
                            Text("Starships").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenVehicles.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenVehicles ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenVehicles {
                                ForEach($stellarObject.vehicles, id: \.id) { $vehicle in
                                    NavigationLink(destination: StarshipView(starship: $vehicle, campaign: Campaign())) {
                                        Text(vehicle.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.vehicles.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //DESCRIPTION
                    if stellarObject.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenDescription {
                                TextEditor(text: $stellarObject.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                    // CLOCK
                    if stellarObject.clocks != [] {
                        Section(header:
                                    HStack {
                            Text("Clocks").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenClock.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenClock ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenClock {
                                ForEach($stellarObject.clocks, id: \.id) { $clock in
                                    NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                        Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                   }
                               }.onDelete { (indexSet) in
                                   stellarObject.clocks.remove(atOffsets: indexSet)
                               }

                            }
                        }
                    }
                }.listStyle(.inset)
                
            }
            //.navigationTitle(stellarObject.name)
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
                            if stellarObject.waitingForStarship {
                                Button {
                                    stellarObject.vehicles.insert(buffer.starshipBuffer[0], at: 0)
                                    stellarObject.vehicles[0].homeSector = stellarObject.homeSector
                                    buffer.starshipBuffer = []
                                    stellarObject.waitingForStarship = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the starship")
                                }
                            }
                            if stellarObject.waitingForFaction {
                                Button {
                                    stellarObject.factions.insert(buffer.factionBuffer[0], at: 0)
                                    buffer.factionBuffer = []
                                    stellarObject.waitingForFaction = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the faction")
                                }
                            }
                            if stellarObject.waitingForCreature {
                                Button {
                                    stellarObject.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                    stellarObject.creatures[0].homeSector = stellarObject.homeSector
                                    buffer.creatureBuffer = []
                                    stellarObject.waitingForCreature = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the creature")
                                }
                            }
                            if stellarObject.waitingForSettlement {
                                Button {
                                    stellarObject.settlements.insert(buffer.settlementBuffer[0], at: 0)
                                    stellarObject.settlements[0].homeSector = stellarObject.homeSector
                                    buffer.settlementBuffer = []
                                    stellarObject.waitingForSettlement = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the settlement")
                                }
                            }
                            Menu {
                                if stellarObject.mode != "Input" {
                                    Button {
                                        stellarObject.mode = "Input"
                                    } label: {
                                        Text("Input")
                                    }
                                }
                                if stellarObject.mode != "Selection" {
                                    Button {
                                        stellarObject.mode = "Selection"
                                    } label: {
                                        Text("Selection")
                                    }
                                }
                                if stellarObject.mode != "Generation" {
                                    Button {
                                        stellarObject.mode = "Generation"
                                    } label: {
                                        Text("Generation")
                                    }
                                }
                            } label: {
                                Text("Mode")
                            }

                        }
                        Button {
                            stellarObject.vaults.insert(PrecursorVaults(name: "Unknown Vault"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Precursor Vault")
                        }
                        
                        if stellarObject.description == "" {
                            Button {
                                stellarObject.description = " "
                                campaign.writeToFile()
                            } label: {
                                Text("Description")
                            }
                        }
                        Button {
                            stellarObject.factions.insert(Faction(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Faction")
                        }
                        Button {
                            stellarObject.planets.insert(Planet(homeSector: stellarObject.homeSector, homeStar: stellarObject.name, name: stellarObject.randomPlanetName()), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Planet")
                        }
                        
                        Button {
                            stellarObject.settlements.insert(Settlement(homeSector: stellarObject.homeSector), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Settlement")
                        }
                        Button {
                            stellarObject.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                            stellarObject.hiddenClock = true
                            campaign.writeToFile()
                        } label: {
                            Text("Add Clock")
                        }
                        Button {
                            stellarObject.creatures.insert(Creature(homeSector: stellarObject.homeSector, name: "Unknown Creature"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Creature")
                        }
                        
                        Button {
                            stellarObject.vehicles.insert(Starship(name: "Unknown Starship", homeSector: stellarObject.homeSector), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Starship")
                        }
                        
                        Button {
                            stellarObject.routes.insert(Route(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("Add Route")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            if buffer.starshipBuffer != [] {
                stellarObject.waitingForStarship = true
            } else {
                stellarObject.waitingForStarship = false
            }
            if buffer.settlementBuffer != [] {
                stellarObject.waitingForSettlement = true
            } else {
                stellarObject.waitingForSettlement = false
            }
            if buffer.creatureBuffer != [] {
                stellarObject.waitingForCreature = true
            } else {
                stellarObject.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                stellarObject.waitingForFaction = true
            } else {
                stellarObject.waitingForFaction = false
            }
            
            for _ in stellarObject.factions {
                if let index = stellarObject.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    stellarObject.factions.remove(at: index)
                }
            }
            for _ in stellarObject.creatures {
                if let index = stellarObject.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    stellarObject.creatures.remove(at: index)
                }
            }
            for _ in stellarObject.vehicles {
                if let index = stellarObject.vehicles.firstIndex(where: { $0.name == "toDelate" }) {
                    stellarObject.vehicles.remove(at: index)
                }
            }
            for _ in stellarObject.settlements {
                if let index = stellarObject.settlements.firstIndex(where: { $0.name == "toDelate" }) {
                    stellarObject.settlements.remove(at: index)
                }
            }
        }
    }
}

struct StellarObjectView_Previews: PreviewProvider {
    static var previews: some View {
        StellarObjectView(stellarObject: .constant(StellarObject()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
