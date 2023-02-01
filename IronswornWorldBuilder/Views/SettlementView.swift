//
//  SettlementView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct SettlementView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var settlement: Settlement
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var generatorIsOn = false
    @State private var displayText = ""
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                //TITLE
                VStack {
                    HStack {
                        TextField("Enter settlement name", text: $settlement.name).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if settlement.mode == "Generation" {
                            Spacer()
                            Button {
                                settlement.name = Settlement.randomName(isLand: campaign.world.sectorIsLand)
                            } label: {
                                Image(systemName: "dice").font(.system(size: 20))
                            }
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            .padding(.trailing, 30)
                        }
                    }
                    if settlement.subName != "" {
                        TextField("Another settlement info", text: $settlement.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                }
                
                //TRAVEL BUTTONS
                if settlement.travelMode {
                    VStack {
                        HStack(spacing: 15) {
                            Button {
                                //displayText = settlement.randomFeature()
                            } label: {
                                Text("Settlement\n Feature")
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                //displayText = settlement.randomPeril()
                            } label: {
                                Text("Settlement\n Peril")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                //displayText = settlement.randomOpportunity()
                            } label: {
                                Text("Settlement\n Opportunity")
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
                    Group {
                        if campaign.world.sectorIsLand == false {
                            //LOCATION TYPE
                            Section(header:
                                        HStack {
                                Text("Location Type").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenLocType.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenLocType ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenLocType {
                                    if settlement.mode == "Input" {
                                        TextField("Enter location type", text: $settlement.locationType).focused($fieldIsFocused)
                                    }
                                    if settlement.mode == "Generation" {
                                        HStack {
                                            TextField("Enter location type", text: $settlement.locationType).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                settlement.locationType = NSLocalizedString(settlement.randomLocationType(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.locationType, label: EmptyView()) {
                                            Text(NSLocalizedString("Planetside", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Planetside", comment: ""))
                                            Text(NSLocalizedString("Orbital", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Orbital", comment: ""))
                                            Text(NSLocalizedString("Deep Space", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Deep Space", comment: ""))
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                            //DERELICT
                            if settlement.derilict != [] {
                                Section(header:
                                            HStack {
                                    Text("Derelict").font(.title)
                                    Spacer()
                                    Button {
                                        settlement.hiddenDerilict.toggle()
                                    } label: {
                                        Image(systemName: settlement.hiddenDerilict ? "chevron.down" : "chevron.right")
                                    }
                                }
                                ) {
                                    if settlement.hiddenDerilict {
                                        ForEach($settlement.derilict, id: \.id) { $loc in
                                            NavigationLink(destination: DerelictView(derelict: $loc, campaign: self.campaign)) {
                                                Text("Derelict \(settlement.name)")
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                        //FIRST LOOK
                        if settlement.firstLook != [] {
                            Section(header:
                                        HStack {
                                Text("First Look").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenFirstLook.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenFirstLook ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenFirstLook {
                                    if settlement.mode == "Input" {
                                        ForEach($settlement.firstLook) { $look in
                                            TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                        }.onDelete { (indexSet) in
                                            settlement.firstLook.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if settlement.mode == "Generation" {
                                        ForEach($settlement.firstLook) { $look in
                                            HStack {
                                                TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                                Spacer()
                                                Button {
                                                    look.name = settlement.randomFirstLook()
                                                } label: {
                                                    Image(systemName: "dice").font(.system(size: 20))
                                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                            }
                                        }.onDelete { (indexSet) in
                                            settlement.firstLook.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        ForEach($settlement.firstLook) { $look in
                                            Picker(selection: $look.name, label: EmptyView()) {
                                                ForEach(settlement.firstLookList, id: \.self) { value in
                                                    Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                        .tag(NSLocalizedString(value, comment: ""))
                                                }
                                            }.pickerStyle(.menu)
                                        }.onDelete { (indexSet) in
                                            settlement.firstLook.remove(atOffsets: indexSet)
                                        }
                                    }
                                }
                            }
                        }
                        
                        //INITIAL CONTACT
                        if settlement.initialContact != "" {
                            Section(header:
                                        HStack {
                                Text("Initial Contact").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenContact.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenContact ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenContact {
                                    if settlement.mode == "Input" {
                                        TextField("Enter initial contact", text: $settlement.initialContact).focused($fieldIsFocused)
                                    }
                                    if settlement.mode == "Generation" {
                                        HStack {
                                            TextField("Enter initial contact", text: $settlement.initialContact).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                settlement.initialContact = settlement.randomContact()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.initialContact, label: EmptyView()) {
                                            ForEach(settlement.contactList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        
                        //POPULATION
                        if settlement.population != "" && settlement.derilict == [] {
                            Section(header:
                                        HStack {
                                Text("Population").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenPopulation.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenPopulation ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenPopulation {
                                    if settlement.mode == "Input" {
                                        TextField("Enter population size", text: $settlement.population).focused($fieldIsFocused)
                                    }
                                    if settlement.mode == "Generation" {
                                        HStack {
                                            TextField("Enter population size", text: $settlement.population).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                settlement.population = settlement.randomPopulation(region: getHomeRegion(homeSector: settlement.homeSector))
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.population, label: EmptyView()) {
                                            Text(NSLocalizedString("Few", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Few", comment: ""))
                                            Text(NSLocalizedString("Dozens", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Dozens", comment: ""))
                                            Text(NSLocalizedString("Hundreds", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Hundreds", comment: ""))
                                            Text(NSLocalizedString("Thousands", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Thousands", comment: ""))
                                            Text(NSLocalizedString("Tens of thousands", comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString("Tens of thousands", comment: ""))
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        
                        //INHABITANTS
                        if settlement.inhabitants != [] {
                            Section(header:
                                        HStack {
                                Text("Inhabitants").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenInhabitants.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenInhabitants ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenInhabitants {
                                    ForEach($settlement.inhabitants) { $people in
                                        TextField("Enter inhabitants", text: $people.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        settlement.inhabitants.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                        //AUTHORITY
                        if settlement.authority != "" {
                            Section(header:
                                        HStack {
                                Text("Authority").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenAuth.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenAuth ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenAuth {
                                    
                                    if settlement.mode == "Generation" {
                                        HStack {
                                            TextField("Enter authority", text: $settlement.authority).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                settlement.authority = settlement.randomAuthority()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Input" {
                                        TextField("Enter authority", text: $settlement.authority).focused($fieldIsFocused)
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.authority, label: EmptyView()) {
                                            ForEach(settlement.authorityList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                                             
                        //PROJECTS
                        if settlement.projects != [] {
                            Section(header:
                                        HStack {
                                Text("Projects").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenProjects.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenProjects ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenProjects {
                                    if settlement.mode == "Input" {
                                        ForEach($settlement.projects) { $project in
                                            TextField("Enter project", text: $project.name).focused($fieldIsFocused)
                                        }.onDelete { (indexSet) in
                                            settlement.projects.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if settlement.mode == "Generation" {
                                        ForEach($settlement.projects) { $project in
                                            HStack {
                                                TextField("Enter project", text: $project.name).focused($fieldIsFocused)
                                                Spacer()
                                                Button {
                                                    project.name = NSLocalizedString(settlement.randomProject(), comment: "")
                                                } label: {
                                                    Image(systemName: "dice").font(.system(size: 20))
                                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                            }
                                        }.onDelete { (indexSet) in
                                            settlement.projects.remove(atOffsets: indexSet)
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        ForEach($settlement.projects) { $project in
                                            Picker(selection: $project.name, label: EmptyView()) {
                                                ForEach(settlement.projectList, id: \.self) { value in
                                                    Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                        .tag(NSLocalizedString(value, comment: ""))
                                                }
                                            }.pickerStyle(.menu)
                                        }.onDelete { (indexSet) in
                                            settlement.projects.remove(atOffsets: indexSet)
                                        }
                                    }
                                }
                            }
                        }
                        
                        //PRECURSOR VAULT
                        if settlement.vaults != [] {
                            Section(header:
                                        HStack {
                                Text("Precursor Vaults").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenVault.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenVault ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenVault {
                                    ForEach($settlement.vaults, id: \.id) { $vault in
                                        NavigationLink(destination: PrecursorVaultsView(vault: $vault, campaign: self.campaign)) {
                                            Text(vault.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.vaults.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                        
                    }

                    Group {

                        //TROUBLE
                        if settlement.trouble != "" && settlement.derilict == [] {
                            Section(header:
                                        HStack {
                                Text("Trouble").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenTrouble.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenTrouble ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenTrouble {
                                    if settlement.mode == "Input" {
                                        TextField("Enter trouble", text: $settlement.trouble).focused($fieldIsFocused)
                                    }
                                    if settlement.mode == "Generation" {
                                        HStack {
                                            TextField("Enter trouble", text: $settlement.trouble).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                if campaign.world.sectorIsLand {
                                                    settlement.trouble = settlement.randomTroubleIs()
                                                } else {
                                                    settlement.trouble = settlement.randomTroubleSf()
                                                }
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.trouble, label: EmptyView()) {
                                            ForEach(campaign.world.sectorIsLand ? settlement.troubleListIs : settlement.troubleListSf, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        
                        //LOCATIONS
                        if settlement.locations != [] {
                            Section(header:
                                        HStack {
                                Text("Locations").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenLocations.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenLocations ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenLocations {
                                    ForEach($settlement.locations, id: \.id) { $place in
                                        NavigationLink(destination: LocationView(location: $place, campaign: self.campaign)) {
                                            Text(place.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.locations.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //FACTIONS
                        if settlement.factions != [] {
                            Section(header:
                                        HStack {
                                Text("Factions").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenFactions.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenFactions ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenFactions {
                                    ForEach($settlement.factions, id: \.id) { $faction in
                                       NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                           Text(faction.name)
                                       }
                                   }.onDelete { (indexSet) in
                                       settlement.factions.remove(atOffsets: indexSet)
                                   }
                                }
                            }
                        }

                        //PERSONS
                        if settlement.persons != [] {
                            Section(header:
                                        HStack {
                                Text("Persons").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenPersons.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenPersons ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenPersons {
                                    ForEach($settlement.persons, id: \.id) { $person in
                                        NavigationLink(destination: PersonView(person: $person, campaign: self.campaign)) {
                                            Text(person.name)
                                            //Text(campaign.world.sectorIsLand ? "\(person.name) the \(person.role.lowercased())" : person.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.persons.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //VEHICLES
                        if settlement.vehicles != [] {
                            Section(header:
                                        HStack {
                                Text("Starships").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenVehicles.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenVehicles ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenVehicles {
                                    ForEach($settlement.vehicles, id: \.id) { $vehicle in
                                        NavigationLink(destination: StarshipView(starship: $vehicle, campaign: Campaign())) {
                                            Text(vehicle.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.vehicles.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //CREATURES
                        if settlement.creatures != [] {
                            Section(header:
                                        HStack {
                                Text("Creatures").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenCreature.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenCreature ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenCreature {
                                    ForEach($settlement.creatures, id: \.id) { $creature in
                                        NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                            Text(creature.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.creatures.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //ROUTES
                        if settlement.routes != [] {
                            Section(header:
                                        HStack {
                                Text("Routes").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenRoutes.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenRoutes ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenRoutes {
                                    ForEach($settlement.routes, id: \.id) { $route in
                                        NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                            Text("\(NSLocalizedString(route.rank.rawValue.capitalized, comment: "")) route to \(route.destination)")
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.routes.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }

                        //DESCRIPTION
                        if settlement.description != "" {
                            Section(header:
                                        HStack {
                                Text("Description").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenDescription.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenDescription ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenDescription {
                                    TextEditor(text: $settlement.description)
                                        .focused($fieldIsFocused)
                                }
                            }
                        }
                        // CLOCK
                        if settlement.clocks != [] {
                            Section(header:
                                        HStack {
                                Text("Clocks").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenClock.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenClock ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenClock {
                                    ForEach($settlement.clocks, id: \.id) { $clock in
                                        NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                            Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                       }
                                   }.onDelete { (indexSet) in
                                       settlement.clocks.remove(atOffsets: indexSet)
                                   }

                                }
                            }
                        }
                    }
                    
                }.listStyle(.inset)
            }
            .navigationTitle(settlement.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Hide") {
                        fieldIsFocused = false
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        if settlement.locationType == "" {
                            Button {
                                generateSettlement()
                                campaign.writeToFile()
                            } label: {
                                Text("Generate Settlement")
                            }
                        }
                        Group {
                            if settlement.waitingForStarship {
                                Button {
                                    settlement.vehicles.insert(buffer.starshipBuffer[0], at: 0)
                                    settlement.vehicles[0].homeSector = settlement.homeSector
                                    buffer.starshipBuffer = []
                                    settlement.waitingForStarship = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the starship")
                                }
                            }
                            if settlement.waitingForPerson {
                                Button {
                                    settlement.persons.insert(buffer.personBuffer[0], at: 0)
                                    //settlement.persons[0].homeSector = settlement.homeSector
                                    buffer.personBuffer = []
                                    settlement.waitingForPerson = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert a person")
                                }
                            }
                            if settlement.waitingForFaction {
                                Button {
                                    settlement.factions.insert(buffer.factionBuffer[0], at: 0)
                                    buffer.factionBuffer = []
                                    settlement.waitingForFaction = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the faction")
                                }
                            }
                            if settlement.waitingForCreature {
                                Button {
                                    settlement.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                    settlement.creatures[0].homeSector = settlement.homeSector
                                    buffer.creatureBuffer = []
                                    settlement.waitingForCreature = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the creature")
                                }
                            }
                        }
                        Menu {
                            if settlement.mode != "Input" {
                                Button {
                                    settlement.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if settlement.mode != "Selection" {
                                Button {
                                    settlement.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if settlement.mode != "Generation" {
                                Button {
                                    settlement.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Text("Mode")
                        }
                        if settlement.derilict.count < 1 && campaign.world.sectorIsLand == false {
                            Button {
                                settlement.hiddenDerilict = true
                                settlement.derilict.insert(Derelict(isChild: true, location: settlement.locationType, type: "Derelict settlement", name: settlement.name), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Is Derelict")
                            }
                        }
                        
                        Menu {
                            Group {
                                if settlement.firstLook.count < 2 {
                                    Button {
                                        settlement.hiddenFirstLook = true
                                        settlement.firstLook.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New First Look")
                                    }
                                }
                                if settlement.initialContact == "" {
                                    Button {
                                        settlement.hiddenContact = true
                                        settlement.initialContact = NSLocalizedString("Unknown", comment: "")
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Initial Contact")
                                    }
                                }
                                if settlement.population == "" {
                                    Button {
                                        settlement.hiddenPopulation = true
                                        settlement.population = NSLocalizedString("Unknown", comment: "")
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Population")
                                    }
                                }
                            }
                            Group {
                                Button {
                                    settlement.hiddenInhabitants = true
                                    settlement.inhabitants.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Inhabitants")
                                }
                                if settlement.authority == "" {
                                    Button {
                                        settlement.hiddenAuth = true
                                        settlement.authority = NSLocalizedString("Unknown", comment: "")
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Authority")
                                    }
                                }
                                if settlement.projects.count < 2 {
                                    Button {
                                        settlement.hiddenProjects = true
                                        settlement.projects.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Project")
                                    }
                                }
                                if settlement.trouble == "" {
                                    Button {
                                        settlement.hiddenTrouble = true
                                        settlement.trouble = NSLocalizedString("Unknown", comment: "")
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Trouble")
                                    }
                                }
                                Button {
                                    settlement.hiddenFactions = true
                                    settlement.factions.insert(Faction(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Faction")
                                }
                                Button {
                                    settlement.hiddenPersons = true
                                    settlement.persons.insert(Person(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Person")
                                }
                                if campaign.world.sectorIsLand == false {
                                    Button {
                                        settlement.hiddenVehicles = true
                                        settlement.vehicles.insert(Starship(name: NSLocalizedString(Starship.randomName(mod: ""), comment: ""), homeSector: settlement.name), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Starship")
                                    }
                                    Button {
                                        settlement.hiddenVault = true
                                        settlement.vaults.insert(PrecursorVaults(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Add Precursor Vault")
                                    }
                                }
                                
                                Button {
                                    settlement.hiddenLocations = true
                                    settlement.locations.insert(Location(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Location")
                                }
                                Group {
                                    Button {
                                        settlement.hiddenCreature = true
                                        settlement.creatures.insert(Creature(homeSector: settlement.homeSector, name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Creature")
                                    }
                                    Button {
                                        settlement.hiddenRoutes = true
                                        settlement.routes.insert(Route(), at: 0)
                                        campaign.writeToFile()
                                    } label: {
                                        Text("New Route")
                                    }
                                    if settlement.subName == "" {
                                        Button {
                                            settlement.subName = NSLocalizedString("Any Subtitle", comment: "")
                                            campaign.writeToFile()
                                        } label: {
                                            Text("Subtitle")
                                        }
                                    }
                                    if settlement.description == "" {
                                        Button {
                                            settlement.description = " "
                                            campaign.writeToFile()
                                        } label: {
                                            Text("Description")
                                        }
                                    }
                                    Button {
                                        settlement.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                                        settlement.hiddenClock = true
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Add Clock")
                                    }
                                }
                            }
                        } label: {
                            Text("Add")
                        }
                        if campaign.world.sectorIsLand == false {
                            if campaign.world.type == "SF" || campaign.world.type == "stars" {
                                Button {
                                    buffer.settlementBuffer.insert(Settlement(id: settlement.id, name: settlement.name, subName: settlement.subName, hiddenDescription: settlement.hiddenDescription, description: settlement.description, hiddenLocType: settlement.hiddenLocType, locationType: settlement.locationType, hiddenInhabitants: settlement.hiddenInhabitants, inhabitants: settlement.inhabitants, hiddenPopulation: settlement.hiddenPopulation, population: settlement.population, hiddenFirstLook: settlement.hiddenFirstLook, firstLook: settlement.firstLook, hiddenContact: settlement.hiddenContact, initialContact: settlement.initialContact, hiddenAuth: settlement.hiddenAuth, authority: settlement.authority, hiddenProjects: settlement.hiddenProjects, projects: settlement.projects, hiddenTrouble: settlement.hiddenTrouble, hiddenFactions: settlement.hiddenFactions, factions: settlement.factions, trouble: settlement.trouble, hiddenRoutes: settlement.hiddenRoutes, routes: [], homeSector: "", mode: settlement.mode, oracle: Oracle.sharedOracle, travelMode: settlement.travelMode, hiddenLocations: settlement.hiddenLocations, locations: settlement.locations, hiddenPersons: settlement.hiddenPersons, persons: settlement.persons, hiddenDerilict: settlement.hiddenDerilict, derilict: settlement.derilict, hiddenVault: settlement.hiddenVault, vaults: settlement.vaults, waitingForStarship: settlement.waitingForStarship, vehicles: settlement.vehicles, hiddenVehicles: settlement.hiddenVehicles, firstLookList: settlement.firstLookList, contactList: settlement.contactList, authorityList: settlement.authorityList, projectList: settlement.projectList, troubleListSf: settlement.troubleListSf, troubleListIs: settlement.troubleListIs), at: 0)
                                    settlement.name = "toDelate"
                                    self.mode.wrappedValue.dismiss()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Move Settlement")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            if buffer.starshipBuffer != [] {
                settlement.waitingForStarship = true
            } else {
                settlement.waitingForStarship = false
            }
            if buffer.personBuffer != [] {
                settlement.waitingForPerson = true
            } else {
                settlement.waitingForPerson = false
            }
            if buffer.creatureBuffer != [] {
                settlement.waitingForCreature = true
            } else {
                settlement.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                settlement.waitingForFaction = true
            } else {
                settlement.waitingForFaction = false
            }
            
            for _ in settlement.factions {
                if let index = settlement.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    settlement.factions.remove(at: index)
                }
            }
            for _ in settlement.creatures {
                if let index = settlement.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    settlement.creatures.remove(at: index)
                }
            }
            for _ in settlement.vehicles {
                if let index = settlement.vehicles.firstIndex(where: { $0.name == "toDelate" }) {
                    settlement.vehicles.remove(at: index)
                }
            }
            for _ in settlement.persons {
                if let index = settlement.persons.firstIndex(where: { $0.name == "toDelate" }) {
                    settlement.persons.remove(at: index)
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
    func generateSettlement() {
        settlement.name = Settlement.randomName(isLand: campaign.world.sectorIsLand)
        settlement.locationType = settlement.randomLocationType()
        settlement.hiddenPopulation = false
        settlement.population = settlement.randomPopulation(region: getHomeRegion(homeSector: settlement.homeSector))
        
        settlement.hiddenFirstLook = false
        settlement.firstLook = []
        settlement.firstLook.insert(StringContainer(), at: 0)
        settlement.firstLook[0].name = settlement.randomFirstLook()
//        let howManyFirstLook = Int.random(in: 0...3)
//        if howManyFirstLook > 0 {
//            settlement.firstLook.insert(StringContainer(), at: 0)
//            settlement.firstLook[0].name = settlement.randomFirstLook()
//        } else {
//            settlement.firstLook.insert(StringContainer(), at: 0)
//            settlement.firstLook[0].name = settlement.randomFirstLook()
//            settlement.firstLook.insert(StringContainer(), at: 0)
//            settlement.firstLook[0].name = settlement.randomFirstLook()
//        }
        
        settlement.hiddenContact = false
        settlement.initialContact = settlement.randomContact()
        
        settlement.hiddenAuth = false
        settlement.authority = settlement.randomAuthority()
        
        settlement.hiddenProjects = false
        settlement.projects = []
        settlement.projects.insert(StringContainer(), at: 0)
        settlement.projects[0].name = settlement.randomProject()
//        let howManyProjects = Int.random(in: 0...3)
//        if howManyProjects > 0 {
//            settlement.projects.insert(StringContainer(), at: 0)
//            settlement.projects[0].name = settlement.randomProject()
//        } else {
//            settlement.projects.insert(StringContainer(), at: 0)
//            settlement.projects[0].name = settlement.randomProject()
//            settlement.projects.insert(StringContainer(), at: 0)
//            settlement.projects[0].name = settlement.randomProject()
//        }
        
        settlement.hiddenTrouble = false
        if campaign.world.sectorIsLand {
            settlement.trouble = settlement.randomTroubleIs()
        } else {
            settlement.trouble = settlement.randomTroubleSf()
        }
        settlement.mode = "Generation"
        if settlement.initialContact == "Derelict" {
            
        }
    }
}

struct SettlementView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementView(settlement: .constant(Settlement()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
