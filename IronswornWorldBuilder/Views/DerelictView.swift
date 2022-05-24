//
//  DerelictView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 24.05.2022.
//

import SwiftUI

struct DerelictView: View {
    @Binding var derelict: Derelict
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    var themeList: [String] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                TextField("Enter derelict name", text: $derelict.name).font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .focused($fieldIsFocused)
                if derelict.subName != "" {
                    TextField("Another derelict info", text: $derelict.subName)
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
            }
            
            List {
                //LOCATION
                if derelict.location != "" {
                    Section(header:
                                HStack {
                                Text("Location").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenLocation.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenLocation ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenLocation {
                            if derelict.mode == "Input" {
                                TextField("Enter location", text: $derelict.location).focused($fieldIsFocused)
                            }
                            if derelict.mode == "Generation" {
                                HStack {
                                    TextField("Enter location", text: $derelict.location).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        derelict.location = derelict.randomLocation()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if derelict.mode == "Selection" {
                                Picker(selection: $derelict.location, label: EmptyView()) {
                                    ForEach(derelict.locationList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //TYPE
                if derelict.type != "" {
                    Section(header:
                                HStack {
                                Text("Type").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenType.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenType ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenType {
                            if derelict.mode == "Input" {
                                TextField("Enter type", text: $derelict.type).focused($fieldIsFocused)
                            }
                            if derelict.mode == "Generation" {
                                HStack {
                                    TextField("Enter type", text: $derelict.type).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        derelict.type = derelict.randomType(location: derelict.location)
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if derelict.mode == "Selection" {
                                Picker(selection: $derelict.type, label: EmptyView()) {
                                    ForEach(derelict.typeList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //CONDITION
                if derelict.condition != "" {
                    Section(header:
                                HStack {
                                Text("Condition").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenCondition.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenCondition ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenCondition {
                            if derelict.mode == "Input" {
                                TextField("Enter condition", text: $derelict.condition).focused($fieldIsFocused)
                            }
                            if derelict.mode == "Generation" {
                                HStack {
                                    TextField("Enter condition", text: $derelict.condition).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        derelict.condition = derelict.randomCondition()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if derelict.mode == "Selection" {
                                Picker(selection: $derelict.condition, label: EmptyView()) {
                                    ForEach(derelict.conditionList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //OUTER FIRST LOOK
                if derelict.outerFirstLook != "" {
                    Section(header:
                                HStack {
                                Text("Outer First Look").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenOuterFirstLook.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenOuterFirstLook ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenOuterFirstLook {
                            if derelict.mode == "Input" {
                                TextField("Enter outer first look", text: $derelict.outerFirstLook).focused($fieldIsFocused)
                            }
                            if derelict.mode == "Generation" {
                                HStack {
                                    TextField("Enter outer first look", text: $derelict.outerFirstLook).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        derelict.outerFirstLook = derelict.randomOuterFirstLook()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if derelict.mode == "Selection" {
                                Picker(selection: $derelict.outerFirstLook, label: EmptyView()) {
                                    ForEach(derelict.outerFirstLookList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                }
                //INNER FIRST LOOK
                if derelict.innerFirstLook != [] {
                    Section(header:
                                HStack {
                        Text("Inner First Look").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenInnerFirstLook.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenInnerFirstLook ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenInnerFirstLook {
                            if derelict.mode == "Input" {
                                ForEach($derelict.innerFirstLook) { $look in
                                    TextField("Enter inner first look", text: $look.name).focused($fieldIsFocused)
                                }.onDelete { (indexSet) in
                                    derelict.innerFirstLook.remove(atOffsets: indexSet)
                                }
                            }
                            if derelict.mode == "Generation" {
                                ForEach($derelict.innerFirstLook) { $look in
                                    HStack {
                                        TextField("Enter inner first look", text: $look.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            look.name = derelict.randomInnerFirstLook()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    derelict.innerFirstLook.remove(atOffsets: indexSet)
                                }
                            }
                            if derelict.mode == "Selection" {
                                ForEach($derelict.innerFirstLook) { $look in
                                    Picker(selection: $look.name, label: EmptyView()) {
                                        ForEach(derelict.innerFirstLookList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    derelict.innerFirstLook.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                //THEMES
                if derelict.theme != [] {
                    Section(header:
                                HStack {
                        Text("Themes").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenTheme.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenTheme ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenTheme {
                            if derelict.mode == "Generation" {
                                ForEach($derelict.theme) { $theme in
                                    HStack {
                                        Text(theme.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            theme.name = Theme.allCases.randomElement()!.rawValue
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    derelict.theme.remove(atOffsets: indexSet)
                                }
                            }
                            if derelict.mode == "Selection" || derelict.mode == "Input" {
                                ForEach($derelict.theme) { $theme in
                                    Picker(selection: $theme.name, label: EmptyView()) {
                                        ForEach(themeList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    derelict.theme.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                }
                //ROUTES
                if derelict.routes != [] {
                    Section(header:
                                HStack {
                        Text("Routes").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenRoutes.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenRoutes ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenRoutes {
                            ForEach($derelict.routes, id: \.id) { $route in
                                NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                    Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
                                }
                            }.onDelete { (indexSet) in
                                derelict.routes.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                //DESCRIPTION
                if derelict.description != "" {
                    Section(header:
                                HStack {
                        Text("Description").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenDescription.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenDescription ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenDescription {
                            TextEditor(text: $derelict.description)
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
                        if derelict.mode != "Input" {
                            Button {
                                derelict.mode = "Input"
                            } label: {
                                Text("Input")
                            }
                        }
                        if derelict.mode != "Selection" {
                            Button {
                                derelict.mode = "Selection"
                            } label: {
                                Text("Selection")
                            }
                        }
                        if derelict.mode != "Generation" {
                            Button {
                                derelict.mode = "Generation"
                            } label: {
                                Text("Generation")
                            }
                        }
                    } label: {
                        Text("Mode")
                    }
                    Button {
                        campaign.writeToFile()
                        generateDerilict()
                    } label: {
                        Text("Generate Derilict")
                    }
                    Menu {
                        if derelict.isChild == false && derelict.location == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.location = "Unknown"
                            } label: {
                                Text("Location")
                            }
                        }
                        if derelict.isChild == false && derelict.type == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.type = "Unknown"
                            } label: {
                                Text("Type")
                            }
                        }
                        if derelict.condition == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.condition = "Unknown"
                            } label: {
                                Text("Condition")
                            }
                        }
                        if derelict.outerFirstLook == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.outerFirstLook = "Unknown"
                            } label: {
                                Text("Outer First Look")
                            }
                        }
                        if derelict.innerFirstLook.count < 2 {
                            Button {
                                campaign.writeToFile()
                                derelict.innerFirstLook.insert(StringContainer(name: "Unknown"), at: 0)
                            } label: {
                                Text("Inner First Look")
                            }
                        }
                        Button {
                            campaign.writeToFile()
                            derelict.theme.insert(StringContainer(name: "None"), at: 0)
                        } label: {
                            Text("New Theme")
                        }
                        Button {
                            campaign.writeToFile()
                            derelict.routes.insert(Route(), at: 0)
                        } label: {
                            Text("New Route")
                        }
                        
                        if derelict.description == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.description = "New Description"
                            } label: {
                                Text("Description")
                            }
                        }
                        if derelict.subName == "" {
                            Button {
                                campaign.writeToFile()
                                derelict.subName = "Any Subtitle"
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
    }
    func generateDerilict() {
        derelict.location = derelict.randomLocation()
        derelict.type = derelict.randomType(location: derelict.location)
        derelict.condition = derelict.randomCondition()
        derelict.outerFirstLook = derelict.randomOuterFirstLook()
        derelict.hiddenInnerFirstLook = false
        derelict.innerFirstLook = []
        derelict.innerFirstLook.insert(StringContainer(), at: 0)
        derelict.innerFirstLook[0].name = derelict.randomInnerFirstLook()
    }
    
    func getThemes() -> [String] {
        var list = ["None"]
        for i in Theme.allCases {
            list.append(i.rawValue)
        }
        return list
    }
}

struct DerelictView_Previews: PreviewProvider {
    static var previews: some View {
        DerelictView(derelict: .constant(Derelict(isChild: false)), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
