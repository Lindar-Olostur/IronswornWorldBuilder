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
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                //TITLE
                VStack {
                    HStack {
                        TextField("Enter faction name", text: $faction.name).font(.largeTitle.weight(.bold))
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
                                        faction.type = faction.randomType()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if faction.mode == "Selection" {
                                Picker(selection: $faction.type, label: EmptyView()) {
                                    ForEach(faction.typeList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
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
                                            faction.influence = faction.randomInfluence()
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
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
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
                                                type.name = faction.randomDominion()
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                                            faction.dominionLeadership = faction.randomDominionLeadership()
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
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
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
                                            faction.guild = faction.randomGuild()
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
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
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
                                            faction.fringeGroup = faction.randomFringeGroup()
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
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
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
                                                type.name = faction.randomProject()
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                                                type.name = faction.randomRelationship()
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                                                type.name = faction.randomQuirk()
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                                                type.name = faction.randomRumor()
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
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
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
                    Button {
                        campaign.writeToFile()
                        generateFaction()
                    } label: {
                        Text("Generate Faction")
                    }
                    Menu {
                        Group {
                            if faction.influence == "" {
                                Button {
                                    campaign.writeToFile()
                                    faction.influence = faction.randomInfluence()
                                } label: {
                                    Text("Influence")
                                }
                            }
                            
                            if faction.dominion.count < 3 && faction.type == "Dominion" {
                                Button {
                                    campaign.writeToFile()
                                    faction.dominion.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New Dominion type")
                                }
                            }
                            if faction.dominionLeadership == "" && faction.type == "Dominion"  {
                                Button {
                                    campaign.writeToFile()
                                    faction.dominionLeadership = faction.randomDominionLeadership()
                                } label: {
                                    Text("Dominion Leadership")
                                }
                            }
                            if faction.guild == "" && faction.type == "Guild"  {
                                Button {
                                    campaign.writeToFile()
                                    faction.guild = faction.randomGuild()
                                } label: {
                                    Text("Guild type")
                                }
                            }
                            if faction.fringeGroup == "" && faction.type == "Fringe Group"  {
                                Button {
                                    campaign.writeToFile()
                                    faction.fringeGroup = faction.randomFringeGroup()
                                } label: {
                                    Text("Fringe Group")
                                }
                            }
                            
                        }
                        Group {
                            if faction.projects.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    faction.projects.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New Project")
                                }
                            }
                            Button {
                                campaign.writeToFile()
                                faction.relationships.insert(StringContainer(name: "Unknown"), at: 0)
                            } label: {
                                Text("New Relationships")
                            }
                            if faction.quirks.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    faction.quirks.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New Quirk")
                                }
                            }
                            if faction.rumors.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    faction.rumors.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New Rumor")
                                }
                            }
                            Button {
                                campaign.writeToFile()
                                faction.persons.insert(Person(), at: 0)
                            } label: {
                                Text("New Person")
                            }
                            
                            Group {
                            
                                if faction.subName == "" {
                                    Button {
                                        campaign.writeToFile()
                                        faction.subName = "Any Subtitle"
                                    } label: {
                                        Text("Subtitle")
                                    }
                                }
                                if faction.description == "" {
                                    Button {
                                        campaign.writeToFile()
                                        faction.description = "New Description"
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
    func generateFaction() {
        faction.name = Faction.randomName()
        faction.hiddenType = true
        faction.type = faction.randomType()
        faction.hiddenInfluence = true
        faction.influence = faction.randomInfluence()
        if faction.type == "Dominion" {
            faction.dominion = []
            let howManyDominions = Int.random(in: 0...5)
            if howManyDominions == 0 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
            }
            if howManyDominions == 1 || howManyDominions == 2 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
            }
            if howManyDominions > 2 {
                faction.dominion.insert(StringContainer(), at: 0)
                faction.dominion[0].name = faction.randomDominion()
            }
            faction.dominionLeadership = faction.randomDominionLeadership()
        }
        if faction.type == "Guild" {
            faction.dominion = []
            faction.dominionLeadership = ""
            faction.guild = faction.randomGuild()
        }
        if faction.type == "Fringe Group" {
            faction.dominion = []
            faction.dominionLeadership = ""
            faction.fringeGroup = faction.randomFringeGroup()
        }
        faction.hiddenProjects = false
        faction.projects = []
        let howManyProjects = Int.random(in: 0...3)
        if howManyProjects > 0 {
            faction.projects.insert(StringContainer(), at: 0)
            faction.projects[0].name = faction.randomProject()
        } else {
            faction.projects.insert(StringContainer(), at: 0)
            faction.projects[0].name = faction.randomProject()
            faction.projects.insert(StringContainer(), at: 0)
            faction.projects[0].name = faction.randomProject()
        }
        faction.hiddenQuirks = false
        faction.quirks = []
        let howManyQuirks = Int.random(in: 0...3)
        if howManyQuirks > 0 {
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = faction.randomQuirk()
        } else {
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = faction.randomQuirk()
            faction.quirks.insert(StringContainer(), at: 0)
            faction.quirks[0].name = faction.randomQuirk()
        }
        faction.hiddenRumors = false
        faction.rumors = []
        let howManyRumors = Int.random(in: 0...3)
        if howManyRumors > 0 {
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = faction.randomRumor()
        } else {
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = faction.randomRumor()
            faction.rumors.insert(StringContainer(), at: 0)
            faction.rumors[0].name = faction.randomRumor()
        }
    }
}

struct FactionView_Previews: PreviewProvider {
    static var previews: some View {
        FactionView(faction: .constant(Faction()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
