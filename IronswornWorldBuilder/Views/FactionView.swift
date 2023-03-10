//
//  FactionView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.05.2022.
//

import SwiftUI

struct FactionView: View {
    @Binding var faction: Faction
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var buffer = movingBuffer.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                //TITLE
                VStack {
                    HStack {
                        TextField("Enter faction name", text: $faction.name)
                            .minimumScaleFactor(0.5)
                            .font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if faction.mode == "Generation" {
                            Spacer()
                            Button {
                                faction.name = Faction.randomName()
                            } label: {
                                Image(systemName: "dice").font(.system(size: 20))
                            }
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            .padding(.trailing, 30)
                        }
                    }
                    if faction.subName != "" {
                        TextField("Another faction info", text: $faction.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                }
            }
            List {
                Group {
                    // TYPE
                    Section(header:
                                HStack {
                        Text("Type").font(.title)
                        Spacer()
                        Button {
                            faction.hiddenType.toggle()
                        } label: {
                            Image(systemName: faction.hiddenType ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if faction.hiddenType {
                            if faction.mode == "Input" {
                                TextField("Enter faction type", text: $faction.type).focused($fieldIsFocused)
                            }
                            if faction.mode == "Generation" {
                                HStack {
                                    TextField("Enter faction type", text: $faction.type).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        faction.type = NSLocalizedString(faction.randomType(), comment: "")
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if faction.mode == "Selection" {
                                Picker(selection: $faction.type, label: EmptyView()) {
                                    ForEach(faction.typeList, id: \.self) { value in
                                        Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                            .tag(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                    //INFLUENCE
                    if faction.influence != "" {
                        Section(header:
                                    HStack {
                            Text("Influence").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenInfluence.toggle()
                            } label: {
                                Image(systemName: faction.hiddenInfluence ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenInfluence {
                                
                                if faction.mode == "Generation" {
                                    HStack {
                                        TextField("Enter influence", text: $faction.influence).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            faction.influence = NSLocalizedString(faction.randomInfluence(), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if faction.mode == "Input" {
                                    TextField("Enter influence", text: $faction.influence).focused($fieldIsFocused)
                                }
                                if faction.mode == "Selection" {
                                    Picker(selection: $faction.influence, label: EmptyView()) {
                                        ForEach(faction.influenceList, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //DOMINION
                    if faction.dominion != [] {
                        Section(header:
                                    HStack {
                            Text("Dominion").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenDominion.toggle()
                            } label: {
                                Image(systemName: faction.hiddenDominion ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenDominion {
                                if faction.mode == "Input" {
                                    ForEach($faction.dominion) { $type in
                                        TextField("Enter dominion type", text: $type.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        faction.dominion.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Generation" {
                                    ForEach($faction.dominion) { $type in
                                        HStack {
                                            TextField("Enter dominion type", text: $type.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                type.name = NSLocalizedString(faction.randomDominion(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        faction.dominion.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Selection" {
                                    ForEach($faction.dominion) { $type in
                                        Picker(selection: $type.name, label: EmptyView()) {
                                            ForEach(faction.dominionList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        faction.dominion.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //LEADERSHIP
                    if faction.dominionLeadership != "" {
                        Section(header:
                                    HStack {
                            Text("Leadership").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenDominionLeadership.toggle()
                            } label: {
                                Image(systemName: faction.hiddenDominionLeadership ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenDominionLeadership {
                                
                                if faction.mode == "Generation" {
                                    HStack {
                                        TextField("Enter type leadership", text: $faction.dominionLeadership).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            faction.dominionLeadership = NSLocalizedString(faction.randomDominionLeadership(), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if faction.mode == "Input" {
                                    TextField("Enter type leadership", text: $faction.dominionLeadership).focused($fieldIsFocused)
                                }
                                if faction.mode == "Selection" {
                                    Picker(selection: $faction.dominionLeadership, label: EmptyView()) {
                                        ForEach(faction.dominionLeadershipList, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //GUILD
                    if faction.guild != "" {
                        Section(header:
                                    HStack {
                            Text("Guild").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenGuild.toggle()
                            } label: {
                                Image(systemName: faction.hiddenGuild ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenGuild {
                                
                                if faction.mode == "Generation" {
                                    HStack {
                                        TextField("Enter guild type", text: $faction.guild).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            faction.guild = NSLocalizedString(faction.randomGuild(), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if faction.mode == "Input" {
                                    TextField("Enter guild type", text: $faction.guild).focused($fieldIsFocused)
                                }
                                if faction.mode == "Selection" {
                                    Picker(selection: $faction.guild, label: EmptyView()) {
                                        ForEach(faction.guildList, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //GROUP
                    if faction.fringeGroup != "" {
                        Section(header:
                                    HStack {
                            Text("Fringe Group").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenFringeGroup.toggle()
                            } label: {
                                Image(systemName: faction.hiddenFringeGroup ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenFringeGroup {
                                
                                if faction.mode == "Generation" {
                                    HStack {
                                        TextField("Enter group type", text: $faction.fringeGroup).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            faction.fringeGroup = NSLocalizedString(faction.randomFringeGroup(), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if faction.mode == "Input" {
                                    TextField("Enter group type", text: $faction.fringeGroup).focused($fieldIsFocused)
                                }
                                if faction.mode == "Selection" {
                                    Picker(selection: $faction.fringeGroup, label: EmptyView()) {
                                        ForEach(faction.fringeGroupList, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //PROJECTS
                    if faction.projects != [] {
                        Section(header:
                                    HStack {
                            Text("Projects").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenProjects.toggle()
                            } label: {
                                Image(systemName: faction.hiddenProjects ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenProjects {
                                if faction.mode == "Input" {
                                    ForEach($faction.projects) { $type in
                                        TextField("Enter project", text: $type.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        faction.projects.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Generation" {
                                    ForEach($faction.projects) { $type in
                                        HStack {
                                            TextField("Enter project", text: $type.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                type.name = NSLocalizedString(faction.randomProject(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        faction.projects.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Selection" {
                                    ForEach($faction.projects) { $type in
                                        Picker(selection: $type.name, label: EmptyView()) {
                                            ForEach(faction.projectList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        faction.projects.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //RELATIONSHIP
                    if faction.relationships != [] {
                        Section(header:
                                    HStack {
                            Text("Relationships").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenRelationships.toggle()
                            } label: {
                                Image(systemName: faction.hiddenRelationships ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenRelationships {
                                if faction.mode == "Input" {
                                    ForEach($faction.relationships) { $type in
                                        TextField("Enter relationship", text: $type.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        faction.relationships.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Generation" {
                                    ForEach($faction.relationships) { $type in
                                        HStack {
                                            TextField("Enter relationship", text: $type.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                type.name = NSLocalizedString(faction.randomRelationship(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        faction.relationships.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Selection" {
                                    ForEach($faction.relationships) { $type in
                                        Picker(selection: $type.name, label: EmptyView()) {
                                            ForEach(faction.relationshipList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        faction.relationships.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                }
                Group {
                    //QUIRKS
                    if faction.quirks != [] {
                        Section(header:
                                    HStack {
                            Text("Quirks").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenQuirks.toggle()
                            } label: {
                                Image(systemName: faction.hiddenQuirks ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenQuirks {
                                if faction.mode == "Input" {
                                    ForEach($faction.quirks) { $type in
                                        TextField("Enter quirk", text: $type.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        faction.quirks.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Generation" {
                                    ForEach($faction.quirks) { $type in
                                        HStack {
                                            TextField("Enter quirk", text: $type.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                type.name = NSLocalizedString(faction.randomQuirk(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        faction.quirks.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Selection" {
                                    ForEach($faction.quirks) { $type in
                                        Picker(selection: $type.name, label: EmptyView()) {
                                            ForEach(faction.quirksList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        faction.quirks.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //RUMORS
                    if faction.rumors != [] {
                        Section(header:
                                    HStack {
                            Text("Rumors").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenRumors.toggle()
                            } label: {
                                Image(systemName: faction.hiddenRumors ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenRumors {
                                if faction.mode == "Input" {
                                    ForEach($faction.rumors) { $type in
                                        TextField("Enter rumor", text: $type.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        faction.rumors.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Generation" {
                                    ForEach($faction.rumors) { $type in
                                        HStack {
                                            TextField("Enter rumor", text: $type.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                type.name = NSLocalizedString(faction.randomRumor(), comment: "")
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        faction.rumors.remove(atOffsets: indexSet)
                                    }
                                }
                                if faction.mode == "Selection" {
                                    ForEach($faction.rumors) { $type in
                                        Picker(selection: $type.name, label: EmptyView()) {
                                            ForEach(faction.rumorsList, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        faction.rumors.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //PERSONS
                    if faction.persons != [] {
                        Section(header:
                                    HStack {
                            Text("Persons").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenPersons.toggle()
                            } label: {
                                Image(systemName: faction.hiddenPersons ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenPersons {
                                ForEach($faction.persons, id: \.id) { $person in
                                    NavigationLink(destination: PersonView(person: $person, campaign: self.campaign)) {
                                        Text(person.name)
                                    }
                                }.onDelete { (indexSet) in
                                    faction.persons.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    //DESCRIPTION
                    if faction.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: faction.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenDescription {
                                TextEditor(text: $faction.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                    // CLOCK
                    if faction.clocks != [] {
                        Section(header:
                                    HStack {
                            Text("Clocks").font(.title)
                            Spacer()
                            Button {
                                faction.hiddenClock.toggle()
                            } label: {
                                Image(systemName: faction.hiddenClock ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if faction.hiddenClock {
                                ForEach($faction.clocks, id: \.id) { $clock in
                                    NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                        Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                   }
                               }.onDelete { (indexSet) in
                                   faction.clocks.remove(atOffsets: indexSet)
                               }

                            }
                        }
                    }
                }
            }.listStyle(.inset)
        }
        //.navigationTitle(faction.name)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide") {
                    fieldIsFocused = false
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Menu {
                    Group {
                        if faction.waitingForPerson{
                            Button {
                                faction.persons.insert(buffer.personBuffer[0], at: 0)
                                //starship.persons[0].homeSector = settlement.homeSector
                                buffer.personBuffer = []
                                campaign.writeToFile()
                            } label: {
                                Text("Insert a person")
                            }
                        }
                    }
                    if faction.type == "" {
                        Button {
                            generateFaction()
                            campaign.writeToFile()
                        } label: {
                            Text("Generate Faction")
                        }
                    }
                    Menu {
                        if faction.mode != "Input" {
                            Button {
                                faction.mode = "Input"
                            } label: {
                                Text("Input")
                            }
                        }
                        if faction.mode != "Selection" {
                            Button {
                                faction.mode = "Selection"
                            } label: {
                                Text("Selection")
                            }
                        }
                        if faction.mode != "Generation" {
                            Button {
                                faction.mode = "Generation"
                            } label: {
                                Text("Generation")
                            }
                        }
                    } label: {
                        Text("Mode")
                    }
                    
                    Menu {
                        Group {
                            if faction.influence == "" {
                                Button {
                                    faction.influence = faction.randomInfluence()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Influence")
                                }
                            }
                            
                            if faction.dominion.count < 3 && faction.type == "Dominion" {
                                Button {
                                    faction.dominion.insert(StringContainer(name: "Unknown"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Dominion type")
                                }
                            }
                            if faction.dominionLeadership == "" && faction.type == "Dominion"  {
                                Button {
                                    faction.dominionLeadership = faction.randomDominionLeadership()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Dominion Leadership")
                                }
                            }
                            if faction.guild == "" && faction.type == "Guild"  {
                                Button {
                                    faction.guild = faction.randomGuild()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Guild type")
                                }
                            }
                            if faction.fringeGroup == "" && faction.type == "Fringe Group"  {
                                Button {
                                    faction.fringeGroup = faction.randomFringeGroup()
                                    campaign.writeToFile()
                                } label: {
                                    Text("Fringe Group")
                                }
                            }
                            
                        }
                        Group {
                            if faction.projects.count < 2 {
                                Button {
                                    faction.hiddenProjects = true
                                    faction.projects.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Project")
                                }
                            }
                            Button {
                                faction.relationships.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Relationships")
                            }
                            if faction.quirks.count < 2 {
                                Button {
                                    faction.hiddenQuirks = true
                                    faction.quirks.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Quirk")
                                }
                            }
                            if faction.rumors.count < 2 {
                                Button {
                                    faction.hiddenRumors = true
                                    faction.rumors.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New Rumor")
                                }
                            }
                            Button {
                                faction.hiddenPersons = true
                                faction.persons.insert(Person(name: NSLocalizedString("Unknown Person", comment: "")), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Person")
                            }
                            
                            Group {
                            
                                if faction.subName == "" {
                                    Button {
                                        faction.subName = "Any Subtitle"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Subtitle")
                                    }
                                }
                                if faction.description == "" {
                                    Button {
                                        faction.description = "New Description"
                                        campaign.writeToFile()
                                    } label: {
                                        Text("Description")
                                    }
                                }
                                Button {
                                    faction.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                                    faction.hiddenClock = true
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Clock")
                                }
                            }
                        }
                    } label: {
                        Text("Add")
                    }
                    Button {
                        buffer.factionBuffer.insert(Faction(id: faction.id, name: faction.name, subName: faction.subName, hiddenDescription: faction.hiddenDescription, description: faction.description, hiddenType: faction.hiddenType, type: faction.type, typeSummary: faction.typeSummary, hiddenInfluence: faction.hiddenInfluence, influence: faction.influence, influenceSummary: faction.influenceSummary, hiddenDominion: faction.hiddenDominion, dominion: faction.dominion, hiddenDominionLeadership: faction.hiddenDominionLeadership, dominionLeadership: faction.dominionLeadership, hiddenGuild: faction.hiddenGuild, guild: faction.guild, hiddenPersons: faction.hiddenPersons, persons: faction.persons, hiddenFringeGroup: faction.hiddenFringeGroup, fringeGroup: faction.fringeGroup, hiddenProjects: faction.hiddenProjects, projects: faction.projects, hiddenRelationships: faction.hiddenRelationships, relationships: faction.relationships, hiddenRumors: faction.hiddenRumors, rumors: faction.rumors, hiddenQuirks: faction.hiddenQuirks, quirks: faction.quirks, mode: faction.mode, oracle: Oracle.sharedOracle, waitingForPerson: faction.waitingForPerson, rumorsList: faction.rumorsList, quirksList: faction.quirksList, relationshipList: faction.relationshipList, projectList: faction.projectList, fringeGroupList: faction.fringeGroupList, guildList: faction.guildList, dominionLeadershipList: faction.dominionLeadershipList, dominionList: faction.dominionList, influenceList: faction.influenceList, typeList: faction.typeList), at: 0)
                        faction.name = "toDelate"
                        self.mode.wrappedValue.dismiss()
                        campaign.writeToFile()
                    } label: {
                        Text("Move Faction")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            if buffer.personBuffer != [] {
                faction.waitingForPerson = true
            }
            
            for _ in faction.persons {
                if let index = faction.persons.firstIndex(where: { $0.name == "toDelate" }) {
                    faction.persons.remove(at: index)
                }
            }
        }
    }
    func generateFaction() {
        faction.dominion = []
        faction.projects = []
        faction.quirks = []
        faction.rumors = []
        faction.guild = ""
        faction.dominionLeadership = ""
        faction.fringeGroup = ""
        
        faction.name = Faction.randomName()
        faction.hiddenType = false
        faction.type = NSLocalizedString(faction.randomType(), comment: "")
        faction.hiddenInfluence = false
        faction.influence = NSLocalizedString(faction.randomInfluence(), comment: "")
        if faction.type == "Dominion" || faction.type == "????????????" {
            faction.hiddenDominion = false
            let howManyDominions = Int.random(in: 0...5)
            if howManyDominions == 0 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
            }
            if howManyDominions == 1 || howManyDominions == 2 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
            }
            if howManyDominions > 2 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = NSLocalizedString(faction.randomDominion(), comment: "")
            }
            faction.hiddenDominionLeadership = false
            faction.dominionLeadership = NSLocalizedString(faction.randomDominionLeadership(), comment: "")
        }
        faction.hiddenDescription = false
        if faction.type == "Guild" || faction.type == "??????????????" {
            faction.hiddenGuild = false
            faction.guild = NSLocalizedString(faction.randomGuild(), comment: "")
        }
        if faction.type == "Fringe Group" || faction.type == "??????????" {
            faction.hiddenFringeGroup = false
            faction.fringeGroup = NSLocalizedString(faction.randomFringeGroup(), comment: "")
        }
        faction.hiddenProjects = false

        let howManyProjects = Int.random(in: 0...1)
        if howManyProjects != 0 {
            faction.projects = [StringContainer(name: NSLocalizedString(faction.randomProject(), comment: ""))]
        } else {
            faction.projects = [StringContainer(name: NSLocalizedString(faction.randomProject(), comment: "")), StringContainer(name: NSLocalizedString(faction.randomProject(), comment: ""))]
        }
        faction.hiddenQuirks = false
        
        let howManyQuirks = Int.random(in: 0...3)
        if howManyQuirks > 0 {
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = NSLocalizedString(faction.randomQuirk(), comment: "")
        } else {
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = NSLocalizedString(faction.randomQuirk(), comment: "")
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = NSLocalizedString(faction.randomQuirk(), comment: "")
        }
        faction.hiddenRumors = false

        let howManyRumors = Int.random(in: 0...3)
        if howManyRumors > 0 {
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = NSLocalizedString(faction.randomRumor(), comment: "")
        } else {
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = NSLocalizedString(faction.randomRumor(), comment: "")
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = NSLocalizedString(faction.randomRumor(), comment: "")
        }
        if faction.dominion == [] {
            faction.subName = "\(faction.influence) \(faction.type) \(faction.guild)\(faction.fringeGroup)"
        } else {
            faction.subName = "\(faction.influence) \(faction.dominion[0].name) \(faction.type)"
        }
        faction.mode = "Generation"
    }
}

struct FactionView_Previews: PreviewProvider {
    static var previews: some View {
        FactionView(faction: .constant(Faction()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
