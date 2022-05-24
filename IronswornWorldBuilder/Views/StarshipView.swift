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


//                    if starship.theme != "" {
//                        Section(header: Text("Theme").font(.title)) {
//                            TextEditor(text: $starship.theme)
//                                .focused($fieldIsFocused)
//                        }
//                    }

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
                        Button {
                            campaign.writeToFile()
                            generateStarship()
                        } label: {
                            Text("Generate Starship")
                        }
                        Menu {
                            if starship.fleet == "" && starship.type == "Fleet" {
                                Button {
                                    campaign.writeToFile()
                                    starship.fleet = "Unknown Fleet"
                                } label: {
                                    Text("Fleet")
                                }
                            }
                            if starship.missions.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    starship.missions.insert(StringContainer(), at: 0)
                                } label: {
                                    Text("New Mission")
                                }
                            }
                            if starship.firstLook.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    starship.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New First Look")
                                }
                            }
                            if starship.initialContact == "" {
                                Button {
                                    campaign.writeToFile()
                                    starship.initialContact = starship.randomContact()
                                } label: {
                                    Text("Initial Contact")
                                }
                            }
                            if starship.description == "" {
                                Button {
                                    campaign.writeToFile()
                                    starship.description = "New Description"
                                } label: {
                                    Text("Description")
                                }
                            }
                            if starship.subName == "" {
                                Button {
                                    campaign.writeToFile()
                                    starship.subName = "Any Subtitle"
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
