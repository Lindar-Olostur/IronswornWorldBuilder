//
//  LocationView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 19.05.2022.
//

import SwiftUI

struct LocationView: View {
    @Binding var location: Location
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                TextField("Enter location name", text: $location.name).font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .focused($fieldIsFocused)
                if location.subName != "" {
                    TextField("Another location info", text: $location.subName)
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
            }
            
            //TRAVEL BUTTONS
            if location.travelMode {
                VStack {
//                    VStack {
////                        if location.mode == "Generation" {
////                            HStack {
////                                Spacer()
////                                Text("Zone: \(derelict.currentZone)")
////                                    .font(.system(size: 30))
////                                    .focused($fieldIsFocused)
////                                Spacer()
////                                Button {
////                                    derelict.currentZone = derelict.randomZone(type: derelict.type)
////                                    derelict.currentArea = randomArea(zone: derelict.currentZone)
////                                } label: {
////                                    Image(systemName: "dice").font(.system(size: 20))
////                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
////
////                            }.padding(.horizontal)
////                        }
////                        if location.mode == "Selection" {
////                            Menu {
////                                Picker(selection: $derelict.currentZone) {
////                                    ForEach(derelict.currentZoneList, id: \.self) { value in
////                                        Text(value)
////                                            .tag(value)
////
////                                    }
////                                } label: {}
////                            } label: {
////                                Text("Zone: \(derelict.currentZone)")
////                                    .font(.system(size: 30))
////                            }
////                        }
//                    }
//                    .padding(.vertical, 7)
//                    VStack {
//                        if location.mode == "Generation" {
//                            HStack {
//                                Spacer()
//                                Text("Area: \(derelict.currentArea)")
//                                    .font(.system(size: 20))
//                                    .focused($fieldIsFocused)
//                                Spacer()
//                                Button {
//                                    derelict.currentArea = randomArea(zone: derelict.currentZone)
//                                } label: {
//                                    Image(systemName: "dice").font(.system(size: 20))
//                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
//
//                            }.padding(.horizontal)
//                        }
//                        if derelict.mode == "Selection" {
//                            Menu {
//                                Picker(selection: $derelict.currentArea) {
//                                    ForEach(derelict.areaList, id: \.self) { value in
//                                        Text(value)
//                                            .tag(value)
//
//                                    }
//                                } label: {}
//                            } label: {
//                                Text("Zone: \(derelict.currentArea)")
//                                    .font(.system(size: 20))
//                            }
//                        }
//                    }
//                    .padding(.bottom, 17)
                    HStack(spacing: 55) {
                        Button {
                            displayText = "Feature: \(randomFeature())"
                        } label: {
                            Text("Location Feature")
                                .foregroundColor(.black)
                                .frame(width: 100)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        
                        Button {
                            displayText = "Opportunity: \(randomOpportunity())"
                        } label: {
                            Text("Location Opportunity")
                                .frame(width: 100)
                        }
                        .buttonStyle(BorderedButtonStyle())
                    }
                    HStack(spacing: 55) {
                        Button {
                            displayText = "Danger: \(randomDanger())"
                        } label: {
                            Text("Location Danger")
                                .frame(width: 100)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        Button {
                            displayText = "Trap: \(randomTrap())"
                        } label: {
                            Text("Location Trap")
                                .frame(width: 100)
                                .foregroundColor(.orange)
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
            
            List{
                //DOMAINS
                if location.domains != [] {
                    Section(header:
                                HStack {
                        Text("Domains").font(.title)
                        Spacer()
                        Button {
                            location.hiddenDomains.toggle()
                        } label: {
                            Image(systemName: location.hiddenDomains ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenDomains {
                            if location.mode == "Generation" {
                                ForEach($location.domains) { $domain in
                                    HStack {
                                        Text(domain.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            domain.name = location.oracle.randomDelveDomain()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    location.domains.remove(atOffsets: indexSet)
                                }
                            }
                            if location.mode == "Selection" || location.mode == "Input" {
                                ForEach($location.domains) { $domain in
                                    Picker(selection: $domain.name, label: EmptyView()) {
                                        ForEach(location.oracle.domainDelveList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    location.domains.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                
                //THEMES
                if location.themes != [] {
                    Section(header:
                                HStack {
                        Text("Themes").font(.title)
                        Spacer()
                        Button {
                            location.hiddenThemes.toggle()
                        } label: {
                            Image(systemName: location.hiddenThemes ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenThemes {
                            if location.mode == "Generation" {
                                ForEach($location.themes) { $theme in
                                    HStack {
                                        Text(theme.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            theme.name = location.oracle.randomDelveTheme()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    location.themes.remove(atOffsets: indexSet)
                                }
                            }
                            if location.mode == "Selection" || location.mode == "Input" {
                                ForEach($location.themes) { $theme in
                                    Picker(selection: $theme.name, label: EmptyView()) {
                                        ForEach(location.oracle.themeDelveList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    location.themes.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                
                // RANK
                 Section(header:
                             HStack {
                             Text("Rank").font(.title)
                     Spacer()
                     Button {
                         location.hiddenRank.toggle()
                     } label: {
                         Image(systemName: location.hiddenRank ? "chevron.down" : "chevron.right")
                     }
                 }
                 ) {
                     if location.hiddenRank {
                         if location.mode == "Generation" {
                             HStack {
                                 Text(location.rank).focused($fieldIsFocused)
                                 Spacer()
                                 Button {
                                     location.rank = Rank.allCases.randomElement()!.rawValue.capitalized
                                 } label: {
                                     Image(systemName: "dice").font(.system(size: 20))
                                 }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                             }
                         }
                         if location.mode == "Selection" || location.mode == "Input" {
                             Picker(selection: $location.rank, label: EmptyView()) {
                                 ForEach(Rank.allCases, id: \.self) { value in
                                     Text(value.rawValue.capitalized).font(.system(size: 50))
                                         .tag(value)
                                 }
                             }.pickerStyle(.menu)
                         }
                     }
                 }
                
                //PERSONS
                if location.persons != [] {
                    Section(header:
                                HStack {
                        Text("Persons").font(.title)
                        Spacer()
                        Button {
                            location.hiddenPersons.toggle()
                        } label: {
                            Image(systemName: location.hiddenPersons ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenPersons {
                            ForEach($location.persons, id: \.id) { $person in
                                NavigationLink(destination: PersonView(person: $person, campaign: self.campaign)) {
                                    Text(person.name)
                                    //Text(campaign.world.sectorIsLand ? "\(person.name) the \(person.role.lowercased())" : person.name)
                                }
                            }.onDelete { (indexSet) in
                                location.persons.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                
                //CREATURES
                if location.creatures != [] {
                    Section(header:
                                HStack {
                        Text("Creatures").font(.title)
                        Spacer()
                        Button {
                            location.hiddenCreature.toggle()
                        } label: {
                            Image(systemName: location.hiddenCreature ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenCreature {
                            ForEach($location.creatures, id: \.id) { $creature in
                                NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                    Text(creature.name)
                                }
                            }.onDelete { (indexSet) in
                                location.creatures.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                
                //FACTIONS
                if location.factions != [] {
                    Section(header:
                                HStack {
                        Text("Factions").font(.title)
                        Spacer()
                        Button {
                            location.hiddenFactions.toggle()
                        } label: {
                            Image(systemName: location.hiddenFactions ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenFactions {
                            ForEach($location.factions, id: \.id) { $faction in
                               NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                   Text(faction.name)
                               }
                           }.onDelete { (indexSet) in
                               location.factions.remove(atOffsets: indexSet)
                           }
                        }
                    }
                }
                
                //WAYPOINTS
                if location.waypoints != [] {
                    Section(header:
                                HStack {
                        Text("Waypoints").font(.title)
                        Spacer()
                        Button {
                            location.hiddenWaypoints.toggle()
                        } label: {
                            Image(systemName: location.hiddenWaypoints ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenWaypoints {
                            ForEach($location.waypoints, id: \.id) { $point in
                                NavigationLink(destination: LocationView(location: $point, campaign: Campaign())) {
                                    Text(point.name)
                                }
                            }.onDelete { (indexSet) in
                                location.waypoints.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                
                //ROUTES
                if location.routes != [] {
                    Section(header:
                                HStack {
                        Text("Routes").font(.title)
                        Spacer()
                        Button {
                            location.hiddenRoutes.toggle()
                        } label: {
                            Image(systemName: location.hiddenRoutes ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenRoutes {
                            ForEach($location.routes, id: \.id) { $route in
                                NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                    Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
                                }
                            }.onDelete { (indexSet) in
                                location.routes.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                
                //DESCRIPTION
                if location.description != "" {
                    Section(header:
                                HStack {
                        Text("Description").font(.title)
                        Spacer()
                        Button {
                            location.hiddenDescription.toggle()
                        } label: {
                            Image(systemName: location.hiddenDescription ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if location.hiddenDescription {
                            TextEditor(text: $location.description)
                                .focused($fieldIsFocused)
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
                    Toggle(isOn: $location.travelMode) {
                        Text("Travel Mode")
                    }
                    Group {
                        if location.waitingForPerson {
                            Button {
                                location.persons.insert(buffer.personBuffer[0], at: 0)
                                //settlement.persons[0].homeSector = settlement.homeSector
                                buffer.personBuffer = []
                                location.waitingForPerson = false
                                campaign.writeToFile()
                            } label: {
                                Text("Insert a person")
                            }
                        }
                        if location.waitingForFaction {
                            Button {
                                location.factions.insert(buffer.factionBuffer[0], at: 0)
                                buffer.factionBuffer = []
                                location.waitingForFaction = false
                                campaign.writeToFile()
                            } label: {
                                Text("Insert the faction")
                            }
                        }
                        if location.waitingForCreature {
                            Button {
                                location.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                //location.creatures[0].homeSector = location.homeSector
                                buffer.creatureBuffer = []
                                location.waitingForCreature = false
                                campaign.writeToFile()
                            } label: {
                                Text("Insert the creature")
                            }
                        }
                    }
                    Menu {
                        if location.mode != "Selection" {
                            Button {
                                location.mode = "Selection"
                            } label: {
                                Text("Selection")
                            }
                        }
                        if location.mode != "Generation" {
                            Button {
                                location.mode = "Generation"
                            } label: {
                                Text("Generation")
                            }
                        }
                    } label: {
                        Text("Mode")
                    }
                    Button {
                        generateLocation()
                        campaign.writeToFile()
                    } label: {
                        Text("Generate Location")
                    }
                    Menu {
                        
                        Button {
                            location.waypoints.insert(Location(name: "New Zone", rank: location.rank, domains: location.domains, themes: location.themes, mode: location.mode, travelMode: location.travelMode), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Waypoint")
                        }
                        Button {
                            location.themes.insert(StringContainer(name: "\(location.oracle.randomDelveTheme())"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Theme")
                        }
                        Button {
                            location.domains.insert(StringContainer(name: "\(location.oracle.randomDelveDomain())"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Domain")
                        }
                        Button {
                            location.routes.insert(Route(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Route")
                        }
                        Button {
                            location.factions.insert(Faction(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Faction")
                        }
                        Button {
                            location.persons.insert(Person(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Person")
                        }
                        Button {
                            location.creatures.insert(Creature(name: "Unknown creature"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Creature")
                        }
                        if location.description == "" {
                            Button {
                                location.description = "New Description"
                                campaign.writeToFile()
                            } label: {
                                Text("Description")
                            }
                        }
                        if location.subName == "" {
                            Button {
                                location.subName = "Any Subtitle"
                                campaign.writeToFile()
                            } label: {
                                Text("Subtitle")
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
        .onAppear {

            if buffer.personBuffer != [] {
                location.waitingForPerson = true
            } else {
                location.waitingForPerson = false
            }
            if buffer.creatureBuffer != [] {
                location.waitingForCreature = true
            } else {
                location.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                location.waitingForFaction = true
            } else {
                location.waitingForFaction = false
            }
            
            for _ in location.factions {
                if let index = location.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    location.factions.remove(at: index)
                }
            }
            for _ in location.creatures {
                if let index = location.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    location.creatures.remove(at: index)
                }
            }
            for _ in location.persons {
                if let index = location.persons.firstIndex(where: { $0.name == "toDelate" }) {
                    location.persons.remove(at: index)
                }
            }
        }
    }
    func randomFeature() -> String {
        
        var pool: [String] = []
        
        if location.domains != [] {
            for domain in location.domains {
                if domain.name == "Barrow" {
                    for (feature, ratio) in location.oracle.barrowDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Cavern" {
                    for (feature, ratio) in location.oracle.cavernDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Frozen Cavern" {
                    for (feature, ratio) in location.oracle.frozenCavernDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Icereach" {
                    for (feature, ratio) in location.oracle.icereachDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Mine" {
                    for (feature, ratio) in location.oracle.mineDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Pass" {
                    for (feature, ratio) in location.oracle.passDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Ruin" {
                    for (feature, ratio) in location.oracle.ruinDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Sea Cave" {
                    for (feature, ratio) in location.oracle.seaCaveDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Shadowfen" {
                    for (feature, ratio) in location.oracle.shadowfenDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Stronghold" {
                    for (feature, ratio) in location.oracle.strongholdDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Tanglewood" {
                    for (feature, ratio) in location.oracle.tanglewoodDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Underkeep" {
                    for (feature, ratio) in location.oracle.underkeepDomainFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
            }
        } else {
            pool.append("No feature in domains")
        }
        
        if location.themes != [] {
            for domain in location.themes {
                if domain.name == "Ancient" {
                    for (feature, ratio) in location.oracle.ancientThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Corrupted" {
                    for (feature, ratio) in location.oracle.corruptedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Fortified" {
                    for (feature, ratio) in location.oracle.fortifiedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Hallowed" {
                    for (feature, ratio) in location.oracle.hallowedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Haunted" {
                    for (feature, ratio) in location.oracle.hauntedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Infested" {
                    for (feature, ratio) in location.oracle.infestedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Ravaged" {
                    for (feature, ratio) in location.oracle.ravagedThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Wild" {
                    for (feature, ratio) in location.oracle.wildThemeFeatureDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
            }
        } else {
            pool.append("No feature in themes")
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomDanger() -> String {
        
        var pool: [String] = []
        
        if location.domains != [] {
            for domain in location.domains {
                if domain.name == "Barrow" {
                    for (feature, ratio) in location.oracle.barrowDomainDangerDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Cavern" {
                    for (feature, ratio) in location.oracle.cavernDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Frozen Cavern" {
                    for (feature, ratio) in location.oracle.frozenCavernDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Icereach" {
                    for (feature, ratio) in location.oracle.icereachDomainDangerDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Mine" {
                    for (feature, ratio) in location.oracle.mineDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Pass" {
                    for (feature, ratio) in location.oracle.passDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Ruin" {
                    for (feature, ratio) in location.oracle.ruinDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Sea Cave" {
                    for (feature, ratio) in location.oracle.seaCaveDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Shadowfen" {
                    for (feature, ratio) in location.oracle.shadowfenDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Stronghold" {
                    for (feature, ratio) in location.oracle.strongholdDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Tanglewood" {
                    for (feature, ratio) in location.oracle.tanglewoodDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Underkeep" {
                    for (feature, ratio) in location.oracle.underkeepDomainDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
            }
        } else {
            pool.append("No danger in domains")
        }
        
        if location.themes != [] {
            for domain in location.themes {
                if domain.name == "Ancient" {
                    for (feature, ratio) in location.oracle.ancientThemeDangerDelve {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Corrupted" {
                    for (feature, ratio) in location.oracle.corruptedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Fortified" {
                    for (feature, ratio) in location.oracle.fortifiedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Hallowed" {
                    for (feature, ratio) in location.oracle.hallowedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Haunted" {
                    for (feature, ratio) in location.oracle.hauntedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Infested" {
                    for (feature, ratio) in location.oracle.infestedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Ravaged" {
                    for (feature, ratio) in location.oracle.ravagedThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
                if domain.name == "Wild" {
                    for (feature, ratio) in location.oracle.wildThemeDangerDelve  {
                        pool.append(contentsOf: repeatElement(feature, count: ratio))
                    }
                }
            }
        } else {
            pool.append("No danger in themes")
        }
        
        for (feature, ratio) in location.oracle.revealDangerMoveDelve  {
            pool.append(contentsOf: repeatElement(feature, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomOpportunity() -> String {
        
        var pool: [String] = []
        
        for (value, ratio) in location.oracle.findOpportunityMoveDelve {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomTrap() -> String {
        
        func getEvent() -> String {
            let event = ["Block", "Create", "Break", "Puncture", "Entangle", "Enclose", "Ambush", "Snare", "Change", "Imitate", "Crush", "Drop", "Conceal", "Lure", "Release", "Obscure", "Cut", "Smother", "Collapse", "Summon", "Move", "Surprice", "Divert", "Attack", "Trigger"]
            var randomEvent = event.shuffled()
            return randomEvent.popLast() ?? "Error"
        }
        func getComponent() -> String {
            let componentList = ["Pit", "Water", "Fire", "Projectile", "Passage", "Fall", "Debris", "Fear", "Alarm", "Trigger", "Cold", "Weapon", "Darkness", "Decay", "Path", "Stone", "Terrain", "Poison", "Barrier", "Overhead", "Magic", "Toxin", "Earth", "Light", "Denizen"]
            var randomComponent = componentList.shuffled()
            return randomComponent.popLast() ?? "Error"
        }
        
        return "\(getComponent()) + \(getEvent())"
    }
    func generateLocation() {
        location.domains = []
        location.themes = []
        location.domains.insert(StringContainer(name: location.oracle.randomDelveDomain()), at: 0)
        location.themes.insert(StringContainer(name: location.oracle.randomDelveTheme()), at: 0)
        location.name = location.locationName(domains: [location.domains[0].name])
        location.subName = "\(location.themes[0].name) \(location.domains[0].name)"
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: .constant(Location(name: "Location X")), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
