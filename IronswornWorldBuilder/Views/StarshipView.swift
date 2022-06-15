//
//  VehicleView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct StarshipView: View {
    @Binding var starship: Starship
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var buffer = movingBuffer.shared
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                //TITLES
                VStack {
                    
                    HStack {
                        TextField("Enter starship name", text: $starship.name).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if starship.mode == "Generation" {
                            Spacer()
                            Button {
                                starship.name = Starship.randomName(mod: "Known")
                            } label: {
                                Image(systemName: "dice").font(.system(size: 20))
                            }
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            .padding(.trailing, 30)
                        }
                    }
                    if starship.subName != "" {
                        TextField("Another starship info", text: $starship.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                }
                
                List {
                    //TYPE
                    Section(header:
                                HStack {
                        Text("Class").font(.title)
                        Spacer()
                        Button {
                            starship.hiddenType.toggle()
                        } label: {
                            Image(systemName: starship.hiddenType ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if starship.hiddenType {
                            if starship.mode == "Input" {
                                TextField("Enter starship class", text: $starship.type).focused($fieldIsFocused)
                            }
                            if starship.mode == "Generation" {
                                HStack {
                                    TextField("Enter starship class", text: $starship.type).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        starship.type = starship.randomType()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if starship.mode == "Selection" {
                                Picker(selection: $starship.type, label: EmptyView()) {
                                    ForEach(starship.typeList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                    
                    //FLEET
                    if starship.fleet != "" {
                        Section(header:
                                    HStack {
                                    Text("Fleet").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenFleet.toggle()
                            } label: {
                                Image(systemName: starship.hiddenFleet ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenFleet {
                                if starship.mode == "Input" {
                                    TextField("Enter fleet", text: $starship.fleet).focused($fieldIsFocused)
                                }
                                if starship.mode == "Generation" {
                                    HStack {
                                        TextField("Enter fleet", text: $starship.fleet).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            starship.fleet = starship.randomFleet()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if starship.mode == "Selection" {
                                    Picker(selection: $starship.fleet
                                           , label: EmptyView()) {
                                        ForEach(starship.fleetList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    
                    //MISSION
                    if starship.missions != [] {
                        Section(header:
                                    HStack {
                            Text("Missions").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenMission.toggle()
                            } label: {
                                Image(systemName: starship.hiddenMission ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenMission {
                                if starship.mode == "Input" {
                                    ForEach($starship.missions) { $mission in
                                        TextField("Enter mission", text: $mission.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        starship.missions.remove(atOffsets: indexSet)
                                    }
                                }
                                if starship.mode == "Generation" {
                                    ForEach($starship.missions) { $mission in
                                        HStack {
                                            TextField("Enter mission", text: $mission.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                mission.name = starship.randomMission(region: getHomeRegion(homeSector: starship.homeSector))
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        starship.missions.remove(atOffsets: indexSet)
                                    }
                                }
                                if starship.mode == "Selection" {
                                    ForEach($starship.missions) { $mission in
                                        Picker(selection: $mission.name, label: EmptyView()) {
                                            ForEach(starship.missionList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        starship.missions.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    
                    //DESCRIPTION
                    if starship.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: starship.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenDescription {
                                TextEditor(text: $starship.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }

                    //FIRST LOOK
                    if starship.firstLook != [] {
                        Section(header:
                                    HStack {
                            Text("First Look").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenFirstLook.toggle()
                            } label: {
                                Image(systemName: starship.hiddenFirstLook ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenFirstLook {
                                if starship.mode == "Input" {
                                    ForEach($starship.firstLook) { $look in
                                        TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        starship.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if starship.mode == "Generation" {
                                    ForEach($starship.firstLook) { $look in
                                        HStack {
                                            TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                look.name = starship.randomFirstLook()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        starship.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if starship.mode == "Selection" {
                                    ForEach($starship.firstLook) { $look in
                                        Picker(selection: $look.name, label: EmptyView()) {
                                            ForEach(starship.firstLookList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        starship.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    
                    //INITIAL CONTACT
                    if starship.initialContact != "" {
                        Section(header:
                                    HStack {
                            Text("Initial Contact").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenContact.toggle()
                            } label: {
                                Image(systemName: starship.hiddenContact ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenContact {
                                if starship.mode == "Input" {
                                    TextField("Enter initial contact", text: $starship.initialContact).focused($fieldIsFocused)
                                }
                                if starship.mode == "Generation" {
                                    HStack {
                                        TextField("Enter initial contact", text: $starship.initialContact).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            starship.initialContact = starship.randomContact()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if starship.mode == "Selection" {
                                    Picker(selection: $starship.initialContact, label: EmptyView()) {
                                        ForEach(starship.contactList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }

                    //FACTIONS
                    if starship.factions != [] {
                        Section(header:
                                    HStack {
                            Text("Factions").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenFactions.toggle()
                            } label: {
                                Image(systemName: starship.hiddenFactions ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenFactions {
                                ForEach($starship.factions, id: \.id) { $faction in
                                   NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
                                       Text(faction.name)
                                   }
                               }.onDelete { (indexSet) in
                                   starship.factions.remove(atOffsets: indexSet)
                               }
                            }
                        }
                    }
                    //PERSONS
                    if starship.persons != [] {
                        Section(header:
                                    HStack {
                            Text("Persons").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenPersons.toggle()
                            } label: {
                                Image(systemName: starship.hiddenPersons ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenPersons {
                                ForEach($starship.persons, id: \.id) { $person in
                                    NavigationLink(destination: PersonView(person: $person, campaign: self.campaign)) {
                                        Text(person.name)
                                    }
                                }.onDelete { (indexSet) in
                                    starship.persons.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //CREATURES
                    if starship.creatures != [] {
                        Section(header:
                                    HStack {
                            Text("Creatures").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenCreature.toggle()
                            } label: {
                                Image(systemName: starship.hiddenCreature ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenCreature {
                                ForEach($starship.creatures, id: \.id) { $creature in
                                    NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                        Text(creature.name)
                                    }
                                }.onDelete { (indexSet) in
                                    starship.creatures.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //DERELICT
                    if starship.derilict != [] {
                        Section(header:
                                    HStack {
                            Text("Derelict").font(.title)
                            Spacer()
                            Button {
                                starship.hiddenDerilict.toggle()
                            } label: {
                                Image(systemName: starship.hiddenDerilict ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if starship.hiddenDerilict {
                                ForEach($starship.derilict, id: \.id) { $loc in
                                    NavigationLink(destination: DerelictView(derelict: $loc, campaign: self.campaign)) {
                                        Text("Derelict \(starship.name)")
                                    }
                                }
                                
                            }
                        }
                    }

                }.listStyle(.inset)
            }
           // .navigationTitle(starship.name)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        Group {
                            if starship.waitingForFaction {
                                Button {
                                    starship.factions.insert(buffer.factionBuffer[0], at: 0)
                                    buffer.factionBuffer = []
                                    starship.waitingForFaction = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the faction")
                                }
                            }
                            if starship.waitingForPerson{
                                Button {
                                    starship.persons.insert(buffer.personBuffer[0], at: 0)
                                    //starship.persons[0].homeSector = settlement.homeSector
                                    buffer.personBuffer = []
                                    starship.waitingForPerson = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert a person")
                                }
                            }
                            if starship.waitingForCreature {
                                Button {
                                    starship.creatures.insert(buffer.creatureBuffer[0], at: 0)
                                    starship.creatures[0].homeSector = starship.homeSector
                                    buffer.creatureBuffer = []
                                    starship.waitingForCreature = false
                                    campaign.writeToFile()
                                } label: {
                                    Text("Insert the creature")
                                }
                            }
                        }
                        Menu {
                            if starship.mode != "Input" {
                                Button {
                                    starship.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if starship.mode != "Selection" {
                                Button {
                                    starship.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if starship.mode != "Generation" {
                                Button {
                                    starship.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Text("Mode")
                        }
                        if starship.derilict.count < 1 {
                            Button {
                                starship.derilict.insert(Derelict(isChild: true, type: "Derelict starship", name: starship.name), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Is Derelict")
                            }
                        }
                        Button {
                            generateStarship()
                            campaign.writeToFile()
                        } label: {
                            Text("Generate Starship")
                        }
                        Menu {
                            if starship.fleet == "" && starship.type == "Fleet" {
                                Button {
                                    starship.fleet = "Unknown Fleet"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Fleet")
                                }
                            }
                            if starship.missions.count < 2 {
                                Button {
                                    starship.missions.insert(StringContainer(), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Mission")
                                }
                            }
                            if starship.firstLook.count < 2 {
                                Button {
                                    starship.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New First Look")
                                }
                            }
                            if starship.initialContact == "" {
                                Button {
                                    starship.initialContact = starship.randomContact()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Initial Contact")
                                }
                            }
                            Button {
                                starship.persons.insert(Person(), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Person")
                            }
                            Button {
                                starship.creatures.insert(Creature(homeSector: starship.homeSector, name: "Unknown creature"), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Creature")
                            }
                            Button {
                                starship.factions.insert(Faction(), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Add Faction")
                            }
                            if starship.description == "" {
                                Button {
                                    starship.description = "New Description"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Description")
                                }
                            }
                            if starship.subName == "" {
                                Button {
                                    starship.subName = "Any Subtitle"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Subtitle")
                                }
                            }
                        } label: {
                            Text("Add")
                        }
                        Button {
                            buffer.starshipBuffer.insert(Starship(id: starship.id, name: starship.name, subName: starship.subName, hiddenDescription: starship.hiddenDescription, description: starship.description, hiddenType: starship.hiddenType, type: starship.type, hiddenFleet: starship.hiddenFleet, fleet: starship.fleet, hiddenFirstLook: starship.hiddenFirstLook, firstLook: starship.firstLook, hiddenContact: starship.hiddenContact, initialContact: starship.initialContact, hiddenMission: starship.hiddenMission, missions: starship.missions, hiddenTheme: starship.hiddenTheme, theme: starship.theme, homeSector: "", hiddenFactions: starship.hiddenFactions, factions: starship.factions, mode: starship.mode, oracle: starship.oracle, hiddenDerilict: starship.hiddenDerilict, derilict: starship.derilict, missionList: starship.missionList, contactList: starship.contactList, firstLookList: starship.firstLookList, typeList: starship.typeList, fleetList: starship.fleetList), at: 0)
                            starship.name = "toDelate"
                            self.mode.wrappedValue.dismiss()
                            campaign.writeToFile()
                        } label: {
                            Text("Move Starship")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            if buffer.personBuffer != [] {
                starship.waitingForPerson = true
            } else {
                starship.waitingForPerson = false
            }
            if buffer.creatureBuffer != [] {
                starship.waitingForCreature = true
            } else {
                starship.waitingForCreature = false
            }
            if buffer.factionBuffer != [] {
                starship.waitingForFaction = true
            } else {
                starship.waitingForFaction = false
            }
            
            for _ in starship.factions {
                if let index = starship.factions.firstIndex(where: { $0.name == "toDelate" }) {
                    starship.factions.remove(at: index)
                }
            }
            for _ in starship.persons {
                if let index = starship.persons.firstIndex(where: { $0.name == "toDelate" }) {
                    starship.persons.remove(at: index)
                }
            }
            for _ in starship.creatures {
                if let index = starship.creatures.firstIndex(where: { $0.name == "toDelate" }) {
                    starship.creatures.remove(at: index)
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
    func generateStarship() {
        starship.name = Starship.randomName(mod: "Known")
        starship.type = starship.randomType()
        
        starship.hiddenFirstLook = false
        starship.firstLook = []
        let howManyFirstLook = Int.random(in: 0...3)
        if howManyFirstLook > 0 {
            starship.firstLook.insert(StringContainer(), at: 0)
            starship.firstLook[0].name = starship.randomFirstLook()
        } else {
            starship.firstLook.insert(StringContainer(), at: 0)
            starship.firstLook[0].name = starship.randomFirstLook()
            starship.firstLook.insert(StringContainer(), at: 0)
            starship.firstLook[0].name = starship.randomFirstLook()
        }
        
        starship.hiddenContact = false
        starship.initialContact = starship.randomContact()
        
        starship.hiddenMission = false
        starship.missions = []
        starship.missions.insert(StringContainer(), at: 0)
        starship.missions[0].name = starship.randomMission(region: "")
        
        if starship.initialContact == "Derelict" {
            
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipView(starship: .constant(Starship()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
