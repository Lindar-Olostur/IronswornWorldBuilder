//
//  CreatureView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct CreatureView: View {
    @Binding var creature: Creature
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var buffer = movingBuffer.shared
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                TextField("Enter creature name", text: $creature.name).font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .focused($fieldIsFocused)
                if creature.subName != "" {
                    TextField("Another creature info", text: $creature.subName)
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
            }
            
            //COMBAT BUTTONS
            if creature.combatMode {
                VStack {
                    HStack(spacing: 15) {
                        Button {
                            displayText = creature.oracle.randomAction() //"Action: \(creature.oracle.randomAction())"
                        } label: {
                            Text("Combat Action")
                                .foregroundColor(.black)
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
                //ENVIRONMENT
                Section(header:
                            HStack {
                    Text("Environment").font(.title)
                    Spacer()
                    Button {
                        creature.hiddenEnvironment.toggle()
                    } label: {
                        Image(systemName: creature.hiddenEnvironment ? "chevron.down" : "chevron.right")
                    }
                }
                ) {
                    if creature.hiddenEnvironment {
                        if creature.mode == "Input" {
                            TextField("Enter creature environment", text: $creature.environment).focused($fieldIsFocused)
                        }
                        if creature.mode == "Generation" {
                            HStack {
                                TextField("Enter creature environment", text: $creature.environment).focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    creature.environment = creature.randomEnvironment()
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            }
                        }
                        if creature.mode == "Selection" {
                            Picker(selection: $creature.environment, label: EmptyView()) {
                                ForEach(creature.environmentList, id: \.self) { value in
                                    Text(value).font(.system(size: 50))
                                        .tag(value)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }
                //SCALE
                Section(header:
                            HStack {
                    Text("Scale").font(.title)
                    Spacer()
                    Button {
                        creature.hiddenScale.toggle()
                    } label: {
                        Image(systemName: creature.hiddenScale ? "chevron.down" : "chevron.right")
                    }
                }
                ) {
                    if creature.hiddenScale {
                        if creature.mode == "Input" {
                            TextField("Enter creature scale", text: $creature.scale).focused($fieldIsFocused)
                        }
                        if creature.mode == "Generation" {
                            HStack {
                                TextField("Enter creature scale", text: $creature.scale).focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    creature.scale = creature.randomScale()
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            }
                        }
                        if creature.mode == "Selection" {
                            Picker(selection: $creature.scale, label: EmptyView()) {
                                ForEach(creature.scaleList, id: \.self) { value in
                                    Text(value).font(.system(size: 50))
                                        .tag(value)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }
                //FORM
                if creature.form != "" {
                    Section(header:
                                HStack {
                                Text("Basic Form").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenForm.toggle()
                        } label: {
                            Image(systemName: creature.hiddenForm ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenForm {
                            if creature.mode == "Input" {
                                TextField("Enter basic form", text: $creature.form).focused($fieldIsFocused)
                            }
                            if creature.mode == "Generation" {
                                HStack {
                                    TextField("Enter basic form", text: $creature.form).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        creature.form = creature.randomForm(environment: creature.environment)
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if creature.mode == "Selection" {
                                Picker(selection: $creature.form, label: EmptyView()) {
                                    ForEach(creature.formList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //FIRST LOOK
                if creature.firstLook != [] {
                    Section(header:
                                HStack {
                        Text("First Look").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenFirstLook.toggle()
                        } label: {
                            Image(systemName: creature.hiddenFirstLook ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenFirstLook {
                            if creature.mode == "Input" {
                                ForEach($creature.firstLook) { $look in
                                    TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                }.onDelete { (indexSet) in
                                    creature.firstLook.remove(atOffsets: indexSet)
                                }
                            }
                            if creature.mode == "Generation" {
                                ForEach($creature.firstLook) { $look in
                                    HStack {
                                        TextField("Enter first look", text: $look.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            look.name = creature.randomFirstLook()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    creature.firstLook.remove(atOffsets: indexSet)
                                }
                            }
                            if creature.mode == "Selection" {
                                ForEach($creature.firstLook) { $look in
                                    Picker(selection: $look.name, label: EmptyView()) {
                                        ForEach(creature.firstLookList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    creature.firstLook.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                //BEHAVIOR
                if creature.behavior != "" {
                    Section(header:
                                HStack {
                                Text("Behavior").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenBehavior.toggle()
                        } label: {
                            Image(systemName: creature.hiddenBehavior ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenBehavior {
                            if creature.mode == "Input" {
                                TextField("Enter behavior", text: $creature.behavior).focused($fieldIsFocused)
                            }
                            if creature.mode == "Generation" {
                                HStack {
                                    TextField("Enter behavior", text: $creature.behavior).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        creature.behavior = creature.randomBehavior()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if creature.mode == "Selection" {
                                Picker(selection: $creature.behavior, label: EmptyView()) {
                                    ForEach(creature.behaviorList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //ASPECT
                if creature.firstLook != [] {
                    Section(header:
                                HStack {
                        Text("Reveald Aspect").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenRevealdAspect.toggle()
                        } label: {
                            Image(systemName: creature.hiddenRevealdAspect ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenRevealdAspect {
                            if creature.mode == "Input" {
                                ForEach($creature.revealdAspect) { $aspect in
                                    TextField("Enter aspect", text: $aspect.name).focused($fieldIsFocused)
                                }.onDelete { (indexSet) in
                                    creature.revealdAspect.remove(atOffsets: indexSet)
                                }
                            }
                            if creature.mode == "Generation" {
                                ForEach($creature.revealdAspect) { $aspect in
                                    HStack {
                                        TextField("Enter aspect", text: $aspect.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            aspect.name = creature.randomAspect()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    creature.revealdAspect.remove(atOffsets: indexSet)
                                }
                            }
                            if creature.mode == "Selection" {
                                ForEach($creature.revealdAspect) { $aspect in
                                    Picker(selection: $aspect.name, label: EmptyView()) {
                                        ForEach(creature.aspectList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    creature.revealdAspect.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                //DESCRIPTION
                if creature.description != "" {
                    Section(header:
                                HStack {
                        Text("Description").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenDescription.toggle()
                        } label: {
                            Image(systemName: creature.hiddenDescription ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenDescription {
                            TextEditor(text: $creature.description)
                                .focused($fieldIsFocused)
                        }
                    }
                }
                // CLOCK
                if creature.clocks != [] {
                    Section(header:
                                HStack {
                        Text("Clocks").font(.title)
                        Spacer()
                        Button {
                            creature.hiddenClock.toggle()
                        } label: {
                            Image(systemName: creature.hiddenClock ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if creature.hiddenClock {
                            ForEach($creature.clocks, id: \.id) { $clock in
                                NavigationLink(destination: ClockView(clock: $clock, campaign: self.campaign)) {
                                    Text("\(clock.name) \(clock.currentClock)/\(clock.maxClock)")
                               }
                           }.onDelete { (indexSet) in
                               creature.clocks.remove(atOffsets: indexSet)
                           }

                        }
                    }
                }
            }.listStyle(.inset)
        }
        //.navigationTitle(creature.name)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide") {
                    fieldIsFocused = false
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Menu {
                    Toggle(isOn: $creature.combatMode) {
                        Text("Combat Mode")
                    }
                    Menu {
                        if creature.mode != "Input" {
                            Button {
                                creature.mode = "Input"
                            } label: {
                                Text("Input")
                            }
                        }
                        if creature.mode != "Selection" {
                            Button {
                                creature.mode = "Selection"
                            } label: {
                                Text("Selection")
                            }
                        }
                        if creature.mode != "Generation" {
                            Button {
                                creature.mode = "Generation"
                            } label: {
                                Text("Generation")
                            }
                        }
                    } label: {
                        Text("Mode")
                    }
                    Button {
                        generateCreature()
                        campaign.writeToFile()
                    } label: {
                        Text("Generate Creature")
                    }
                    Menu {
                        if creature.firstLook.count < 2 {
                            Button {
                                creature.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                creature.firstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("First Look")
                            }
                        }
                        if creature.form == "" {
                            Button {
                                creature.form = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Basic Form")
                            }
                        }
                        if creature.behavior == "" {
                            Button {
                                creature.behavior = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Behavior")
                            }
                        }
                        if creature.revealdAspect.count < 2 {
                            Button {
                                creature.revealdAspect.insert(StringContainer(name: "Unknown"), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Reveald Aspect")
                            }
                        }
                        if creature.description == "" {
                            Button {
                                creature.description = "New Description"
                                campaign.writeToFile()
                            } label: {
                                Text("Description")
                            }
                        }
                        if creature.subName == "" {
                            Button {
                                creature.subName = "Any Subtitle"
                                campaign.writeToFile()
                            } label: {
                                Text("Subtitle")
                            }
                        }
                        Button {
                            creature.clocks.insert(Clock(name: NSLocalizedString("New Clock", comment: "")), at: 0)
                            creature.hiddenClock = true
                            campaign.writeToFile()
                        } label: {
                            Text("Add Clock")
                        }
                    } label: {
                        Text("Add")
                    }
                    Button {
                        buffer.creatureBuffer.insert(Creature(id: creature.id, homeSector: "", hiddenEnvironment: creature.hiddenEnvironment, environment: creature.environment, hiddenScale: creature.hiddenScale, scale: creature.scale, hiddenForm: creature.hiddenForm, form: creature.form, hiddenFirstLook: creature.hiddenFirstLook, firstLook: creature.firstLook, hiddenBehavior: creature.hiddenBehavior, behavior: creature.behavior, hiddenRevealdAspect: creature.hiddenRevealdAspect, revealdAspect: creature.revealdAspect, name: creature.name, subName: creature.subName, hiddenDescription: creature.hiddenDescription, description: creature.description, mode: creature.mode, oracle: Oracle.sharedOracle, combatMode: creature.combatMode, environmentList: creature.environmentList, scaleList: creature.scaleList, formList: creature.formList, firstLookList: creature.firstLookList, behaviorList: creature.behaviorList, aspectList: creature.aspectList), at: 0)
                        creature.name = "toDelate"
                        self.mode.wrappedValue.dismiss()
                        campaign.writeToFile()
                    } label: {
                        Text("Move Creature")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        Spacer()
    }
    func generateCreature() {
        creature.environment = creature.randomEnvironment()
        creature.scale = creature.randomScale()
        creature.form = creature.randomForm(environment: creature.environment)
        
        creature.hiddenFirstLook = false
        creature.firstLook = []
        creature.firstLook.insert(StringContainer(name: creature.randomFirstLook()), at: 0)
        creature.firstLook[0].name = creature.randomFirstLook()
        creature.firstLook.insert(StringContainer(), at: 0)
        creature.firstLook[0].name = creature.randomFirstLook()
        creature.hiddenBehavior = false
        creature.behavior = creature.randomBehavior()
        creature.hiddenRevealdAspect = false
        creature.revealdAspect = []
        creature.revealdAspect.insert(StringContainer(), at: 0)
        creature.revealdAspect[0].name = creature.randomAspect()
    }
}

struct CreatureView_Previews: PreviewProvider {
    static var previews: some View {
        CreatureView(creature: .constant(Creature()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
