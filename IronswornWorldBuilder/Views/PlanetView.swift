//
//  PlanetView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct PlanetView: View {
    @Binding var planet: Planet
    @ObservedObject var campaign: Campaign
    @State private var generatorIsOn = false
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    var buffer = movingBuffer.shared
    
    //MARK: вынести его из меню на экран---меню выбор всего---имена
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                //TITLES
                VStack {
                    
                    HStack {
                        TextField("Enter planet name", text: $planet.name).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if planet.type != "Unknown World" && planet.mode == "Generation" {
                            Spacer()
                            Button {
                                planet.subName = planet.randomName(type: planet.type)
                            } label: {
                                Image(systemName: "dice").font(.system(size: 20))
                            }
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            .padding(.trailing, 30)
                        }
                    }
                    
                    
                    if planet.subName != "" {
                        TextField("Another planet info", text: $planet.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                }
                
                //TRAVEL MODE
                if planet.travelMode {
                    VStack {
                        HStack(spacing: 100) {
                            Button {
                                displayText = planet.randomPeril()
                            } label: {
                                Text("Planetside\n Peril")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                displayText = planet.randomOpportunity()
                            } label: {
                                Text("Planetside\n Opportunity")
                            }
                            .buttonStyle(BorderedButtonStyle())
                        }
                        ZStack(alignment: .center) {
                            Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6))
                                .frame(maxWidth: .infinity)

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
                    Group {
                        //TYPE
                        Section(header:
                                    HStack {
                            Text("Type").font(.title)
                            Spacer()
                            Button {
                                planet.hiddenType.toggle()
                            } label: {
                                Image(systemName: planet.hiddenType ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if planet.hiddenType {
                                if planet.mode == "Input" {
                                    TextField("Enter planet class", text: $planet.type).focused($fieldIsFocused)
                                }
                                if planet.mode == "Generation" {
                                    HStack {
                                        TextField("Enter planet class", text: $planet.type).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            planet.type = planet.randomPlanetType()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if planet.mode == "Selection" {
                                    Picker(selection: $planet.type, label: EmptyView()) {
                                        ForEach(planet.typeList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                        
                        //VIEW FROM SPACE
                        if planet.viewFromSpace != [] {
                            Section(header:
                                        HStack {
                                Text("View from space").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenViewFromSpace.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenViewFromSpace ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenViewFromSpace {
                                    if planet.mode == "Input" {
                                        ForEach($planet.viewFromSpace) { $viewFromSpace in
                                            TextField("Enter view from space", text: $viewFromSpace.name).focused($fieldIsFocused)
                                        }.onDelete { (indexSet) in
                                            planet.viewFromSpace.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Generation" {
                                        ForEach($planet.viewFromSpace) { $viewFromSpace in
                                            HStack {
                                                TextField("Enter view from space", text: $viewFromSpace.name).focused($fieldIsFocused)
                                                Spacer()
                                                Button {
                                                    viewFromSpace.name = planet.randomViewFromSpace(type: planet.type)
                                                } label: {
                                                    Image(systemName: "dice").font(.system(size: 20))
                                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                            }
                                        }.onDelete { (indexSet) in
                                            planet.viewFromSpace.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Selection" {
                                        ForEach($planet.viewFromSpace) { $viewFromSpace in
                                            Picker(selection: $viewFromSpace.name, label: EmptyView()) {
                                                ForEach(planet.viewFromSpaceList(type: planet.type), id: \.self) { value in
                                                    Text(value).font(.system(size: 50))
                                                        .tag(value)
                                                }
                                            }.pickerStyle(.menu)
                                        }.onDelete { (indexSet) in
                                            planet.viewFromSpace.remove(atOffsets: indexSet)
                                        }
                                    }
                                }
                            }
                        }
                                            
                        //FEATURES
                        if planet.features != [] {
                            Section(header:
                                        HStack {
                                Text("Planetside Features").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenFeatures.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenFeatures ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenFeatures {
                                    if planet.mode == "Input" {
                                        ForEach($planet.features) { $feature in
                                            TextField("Enter feature", text: $feature.name).focused($fieldIsFocused)
                                        }.onDelete { (indexSet) in
                                            planet.features.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Generation" {
                                        ForEach($planet.features) { $feature in
                                            HStack {
                                                TextField("Enter feature", text: $feature.name).focused($fieldIsFocused)
                                                Spacer()
                                                Button {
                                                    feature.name = planet.randomFeature(type: planet.type)
                                                } label: {
                                                    Image(systemName: "dice").font(.system(size: 20))
                                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                            }
                                        }.onDelete { (indexSet) in
                                            planet.features.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Selection" {
                                        ForEach($planet.features) { $feature in
                                            Picker(selection: $feature.name, label: EmptyView()) {
                                                ForEach(planet.featureList(type: planet.type), id: \.self) { value in
                                                    Text(value).font(.system(size: 50))
                                                        .tag(value)
                                                }
                                            }.pickerStyle(.menu)
                                        }.onDelete { (indexSet) in
                                            planet.features.remove(atOffsets: indexSet)
                                        }
                                    }
                                }
                            }
                        }
                        
                        //PRECURSOR VAULT
                        if planet.vaults != [] {
                            Section(header:
                                        HStack {
                                Text("Precursor Vaults").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenVault.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenVault ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenVault {
                                    ForEach($planet.vaults, id: \.id) { $vault in
                                        NavigationLink(destination: PrecursorVaultsView(vault: $vault, campaign: self.campaign)) {
                                            Text(vault.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        planet.vaults.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                        //SETTLEMENTS
                        if planet.settlements != [] {
                            Section(header:
                                        HStack {
                                Text("Settlements").font(.title)
                                if planet.mode == "Generation" {
                                    Spacer()
                                    Button {
                                        planet.settlements[0].name = planet.randomSettlement(homeRegion: getHomeRegion(homeSector: planet.homeSector), planetType: planet.type)
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                                Spacer()
                                Button {
                                    planet.hiddenSettlements.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenSettlements ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenSettlements {
                                    ForEach($planet.settlements, id: \.id) { $settlement in
                                    NavigationLink(destination: SettlementView(settlement: $settlement, campaign: self.campaign)) {
                                        Text(settlement.name)
                                    }
                                }.onDelete { (indexSet) in
                                    planet.settlements.remove(atOffsets: indexSet)
                                }
                                }
                            }
                        }
                        
                        //ATMOSPHERE
                        if planet.atmosphere != "" {
                            Section(header:
                                        HStack {
                                        Text("Atmosphere").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenAtmosphere.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenAtmosphere ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenAtmosphere {
                                    if planet.mode == "Input" {
                                        TextField("Enter atmosphere type", text: $planet.atmosphere).focused($fieldIsFocused)
                                    }
                                    if planet.mode == "Generation" {
                                        HStack {
                                            TextField("Enter atmosphere type", text: $planet.atmosphere).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                planet.atmosphere = planet.randomPlanetAtmosphere(type: planet.type)
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if planet.mode == "Selection" {
                                        Picker(selection: $planet.atmosphere, label: EmptyView()) {
                                            ForEach(planet.atmosphereList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }

                        //FACTIONS
                        if planet.factions != [] {
                            Section(header:
                                        HStack {
                                Text("Factions").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenFactions.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenFactions ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenFactions {
                                    ForEach($planet.factions, id: \.id) { $faction in
                                       NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                           Text(faction.name)
                                       }
                                   }.onDelete { (indexSet) in
                                       planet.factions.remove(atOffsets: indexSet)
                                   }
                                }
                            }
                        }
                        
                    }
                    Group {
                        
                        //LIFE
                        if planet.life != "" {
                            Section(header:
                                        HStack {
                                Text("Life").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenLife.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenLife ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenLife {
                                    if planet.mode == "Input" {
                                        TextField("Enter life", text: $planet.life).focused($fieldIsFocused)
                                    }
                                    if planet.mode == "Generation" {
                                        HStack {
                                            TextField("Enter life", text: $planet.life).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                planet.life = planet.randomLife(type: planet.type)
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if planet.mode == "Selection" {
                                        Picker(selection: $planet.life, label: EmptyView()) {
                                            ForEach(planet.lifeList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        
                        //BIOMES
                        if planet.biomes != [] {
                            Section(header:
                                        HStack {
                                Text("Biomes").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenBiomes.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenBiomes ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenBiomes {
                                    if planet.mode == "Input" {
                                        ForEach($planet.biomes) { $biome in
                                            TextField("Enter biome", text: $biome.name).focused($fieldIsFocused)
                                        }.onDelete { (indexSet) in
                                            planet.biomes.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Generation" {
                                        ForEach($planet.biomes) { $biome in
                                            HStack {
                                                TextField("Enter biome", text: $biome.name).focused($fieldIsFocused)
                                                Spacer()
                                                Button {
                                                    biome.name = planet.randomBiome()
                                                } label: {
                                                    Image(systemName: "dice").font(.system(size: 20))
                                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                            }
                                        }.onDelete { (indexSet) in
                                            planet.biomes.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if planet.mode == "Selection" {
                                        ForEach($planet.biomes) { $biome in
                                            Picker(selection: $biome.name, label: EmptyView()) {
                                                ForEach(planet.biomeList, id: \.self) { value in
                                                    Text(value).font(.system(size: 50))
                                                        .tag(value)
                                                }
                                            }.pickerStyle(.menu)
                                        }.onDelete { (indexSet) in
                                            planet.biomes.remove(atOffsets: indexSet)
                                        }
                                    }
                                }
                            }
                        }
                        
                        //VEHICLES
                        if planet.vehicles != [] {
                            Section(header:
                                        HStack {
                                Text("Starships").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenVehicles.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenVehicles ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenVehicles {
                                    ForEach($planet.vehicles, id: \.id) { $vehicle in
                                        NavigationLink(destination: StarshipView(starship: $vehicle, campaign: Campaign())) {
                                            Text(vehicle.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        planet.vehicles.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //CREATURES
                        if planet.creatures != [] {
                            Section(header:
                                        HStack {
                                Text("Creatures").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenCreature.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenCreature ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenCreature {
                                    ForEach($planet.creatures, id: \.id) { $creature in
                                        NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                            Text(creature.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        planet.creatures.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                        //LOCATIONS
                        if planet.locations != [] {
                            Section(header:
                                        HStack {
                                Text("Locations").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenLocations.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenLocations ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenLocations {
                                    ForEach($planet.locations, id: \.id) { $location in
                                        NavigationLink(destination: LocationView(location: $location, campaign: Campaign())) {
                                            Text(location.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        planet.locations.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                        //ROUTES
                        if planet.routes != [] {
                            Section(header:
                                        HStack {
                                Text("Routes").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenRoutes.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenRoutes ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenRoutes {
                                    ForEach($planet.routes, id: \.id) { $route in
                                        NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                            Text("\(NSLocalizedString(route.rank.rawValue.capitalized, comment: "")) route to \(route.destination)")
                                        }
                                    }.onDelete { (indexSet) in
                                        planet.routes.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                        //DESCRIPTION
                        if planet.description != "" {
                            Section(header:
                                        HStack {
                                Text("Description").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenDescription.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenDescription ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenDescription {
                                    TextEditor(text: $planet.description)
                                        .focused($fieldIsFocused)
                                }
                            }
                        }
                        // CLOCK
                        if planet.clocks != [] {
                            Section(header:
                                        HStack {
                                Text("Clocks").font(.title)
                                Spacer()
                                Button {
                                    planet.hiddenClock.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenClock ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if planet.hiddenClock {
                                    ForEach($planet.clocks, id: \.id) { $clock in
                                        NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                            Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                       }
                                   }.onDelete { (indexSet) in
                                       planet.clocks.remove(atOffsets: indexSet)
                                   }

                                }
                            }
                        }
                    }
                }.listStyle(.inset)
            }
            .navigationTitle(planet.name)
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
                            if planet.waitingForCreature {
                                Button {
                                    planet.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                    planet.creatures[0].homeSector = planet.homeSector
                                    buffer.creatureBuffer = []
                                    planet.waitingForCreature = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the creature")
                                }
                            }
                            if planet.waitingForFaction {
                                Button {
                                    planet.factions.insert(buffer.factionBuffer[0], at: 0)
                                    buffer.factionBuffer = []
                                    planet.waitingForFaction = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the faction")
                                }
                            }
                            if planet.waitingForStarship {
                                Button {
                                    planet.vehicles.insert(buffer.starshipBuffer[0], at: 0)
                                    planet.vehicles[0].homeSector = planet.homeSector
                                    buffer.starshipBuffer = []
                                    planet.waitingForStarship = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the starship")
                                }
                            }
                            if planet.waitingForSettlement {
                                Button {
                                    planet.settlements.insert(buffer.settlementBuffer[0], at: 0)
                                    planet.settlements[0].homeSector = planet.homeSector
                                    buffer.settlementBuffer = []
                                    planet.waitingForSettlement = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the settlement")
                                }
                            }
                        }
                        Toggle(isOn: $planet.travelMode) {
                            Text("Travel Mode")
                        }
                        Button {
                            randomPlanet()
                            campaign.writeToFile()
                        } label: {
                            Text("Generate Planet")
                        }
                        
                        Menu {
                            if planet.mode != "Input" {
                                Button {
                                    planet.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if planet.mode != "Selection" {
                                Button {
                                    planet.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if planet.mode != "Generation" {
                                Button {
                                    planet.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Text("Mode")
                        }
                        Menu {
                            Group {
                                if planet.atmosphere == "" {
                                    Button {
                                        planet.atmosphere = "Unknown"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Atmosphere")
                                    }
                                }
                                
                                if planet.viewFromSpace.count < 2 {
                                    Button {
                                        planet.viewFromSpace.insert(StringContainer(), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New View From Space")
                                    }
                                }
                                
                                if planet.features.count < 2 {
                                    Button {
                                        planet.features.insert(StringContainer(), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Feature")
                                    }
                                }
                                Button {
                                    planet.vaults.insert(PrecursorVaults(name: "Unknown Vault"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Precursor Vault")
                                }
                                Button {
                                    planet.settlements.insert(Settlement(homeSector: planet.homeSector), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Settlement")
                                }
                                
                                if planet.life == "" {
                                    Button {
                                        planet.life = "Unknown"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Life")
                                    }
                                }
                                Button {
                                    planet.factions.insert(Faction(), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Faction")
                                }
                                if planet.type == "Vital World" && planet.biomes == [] {
                                    Button {
                                        for _ in 1...randomDivercity() {
                                            planet.biomes.insert(StringContainer(name: planet.randomBiome()), at: 0)
                                        }
                                        campaign.writeToFile()
                                        
                                    } label: {
                                        Text("New Biome")
                                    }
                                }
    //
                                
                            }
                            Group {
                                if planet.homeStar == "Wandering" {
                                    Button {
                                        planet.routes.insert(Route(), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Route")
                                    }
                                }
                                Button {
                                    planet.locations.insert(Location(name: "New location"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Location")
                                }
                                Button {
                                    planet.vehicles.insert(Starship(name: Starship.randomName(mod: ""), homeSector: planet.homeSector), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Starship")
                                }
                                Button {
                                    planet.creatures.insert(Creature(homeSector: planet.homeSector, name: "Unknown"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Creature")
                                }
                                if planet.subName == "" {
                                    Button {
                                        planet.subName = "Any Subtitle"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Subtitle")
                                    }
                                }
                                
                                if planet.description == "" {
                                    Button {
                                        planet.description = "New Description"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Description")
                                    }
                                }
                                Button {
                                    planet.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                                    planet.hiddenClock = true
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Clock")
                                }
                            }
                        } label: {
                        Text("Add")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            if buffer.starshipBuffer != [] {
                planet.waitingForStarship = true
            } else {
                planet.waitingForStarship = false
            }
            if buffer.settlementBuffer != [] {
                planet.waitingForSettlement = true
            } else {
                planet.waitingForSettlement = false
            }
            if buffer.creatureBuffer != [] {
                planet.waitingForCreature = true
            } else {
                planet.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                planet.waitingForFaction = true
            } else {
                planet.waitingForFaction = false
            }
            
            for _ in planet.factions {
                if let index = planet.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    planet.factions.remove(at: index)
                }
            }
            for _ in planet.creatures {
                if let index = planet.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    planet.creatures.remove(at: index)
                }
            }
            for _ in planet.vehicles {
                if let index = planet.vehicles.firstIndex(where: { $0.name == "toDelate" }) {
                    planet.vehicles.remove(at: index)
                }
            }
            for _ in planet.settlements {
                if let index = planet.settlements.firstIndex(where: { $0.name == "toDelate" }) {
                    planet.settlements.remove(at: index)
                }
            }
        }
    }
    func getHomeRegion(homeSector: String) -> String {
        
        var match = ""
        
        guard campaign.world.regions != [] else {
            return "Wrong Home Region"
        }
        for region in campaign.world.regions {
            for sector in region.sectors {
                if sector.name == homeSector {
                    match = region.name
                }
            }
        }
        if match != "" {
            return match
        } else {
            return "Wrong Home Region"
        }
    }
    func randomDivercity() -> Int {
        func getDiversity() -> String {
            let dictionary = [
                "Simple" : 20,
                "Diverse" : 50,
                "Complex" : 20,
                "Garden world" : 10,
            ]
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        
        let devercity = getDiversity()
        
        switch devercity {
        case "Simple" :
            return 2
        case "Diverse" :
            return 3
        case "Complex" :
            return 4
        case "Garden world" :
            return 5
        default:
            return 1
        }
    }
    func randomPlanet() {
        planet.hiddenType = false
        planet.type = planet.randomPlanetType()
        planet.hiddenViewFromSpace = false
        planet.viewFromSpace = []
        let howManyViewsFromSpace = Int.random(in: 0...3)
        if howManyViewsFromSpace > 0 {
            planet.viewFromSpace.insert(StringContainer(name: planet.randomViewFromSpace(type: planet.type)), at: 0)
        } else {
            planet.viewFromSpace.insert(StringContainer(name: planet.randomViewFromSpace(type: planet.type)), at: 0)
            planet.viewFromSpace.insert(StringContainer(name: planet.randomViewFromSpace(type: planet.type)), at: 0)
        }
        planet.hiddenFeatures = false
        planet.features = []
        let howManyFeatures = Int.random(in: 0...3)
        if howManyFeatures > 0 {
            planet.features.insert(StringContainer(), at: 0)
            planet.features[0].name = planet.randomFeature(type: planet.type)
        } else {
            planet.features.insert(StringContainer(), at: 0)
            planet.features[0].name = planet.randomFeature(type: planet.type)
            planet.features.insert(StringContainer(), at: 0)
            planet.features[0].name = planet.randomFeature(type: planet.type)
        }
        planet.hiddenDescription = false
        planet.hiddenSettlements = false
        planet.settlements = []
        planet.settlements.insert(Settlement(homeSector: planet.homeSector), at: 0)
        planet.settlements[0].name = planet.randomSettlement(homeRegion: getHomeRegion(homeSector: planet.homeSector), planetType: planet.type)
        planet.hiddenAtmosphere = false
        planet.atmosphere = planet.randomPlanetAtmosphere(type: planet.type)
        planet.hiddenLife = false
        planet.life = planet.randomLife(type: planet.type)
        if planet.type == "Vital World" {
            for _ in 1...randomDivercity() {
                planet.biomes.insert(StringContainer(name: planet.randomBiome()), at: 0)
            }
        }
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView(planet: .constant(Planet()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
