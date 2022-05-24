//
//  PersonView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 19.05.2022.
//

import SwiftUI

struct PersonView: View {
    @Binding var person: Person
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                //TITLES
                VStack {
                    
                    HStack {
                        TextField("Enter person name", text: $person.name).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if person.mode == "Generation" {
                            Spacer()
                            Button {
                                person.name = person.randomName()
                            } label: {
                                Image(systemName: "dice").font(.system(size: 20))
                            }
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            .padding(.trailing, 30)
                        }
                    }
                    if person.subName != "" {
                        TextField("Another person info", text: $person.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                }
                
                List {
                    //FIRST LOOK
                    if person.firstLook != [] {
                        Section(header:
                                    HStack {
                            Text("First Look").font(.title)
                            Spacer()
                            Button {
                                person.hiddenFirstLook.toggle()
                            } label: {
                                Image(systemName: person.hiddenFirstLook ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenFirstLook {
                                if person.mode == "Input" {
                                    ForEach($person.firstLook) { $look in
                                        TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        person.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if person.mode == "Generation" {
                                    ForEach($person.firstLook) { $look in
                                        HStack {
                                            TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                look.name = person.randomFirstLook()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        person.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if person.mode == "Selection" {
                                    ForEach($person.firstLook) { $look in
                                        Picker(selection: $look.name, label: EmptyView()) {
                                            ForEach(person.firstLookList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        person.firstLook.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    
                    //DISPOSITION
                    if person.disposition != "" {
                        Section(header:
                                    HStack {
                                    Text("Disposition").font(.title)
                            Spacer()
                            Button {
                                person.hiddenDisposition.toggle()
                            } label: {
                                Image(systemName: person.hiddenDisposition ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenDisposition {
                                if person.mode == "Input" {
                                    TextField("Enter disposition", text: $person.disposition).focused($fieldIsFocused)
                                }
                                if person.mode == "Generation" {
                                    HStack {
                                        TextField("Enter disposition", text: $person.disposition).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            person.disposition = person.randomDisposition()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.disposition, label: EmptyView()) {
                                        ForEach(person.dispositionList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    
                    //ROLE
                    if person.role != "" {
                        Section(header:
                                    HStack {
                                    Text("Role").font(.title)
                            Spacer()
                            Button {
                                person.hiddenRole.toggle()
                            } label: {
                                Image(systemName: person.hiddenRole ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenRole {
                                if person.mode == "Input" {
                                    TextField("Enter role", text: $person.role).focused($fieldIsFocused)
                                }
                                if person.mode == "Generation" {
                                    HStack {
                                        TextField("Enter role", text: $person.role).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            person.role = person.randomRole()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.role, label: EmptyView()) {
                                        ForEach(person.roleList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    
                    //GOAL
                    if person.goal != "" {
                        Section(header:
                                    HStack {
                                    Text("Goal").font(.title)
                            Spacer()
                            Button {
                                person.hiddenGoal.toggle()
                            } label: {
                                Image(systemName: person.hiddenGoal ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenGoal {
                                if person.mode == "Input" {
                                    TextField("Enter goal", text: $person.goal).focused($fieldIsFocused)
                                }
                                if person.mode == "Generation" {
                                    HStack {
                                        TextField("Enter goal", text: $person.goal).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            person.goal = person.randomGoal()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.goal, label: EmptyView()) {
                                        ForEach(person.goalList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    
                    //DESCRIPTION
                    if person.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                person.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: person.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenDescription {
                                TextEditor(text: $person.description)
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
                        Menu {
                            if person.mode != "Input" {
                                Button {
                                    person.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if person.mode != "Selection" {
                                Button {
                                    person.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if person.mode != "Generation" {
                                Button {
                                    person.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Text("Mode")
                        }
                        Button {
                            campaign.writeToFile()
                            generatePerson()
                        } label: {
                            Text("Generate Person")
                        }
                        Menu {
                            if person.firstLook.count < 2 {
                                Button {
                                    campaign.writeToFile()
                                    person.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                } label: {
                                    Text("New First Look")
                                }
                            }
                            if person.disposition == "" {
                                Button {
                                    campaign.writeToFile()
                                    person.disposition = person.randomDisposition()
                                } label: {
                                    Text("Disposition")
                                }
                            }
                            if person.role == "" {
                                Button {
                                    campaign.writeToFile()
                                    person.role = person.randomRole()
                                } label: {
                                    Text("Role")
                                }
                            }
                            if person.goal == "" {
                                Button {
                                    campaign.writeToFile()
                                    person.goal = person.randomGoal()
                                } label: {
                                    Text("Goal")
                                }
                            }
                            
                            if person.description == "" {
                                Button {
                                    campaign.writeToFile()
                                    person.description = "New Description"
                                } label: {
                                    Text("Description")
                                }
                            }
                            if person.subName == "" {
                                Button {
                                    campaign.writeToFile()
                                    person.subName = "Any Subtitle"
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
    func generatePerson() {
        person.name = person.randomName()
        person.hiddenGoal = false
        person.goal = person.randomGoal()
        person.hiddenRole = false
        person.role = person.randomRole()
        person.hiddenDisposition = false
        person.disposition = person.randomDisposition()
        
        person.hiddenFirstLook = false
        person.firstLook = []
        person.firstLook.insert(StringContainer(), at: 0)
        person.firstLook[0].name = person.randomFirstLook()
        person.firstLook.insert(StringContainer(), at: 0)
        person.firstLook[0].name = person.randomFirstLook()
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: .constant(Person()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
