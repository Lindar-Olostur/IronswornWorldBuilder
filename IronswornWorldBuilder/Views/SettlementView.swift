//
//  SettlementView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct SettlementView: View {
    @Binding var settlement: Settlement
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var generatorIsOn = false
    @State private var displayText = ""
    
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
                                settlement.name = Settlement.randomName()
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
                                            settlement.locationType = settlement.randomLocationType()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if settlement.mode == "Selection" {
                                    Picker(selection: $settlement.locationType, label: EmptyView()) {
                                        Text("Planetside").font(.system(size: 50))
                                            .tag("Planetside")
                                        Text("Orbital").font(.system(size: 50))
                                            .tag("Orbital")
                                        Text("Deep Space").font(.system(size: 50))
                                            .tag("Deep Space")
                                        Text("Unknown").font(.system(size: 50))
                                            .tag("Unknown")
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
                                                    Text(value).font(.system(size: 50))
                                                        .tag(value)
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        
                        //POPULATION
                        if settlement.population != "" && settlement.derilict != [] {
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
                                            Text("Few").font(.system(size: 50))
                                                .tag("Few")
                                            Text("Dozens").font(.system(size: 50))
                                                .tag("Dozens")
                                            Text("Hundreds").font(.system(size: 50))
                                                .tag("Hundreds")
                                            Text("Thousands").font(.system(size: 50))
                                                .tag("Thousands")
                                            Text("Tens of thousands").font(.system(size: 50))
                                                .tag("Tens of thousands")
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                                                    project.name = settlement.randomProject()
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
                                                    Text(value).font(.system(size: 50))
                                                        .tag(value)
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
                        if settlement.trouble != "" && settlement.derilict != [] {
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
                                                settlement.trouble = settlement.randomTrouble()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }
                                    if settlement.mode == "Selection" {
                                        Picker(selection: $settlement.trouble, label: EmptyView()) {
                                            ForEach(settlement.troubleList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }
                                }
                            }
                        }
                        //PLACES
                        if settlement.places != [] {
                            Section(header:
                                        HStack {
                                Text("Places").font(.title)
                                Spacer()
                                Button {
                                    settlement.hiddenLocations.toggle()
                                } label: {
                                    Image(systemName: settlement.hiddenLocations ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if settlement.hiddenLocations {
                                    ForEach($settlement.places, id: \.id) { $place in
                                        NavigationLink(destination: LocationView()) {
                                            Text(place.name)
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.places.remove(atOffsets: indexSet)
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
                                        }
                                    }.onDelete { (indexSet) in
                                        settlement.persons.remove(atOffsets: indexSet)
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
                                            Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
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
                        if settlement.derilict.count < 1 {
                            Button {
                                campaign.writeToFile()
                                settlement.derilict.insert(Derelict(isChild: true, location: settlement.locationType, type: "Derelict settlement", name: settlement.name), at: 0)
                            } label: {
                                Text("Is Derelict")
                            }
                        }
                        Button {
                            campaign.writeToFile()
                            generateSettlement()
                        } label: {
                            Text("Generate Settlement")
                        }
                        Menu {
                            Group {
                                if settlement.firstLook.count < 2 {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                    } label: {
                                        Text("New First Look")
                                    }
                                }
                                if settlement.initialContact == "" {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.initialContact = settlement.randomContact()
                                    } label: {
                                        Text("Initial Contact")
                                    }
                                }
                                if settlement.population == "" {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.initialContact = "Unknown"
                                    } label: {
                                        Text("Population")
                                    }
                                }
                            }
                            Group {
                                Button {
                                    campaign.writeToFile()
                                    settlement.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New Inhabitants")
                                }
                                if settlement.authority == "" {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.authority = "Unknown"
                                    } label: {
                                        Text("Authority")
                                    }
                                }
                                if settlement.projects.count < 2 {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.projects.insert(StringContainer(name: "Unknown"), at: 0)
                                    } label: {
                                        Text("New Project")
                                    }
                                }
                                if settlement.trouble == "" {
                                    Button {
                                        campaign.writeToFile()
                                        settlement.trouble = "Unknown"
                                    } label: {
                                        Text("Trouble")
                                    }
                                }
                                Button {
                                    campaign.writeToFile()
                                    settlement.factions.append(Faction())
                                } label: {
                                    Text("Add Faction")
                                }
                                Button {
                                    campaign.writeToFile()
                                    settlement.persons.insert(Person(), at: 0)
                                } label: {
                                    Text("New Person")
                                }
                                Button {
                                    campaign.writeToFile()
                                    settlement.vaults.insert(PrecursorVaults(name: "Unknown Vault"), at: 0)
                                } label: {
                                    Text("Add Precursor Vault")
                                }
                                Button {
                                    campaign.writeToFile()
                                    settlement.places.insert(Location(), at: 0)
                                } label: {
                                    Text("New Location")
                                }
                                Group {
                                    
                                    Button {
                                        campaign.writeToFile()
                                        settlement.routes.insert(Route(), at: 0)
                                    } label: {
                                        Text("New Route")
                                    }
                                    if settlement.subName == "" {
                                        Button {
                                            campaign.writeToFile()
                                            settlement.subName = "Any Subtitle"
                                        } label: {
                                            Text("Subtitle")
                                        }
                                    }
                                    if settlement.description == "" {
                                        Button {
                                            campaign.writeToFile()
                                            settlement.description = "New Description"
                                        } label: {
                                            Text("Description")
                                        }
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
        if settlement.name == "Unknown" {
            settlement.name = Settlement.randomName()
        }
        settlement.locationType = settlement.randomLocationType()
        settlement.hiddenPopulation = false
        settlement.population = settlement.randomPopulation(region: getHomeRegion(homeSector: settlement.homeSector))
        
        settlement.hiddenFirstLook = false
        settlement.firstLook = []
        let howManyFirstLook = Int.random(in: 0...3)
        if howManyFirstLook > 0 {
            settlement.firstLook.insert(StringContainer(), at: 0)
            settlement.firstLook[0].name = settlement.randomFirstLook()
        } else {
            settlement.firstLook.insert(StringContainer(), at: 0)
            settlement.firstLook[0].name = settlement.randomFirstLook()
            settlement.firstLook.insert(StringContainer(), at: 0)
            settlement.firstLook[0].name = settlement.randomFirstLook()
        }
        
        settlement.hiddenContact = false
        settlement.initialContact = settlement.randomContact()
        
        settlement.hiddenAuth = false
        settlement.authority = settlement.randomAuthority()
        
        settlement.hiddenProjects = false
        settlement.projects = []
        let howManyProjects = Int.random(in: 0...3)
        if howManyProjects > 0 {
            settlement.projects.insert(StringContainer(), at: 0)
            settlement.projects[0].name = settlement.randomProject()
        } else {
            settlement.projects.insert(StringContainer(), at: 0)
            settlement.projects[0].name = settlement.randomProject()
            settlement.projects.insert(StringContainer(), at: 0)
            settlement.projects[0].name = settlement.randomProject()
        }
        
        settlement.hiddenTrouble = false
        settlement.trouble = settlement.randomTrouble()
        
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
