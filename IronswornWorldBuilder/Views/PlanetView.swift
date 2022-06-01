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
                                    Button {
                                        planet.hiddenSettlements.toggle()
                                    } label: {
                                        Image(systemName: planet.hiddenSettlements ? "chevron.down" : "chevron.right")
                                    }
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
                                    planet.hiddenAtmosphere.toggle()
                                } label: {
                                    Image(systemName: planet.hiddenAtmosphere ? "chevron.down" : "chevron.right")
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
                                            Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
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
                    }
                }.listStyle(.inset)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        Toggle(isOn: $planet.travelMode) {
                            Text("Travel Mode")
                        }
                        if planet.type == "Unknown World" {
                            Button {
                                campaign.writeToFile()
                                randomPlanet()
                            } label: {
                                Text("Generate Planet")
                            }
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
                                        campaign.writeToFile()
                                        planet.atmosphere = "Unknown"
                                    } label: {
                                        Text("Atmosphere")
                                    }
                                }
                                
                                if planet.viewFromSpace.count < 2 {
                                    Button {
                                        campaign.writeToFile()
                                        planet.viewFromSpace.insert(StringContainer(), at: 0)
                                    } label: {
                                        Text("New View From Space")
                                    }
                                }
                                
                                if planet.features.count < 2 {
                                    Button {
                                        campaign.writeToFile()
                                        planet.features.insert(StringContainer(), at: 0)
                                    } label: {
                                        Text("New Feature")
                                    }
                                }
                                Button {
                                    campaign.writeToFile()
                                    planet.vaults.insert(PrecursorVaults(name: "Unknown Vault"), at: 0)
                                } label: {
                                    Text("Add Precursor Vault")
                                }
                                Button {
                                    campaign.writeToFile()
                                    planet.settlements.insert(Settlement(homeSector: planet.homeSector), at: 0)
                                } label: {
                                    Text("New Settlement")
                                }
                                
                                if planet.life == "" {
                                    Button {
                                        campaign.writeToFile()
                                        planet.life = "Unknown"
                                    } label: {
                                        Text("Life")
                                    }
                                }
                                Button {
                                    campaign.writeToFile()
                                    planet.factions.append(Faction())
                                } label: {
                                    Text("Add Faction")
                                }
                                if planet.type == "Vital World" && planet.biomes == [] {
                                    Button {
                                        campaign.writeToFile()
                                        for _ in 1...randomDivercity() {
                                            planet.biomes.insert(StringContainer(name: planet.randomBiome()), at: 0)
                                        }
                                        
                                    } label: {
                                        Text("New Biome")
                                    }
                                }
    //
                                
                            }
                            Group {
                                if planet.homeStar == "Wandering" {
                                    Button {
                                        campaign.writeToFile()
                                        planet.routes.insert(Route(), at: 0)
                                    } label: {
                                        Text("New Route")
                                    }
                                }
                                
                                if planet.subName == "" {
                                    Button {
                                        campaign.writeToFile()
                                        planet.subName = "Any Subtitle"
                                    } label: {
                                        Text("Subtitle")
                                    }
                                }
                                
                                if planet.description == "" {
                                    Button {
                                        campaign.writeToFile()
                                        planet.description = "New Description"
                                    } label: {
                                        Text("Description")
                                    }
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
        planet.type = planet.randomPlanetType()
        
        planet.viewFromSpace = []
        let howManyViewsFromSpace = Int.random(in: 0...3)
        if howManyViewsFromSpace > 0 {
            planet.viewFromSpace.insert(StringContainer(), at: 0)
            planet.viewFromSpace[0].name = planet.randomViewFromSpace(type: planet.type)
        } else {
            planet.viewFromSpace.insert(StringContainer(), at: 0)
            planet.viewFromSpace[0].name = planet.randomViewFromSpace(type: planet.type)
            planet.viewFromSpace.insert(StringContainer(), at: 0)
            planet.viewFromSpace[0].name = planet.randomViewFromSpace(type: planet.type)
        }
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
        
        planet.settlements.insert(Settlement(homeSector: planet.homeSector), at: 0)
        planet.settlements[0].name = planet.randomSettlement(homeRegion: getHomeRegion(homeSector: planet.homeSector), planetType: planet.type)
        planet.atmosphere = planet.randomPlanetAtmosphere(type: planet.type)
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
