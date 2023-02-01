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
    @State private var displayText = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var buffer = movingBuffer.shared
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                //TITLES
                VStack {
                    
                    HStack {
                        TextField("Enter person name", text: $person.name)
                            .minimumScaleFactor(0.5)
                            .font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if person.mode == "Generation" {
                            Spacer()
                            Button {
                                person.name = person.randomName(isLand: campaign.world.sectorIsLand)
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
                
                //COMBAT BUTTONS
                if person.combatMode {
                    VStack {
                        HStack(spacing: 15) {
                            Button {
                                displayText = NSLocalizedString(person.oracle.randomAction(), comment: "")
                            } label: {
                                Text("Combat Action")
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button {
                                displayText = person.oracle.randomEmotion()
                            } label: {
                                Text("Текущие эмоции")
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
                                                look.name = NSLocalizedString(person.randomFirstLook(isLand: campaign.world.sectorIsLand), comment: "")
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
                                            ForEach(campaign.world.sectorIsLand ? person.firstLookListIS : person.firstLookListSF, id: \.self) { value in
                                                Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                    .tag(NSLocalizedString(value, comment: ""))
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
                                            person.disposition = NSLocalizedString(person.randomDisposition(), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.disposition, label: EmptyView()) {
                                        ForEach(person.dispositionList, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
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
                                            person.role = NSLocalizedString(person.randomRole(isLand: campaign.world.sectorIsLand), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.role, label: EmptyView()) {
                                        ForEach(campaign.world.sectorIsLand ? person.roleListIS : person.roleListSF, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
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
                                            person.goal = NSLocalizedString(person.randomGoal(isLand: campaign.world.sectorIsLand), comment: "")
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if person.mode == "Selection" {
                                    Picker(selection: $person.goal, label: EmptyView()) {
                                        ForEach(campaign.world.sectorIsLand ? person.goalListIS : person.goalListSF, id: \.self) { value in
                                            Text(NSLocalizedString(value, comment: "")).font(.system(size: 50))
                                                .tag(NSLocalizedString(value, comment: ""))
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
                    // CLOCK
                    if person.clocks != [] {
                        Section(header:
                                    HStack {
                            Text("Clocks").font(.title)
                            Spacer()
                            Button {
                                person.hiddenClock.toggle()
                            } label: {
                                Image(systemName: person.hiddenClock ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if person.hiddenClock {
                                ForEach($person.clocks, id: \.id) { $clock in
                                    NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                        Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                                   }
                               }.onDelete { (indexSet) in
                                   person.clocks.remove(atOffsets: indexSet)
                               }

                            }
                        }
                    }
                    
                }.listStyle(.inset)
            }
            //.navigationTitle(person.name)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    Menu {
                        if person.role == "" {
                            Button {
                                generatePerson(isLand: campaign.world.sectorIsLand)
                                campaign.writeToFile()
                            } label: {
                                Text("Generate Person")
                            }
                        }
                        Toggle(isOn: $person.combatMode) {
                            Text("Encounter Mode")
                        }
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
                        
                        Menu {
                            if person.firstLook.count < 2 {
                                Button {
                                    person.firstLook.insert(StringContainer(name: NSLocalizedString("Unknown", comment: "")), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("New First Look")
                                }
                            }
                            if person.disposition == "" {
                                Button {
                                    person.disposition = NSLocalizedString("Unknown", comment: "")
                                    campaign.writeToFile()
                                } label: {
                                    Text("Disposition")
                                }
                            }
                            if person.role == "" {
                                Button {
                                    person.role = NSLocalizedString("Unknown", comment: "")
                                    campaign.writeToFile()
                                } label: {
                                    Text("Role")
                                }
                            }
                            if person.goal == "" {
                                Button {
                                    person.goal = NSLocalizedString("Unknown", comment: "")
                                    campaign.writeToFile()
                                } label: {
                                    Text("Goal")
                                }
                            }
                            
                            if person.description == "" {
                                Button {
                                    person.description = " "
                                    campaign.writeToFile()
                                } label: {
                                    Text("Description")
                                }
                            }
                            if person.subName == "" {
                                Button {
                                    person.subName = "Any Subtitle"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Subtitle")
                                }
                            }
                            Button {
                                person.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                                person.hiddenClock = true
                                campaign.writeToFile()
                            } label: {
                                Text("Add Clock")
                            }
                        } label: {
                            Text("Add")
                        }
                        Button {
                            buffer.personBuffer.insert(Person(id: person.id, name: person.name, subName: person.subName, hiddenDescription: person.hiddenDescription, description: person.description, hiddenFirstLook: person.hiddenFirstLook, firstLook: person.firstLook, hiddenDisposition: person.hiddenDisposition, disposition: person.disposition, hiddenRole: person.hiddenRole, role: person.role, hiddenGoal: person.hiddenGoal, goal: person.goal, hiddenAspect: person.hiddenAspect, revealdAspect: person.revealdAspect, mode: person.mode, combatMode: person.combatMode, oracle: Oracle.sharedOracle, firstLookListIS: person.firstLookListIS, dispositionList: person.dispositionList, roleListIS: person.roleListIS, goalListSF: person.goalListSF, aspectList: person.aspectList), at: 0)
                            person.name = "toDelate"
                            self.mode.wrappedValue.dismiss()
                            campaign.writeToFile()
                        } label: {
                            Text("Move Person")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            Spacer()
        }
    }
    func generatePerson(isLand: Bool) {
        person.mode = "Generation"
        person.name = person.randomName(isLand: campaign.world.sectorIsLand)
        person.hiddenGoal = false
        person.goal = NSLocalizedString(person.randomGoal(isLand: campaign.world.sectorIsLand), comment: "")
        person.hiddenRole = false
        person.role = NSLocalizedString(person.randomRole(isLand: campaign.world.sectorIsLand), comment: "")
        person.hiddenDisposition = false
        person.disposition = NSLocalizedString(person.randomDisposition(), comment: "")
        
        person.hiddenFirstLook = false
        person.firstLook = []
        person.firstLook.insert(StringContainer(), at: 0)
        person.firstLook[0].name = NSLocalizedString(person.randomFirstLook(isLand: campaign.world.sectorIsLand), comment: "")
        person.firstLook.insert(StringContainer(), at: 0)
        person.firstLook[0].name = NSLocalizedString(person.randomFirstLook(isLand: campaign.world.sectorIsLand), comment: "")
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: .constant(Person(combatMode: true)), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
