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
    @State private var displayText = ""
    
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
            
            //TRAVEL BUTTONS
            if derelict.travelMode {
                VStack {
                    VStack {
                        if derelict.mode == "Generation" {
                            HStack {
                                Spacer()
                                Text("Zone: \(derelict.currentZone)")
                                    .font(.system(size: 30))
                                    .focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    derelict.currentZone = derelict.randomZone(type: derelict.type)
                                    derelict.currentArea = randomArea(zone: derelict.currentZone)
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                
                            }.padding(.horizontal)
                        }
                        if derelict.mode == "Selection" {
                            Menu {
                                Picker(selection: $derelict.currentZone) {
                                    ForEach(derelict.currentZoneList, id: \.self) { value in
                                        Text(value)
                                            .tag(value)
                                            
                                    }
                                } label: {}
                            } label: {
                                Text("Zone: \(derelict.currentZone)")
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    .padding(.vertical, 7)
                    VStack {
                        if derelict.mode == "Generation" {
                            HStack {
                                Spacer()
                                Text("Area: \(derelict.currentArea)")
                                    .font(.system(size: 20))
                                    .focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    derelict.currentArea = randomArea(zone: derelict.currentZone)
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                
                            }.padding(.horizontal)
                        }
                        if derelict.mode == "Selection" {
                            Menu {
                                Picker(selection: $derelict.currentArea) {
                                    ForEach(derelict.areaList, id: \.self) { value in
                                        Text(value)
                                            .tag(value)
                                            
                                    }
                                } label: {}
                            } label: {
                                Text("Zone: \(derelict.currentArea)")
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    .padding(.bottom, 17)
                    HStack(spacing: 15) {
                        Button {
                            displayText = "Feature: \(randomFeature(zone: derelict.currentZone))"
                        } label: {
                            Text("Derelict\n Feature")
                                .foregroundColor(.black)
                                .frame(width: 100)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        Button {
                            displayText = "Peril: \(randomPeril(zone: derelict.currentZone))"
                        } label: {
                            Text("Derelict\n Peril")
                                .frame(width: 100)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        Button {
                            displayText = "Opportunity: \(randomOpportunity(zone: derelict.currentZone))"
                        } label: {
                            Text("Derelict\n Opportunity")
                                .frame(width: 100)
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
                //RANK
                Section(header:
                            HStack {
                            Text("Rank").font(.title)
                    Spacer()
                    Button {
                        derelict.hiddenRank.toggle()
                    } label: {
                        Image(systemName: derelict.hiddenRank ? "chevron.down" : "chevron.right")
                    }
                }
                ) {
                    if derelict.hiddenRank {
                        if derelict.mode == "Generation" {
                            HStack {
                                Text(derelict.rank).focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    derelict.rank = Rank.allCases.randomElement()!.rawValue
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            }
                        }
                        if derelict.mode == "Selection" || derelict.mode == "Input" {
                            Picker(selection: $derelict.rank, label: EmptyView()) {
                                ForEach(Rank.allCases, id: \.self) { value in
                                    Text(value.rawValue).font(.system(size: 50))
                                        .tag(value)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }
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
                //WAYPOINTS
                if derelict.waypoints != [] {
                    Section(header:
                                HStack {
                        Text("Waypoints").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenWaypoints.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenWaypoints ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenWaypoints {
                            ForEach($derelict.waypoints, id: \.id) { $point in
                                NavigationLink(destination: DerelictView(derelict: $point, campaign: Campaign())) {
                                    Text("\(point.name)")
                                }
                            }.onDelete { (indexSet) in
                                derelict.waypoints.remove(atOffsets: indexSet)
                            }
                        }
                    }
                }
                //THEMES
                if derelict.themes != [] {
                    Section(header:
                                HStack {
                        Text("Themes").font(.title)
                        Spacer()
                        Button {
                            derelict.hiddenThemes.toggle()
                        } label: {
                            Image(systemName: derelict.hiddenThemes ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if derelict.hiddenThemes {
                            if derelict.mode == "Generation" {
                                ForEach($derelict.themes) { $theme in
                                    HStack {
                                        Text(theme.name).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            theme.name = derelict.oracle.randomTheme()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }.onDelete { (indexSet) in
                                    derelict.themes.remove(atOffsets: indexSet)
                                }
                            }
                            if derelict.mode == "Selection" || derelict.mode == "Input" {
                                ForEach($derelict.themes) { $theme in
                                    Picker(selection: $theme.name, label: EmptyView()) {
                                        ForEach(derelict.oracle.themeList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }.onDelete { (indexSet) in
                                    derelict.themes.remove(atOffsets: indexSet)
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
        //.navigationTitle(derelict.name)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide") {
                    fieldIsFocused = false
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Menu {
                    Toggle(isOn: $derelict.travelMode) {
                        Text("Travel Mode")
                    }
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
                        generateDerilict()
                        campaign.writeToFile()
                    } label: {
                        Text("Generate Derilict")
                    }
                    Menu {
                        if derelict.isChild == false && derelict.location == "" {
                            Button {
                                derelict.location = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Location")
                            }
                        }
                        if derelict.isChild == false && derelict.type == "" {
                            Button {
                                derelict.type = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Type")
                            }
                        }
                        if derelict.condition == "" {
                            Button {
                                derelict.condition = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Condition")
                            }
                        }
                        if derelict.outerFirstLook == "" {
                            Button {
                                derelict.outerFirstLook = "Unknown"
                                campaign.writeToFile()
                            } label: {
                                Text("Outer First Look")
                            }
                        }
                        if derelict.innerFirstLook.count < 2 {
                            Button {
                                derelict.innerFirstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("Inner First Look")
                            }
                        }
                        Button {
                            derelict.waypoints.insert(Derelict(isChild: true, location: derelict.location, type: derelict.type, name: "\(derelict.currentArea) of \(derelict.currentZone) Zone", rank: derelict.rank, themes: derelict.themes, currentZone: derelict.currentZone, currentArea: derelict.currentArea, areaList: derelict.areaList), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Waypoint")
                        }
                        Button {
                            derelict.themes.insert(StringContainer(name: "None"), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Theme")
                        }
                        Button {
                            derelict.routes.insert(Route(), at: 0)
                            campaign.writeToFile()
                        } label: {
                            Text("New Route")
                        }
                        
                        if derelict.description == "" {
                            Button {
                                derelict.description = "New Description"
                                campaign.writeToFile()
                            } label: {
                                Text("Description")
                            }
                        }
                        if derelict.subName == "" {
                            Button {
                                derelict.subName = "Any Subtitle"
                                campaign.writeToFile()
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
    
    func randomArea(zone: String) -> String {
        var area = ""
        
        switch zone {
        case "Access" :
            area = Derelict.randomAccessArea()
        case "Community" :
            area = derelict.randomCommunityArea()
        case "Engineering" :
            area = derelict.randomEngineeringArea()
        case "Living" :
            area = derelict.randomLivingArea()
        case "Medical" :
            area = derelict.randomMedicalArea()
        case "Operations" :
            area = derelict.randomOperationsArea()
        case "Production" :
            area = derelict.randomProductionArea()
        case "Research" :
            area = derelict.randomResearchArea()
        default:
            area = "ERROR"
        }
        return area
    }
    func randomFeature(zone: String) -> String {
        let zoneFeature = getZoneFeature(zone: zone)
        let themeFeature = getThemesFeature()

        func getZoneFeature(zone: String) -> String {
            var featureList: [String] = []
            switch zone {
            case "Access" :
                featureList.insert(derelict.randomAccessFeature(), at: 0)
            case "Community" :
                featureList.insert(derelict.randomResearchFeature(), at: 0)
            case "Engineering" :
                featureList.insert(derelict.randomEngineeringFeature(), at: 0)
            case "Living" :
                featureList.insert(derelict.randomLivingFeature(), at: 0)
            case "Medical" :
                featureList.insert(derelict.randomMedicalFeature(), at: 0)
            case "Operations" :
                featureList.insert(derelict.randomOperationsFeature(), at: 0)
            case "Production" :
                featureList.insert(derelict.randomProductionFeature(), at: 0)
            case "Research" :
                featureList.insert(derelict.randomResearchFeature(), at: 0)
            default:
                featureList.insert("", at: 0)
            }
            var answer = featureList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getThemesFeature() -> String {
            var featureList: [String] = []
            if derelict.themes.count != 0 {
                for theme in derelict.themes {
                    switch theme.name {
                    case "Chaotic" :
                        featureList.insert(derelict.oracle.chaoticThemeFeatureSF(), at: 0)
                    case "Fortified" :
                        featureList.insert(derelict.oracle.fortifiedThemeFeatureSF(), at: 0)
                    case "Haunted" :
                        featureList.insert(derelict.oracle.hauntedThemeFeatureSF(), at: 0)
                    case "Infested" :
                        featureList.insert(derelict.oracle.infestedThemeFeatureSF(), at: 0)
                    case "Inhabited" :
                        featureList.insert(derelict.oracle.inhabitedThemeFeatureSF(), at: 0)
                    case "Mechanical" :
                        featureList.insert(derelict.oracle.mechanicalThemeFeatureSF(), at: 0)
                    case "Ruined" :
                        featureList.insert(derelict.oracle.ruinedThemeFeatureSF(), at: 0)
                    case "Sacred" :
                        featureList.insert(derelict.oracle.sacredThemeFeatureSF(), at: 0)
                    default:
                        featureList.insert("", at: 0)
                    }
                }
            }
            var answer = featureList.shuffled()
            return answer.popLast() ?? "error"
        }
        
        var pool: [String] = []

        for _ in 1...3 {
            pool.append(zoneFeature)
        }

        if derelict.themes != [] {
            for _ in 1...3 {
                pool.append(themeFeature)
            }
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
    func randomPeril(zone: String) -> String {
        let zonePeril = getZonePeril(zone: zone)
        let themePril = getThemesPeril()
        let thePrice = derelict.oracle.payThePrice()
        func getThemesPeril() -> String {
            var perilList: [String] = []
            if derelict.themes.count != 0 {
                for theme in derelict.themes {
                    switch theme.name {
                    case "Chaotic" :
                        perilList.insert(derelict.oracle.chaoticThemePerilSF(), at: 0)
                    case "Fortified" :
                        perilList.insert(derelict.oracle.fortifiedThemePerilSF(), at: 0)
                    case "Haunted" :
                        perilList.insert(derelict.oracle.hauntedThemePerilSF(), at: 0)
                    case "Infested" :
                        perilList.insert(derelict.oracle.infestedThemePerilSF(), at: 0)
                    case "Inhabited" :
                        perilList.insert(derelict.oracle.inhabitedThemePerilSF(), at: 0)
                    case "Mechanical" :
                        perilList.insert(derelict.oracle.mechanicalThemePerilSF(), at: 0)
                    case "Ruined" :
                        perilList.insert(derelict.oracle.ruinedThemePerilSF(), at: 0)
                    case "Sacred" :
                        perilList.insert(derelict.oracle.sacredThemePerilSF(), at: 0)
                    default:
                        perilList.insert(derelict.randomAccessPeril(), at: 0)
                    }
                }
            }
            var answer = perilList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getZonePeril(zone: String) -> String {
            var peril = ""
            switch zone {
            case "Access" :
                peril = derelict.randomAccessPeril()
            case "Community" :
                peril = derelict.randomCommunityPeril()
            case "Engineering" :
                peril = derelict.randomEngineeringPeril()
            case "Living" :
                peril = derelict.randomLivingPeril()
            case "Medical" :
                peril = derelict.randomMedicalPeril()
            case "Operations" :
                peril = derelict.randomOperationsPeril()
            case "Production" :
                peril = derelict.randomProductionPeril()
            case "Research" :
                peril = derelict.randomResearchPeril()
            default:
                peril = "ERROR"
            }
            return peril
        }
        
        var pool: [String] = []

        for _ in 1...3 {
            pool.append(zonePeril)
        }
        pool.append(thePrice)
        if derelict.themes != [] {
            for _ in 1...3 {
                pool.append(themePril)
            }
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
    func randomOpportunity(zone: String) -> String {
        let zoneOpportunity = getZoneOpportunity(zone: zone)
        let themeOpportunity = getThemesOpportunity()
        func getThemesOpportunity() -> String {
            var opportunityList: [String] = []
            if derelict.themes.count != 0 {
                for theme in derelict.themes {
                    switch theme.name {
                    case "Chaotic" :
                        opportunityList.insert(derelict.oracle.chaoticThemeOpportunitySF(), at: 0)
                    case "Fortified" :
                        opportunityList.insert(derelict.oracle.fortifiedThemeOpportunitySF(), at: 0)
                    case "Haunted" :
                        opportunityList.insert(derelict.oracle.hauntedThemeOpportunitySF(), at: 0)
                    case "Infested" :
                        opportunityList.insert(derelict.oracle.infestedThemeOpportunitySF(), at: 0)
                    case "Inhabited" :
                        opportunityList.insert(derelict.oracle.inhabitedThemeOpportunitySF(), at: 0)
                    case "Mechanical" :
                        opportunityList.insert(derelict.oracle.mechanicalThemeOpportunitySF(), at: 0)
                    case "Ruined" :
                        opportunityList.insert(derelict.oracle.ruinedThemeOpportunitySF(), at: 0)
                    case "Sacred" :
                        opportunityList.insert(derelict.oracle.sacredThemeOpportunitySF(), at: 0)
                    default:
                        opportunityList.insert(derelict.randomAccessOpportunity(), at: 0)
                    }
                }
            }
            var answer = opportunityList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getZoneOpportunity(zone: String) -> String {
            var opportunity = ""
            switch zone {
            case "Access" :
                opportunity = derelict.randomAccessOpportunity()
            case "Community" :
                opportunity = derelict.randomCommunityOpportunity()
            case "Engineering" :
                opportunity = derelict.randomEngineeringOpportunity()
            case "Living" :
                opportunity = derelict.randomLivingOpportunity()
            case "Medical" :
                opportunity = derelict.randomMedicalOpportunity()
            case "Operations" :
                opportunity = derelict.randomOperationsOpportunity()
            case "Production" :
                opportunity = derelict.randomProductionOpportunity()
            case "Research" :
                opportunity = derelict.randomResearchOpportunity()
            default:
                opportunity = "ERROR"
            }
            return opportunity
        }
        var pool: [String] = []

        for _ in 1...3 {
            pool.append(zoneOpportunity)
        }
        //pool.append(thePrice)
        if derelict.themes != [] {
            for _ in 1...3 {
                pool.append(themeOpportunity)
            }
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
}

struct DerelictView_Previews: PreviewProvider {
    static var previews: some View {
        DerelictView(derelict: .constant(Derelict(isChild: false)), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
