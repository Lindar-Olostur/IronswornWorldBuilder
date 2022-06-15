//
//  PrecursorVaultsView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 30.05.2022.
//

import SwiftUI

struct PrecursorVaultsView: View {
    @Binding var vault: PrecursorVaults
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    
    var body: some View {
        VStack(alignment: .leading) {

            VStack {
                TextField("Enter precursor vaults name", text: $vault.name).font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .focused($fieldIsFocused)
                if vault.subName != "" {
                    TextField("Another precursor vaults info", text: $vault.subName)
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
            }

            HStack {
                Spacer()
                if vault.mode == "Selection" {
                    Menu {
                        Picker(selection: $vault.currentZone) {
                            ForEach(vault.currentZoneList, id: \.self) { value in
                                Text(value)
                                    .tag(value)
                                    
                            }
                        } label: {}
                    } label: {
                        Text("Zone: \(vault.currentZone)")
                            .font(.system(size: 30))
                    }
                } else {
                    Text("Zone: \(vault.currentZone)")
                        .font(.system(size: 30))
                }
                Spacer()
            }
            //TRAVEL BUTTONS
            if vault.travelMode {
                VStack {
                    
                    HStack(spacing: 15) {
                        Button {
                            displayText = "Feature: \(randomFeature(zone: vault.currentZone))"
                        } label: {
                            Text("Derelict\n Feature")
                                .foregroundColor(.black)
                                .frame(width: 100)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        Button {
                            displayText = "Peril: \(randomPeril(zone: vault.currentZone))"
                        } label: {
                            Text("Derelict\n Peril")
                                .frame(width: 100)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        Button {
                            displayText = "Opportunity: \(randomOpportunity(zone: vault.currentZone))"
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
                Group {
                    //LOCATION
                    Section(header:
                                HStack {
                                Text("Location").font(.title)
                        Spacer()
                        Button {
                            vault.hiddenLocation.toggle()
                        } label: {
                            Image(systemName: vault.hiddenLocation ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if vault.hiddenLocation {
                            if vault.mode == "Input" {
                                Text(vault.location)
                            }
                            if vault.mode == "Generation" {
                                HStack {
                                    Text(vault.location)
                                    Spacer()
                                    Button {
                                        vault.location = vault.randomLocation()
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if vault.mode == "Selection" {
                                Picker(selection: $vault.location, label: EmptyView()) {
                                    ForEach(vault.locationList, id: \.self) { value in
                                        Text(value).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                   // RANK
                    Section(header:
                                HStack {
                                Text("Rank").font(.title)
                        Spacer()
                        Button {
                            vault.hiddenRank.toggle()
                        } label: {
                            Image(systemName: vault.hiddenRank ? "chevron.down" : "chevron.right")
                        }
                    }
                    ) {
                        if vault.hiddenRank {
                            if vault.mode == "Generation" {
                                HStack {
                                    Text(vault.rank).focused($fieldIsFocused)
                                    Spacer()
                                    Button {
                                        vault.rank = Rank.allCases.randomElement()!.rawValue
                                    } label: {
                                        Image(systemName: "dice").font(.system(size: 20))
                                    }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                }
                            }
                            if vault.mode == "Selection" || vault.mode == "Input" {
                                Picker(selection: $vault.rank, label: EmptyView()) {
                                    ForEach(Rank.allCases, id: \.self) { value in
                                        Text(value.rawValue).font(.system(size: 50))
                                            .tag(value)
                                    }
                                }.pickerStyle(.menu)
                            }
                        }
                    }
                    //SCALE
                    if vault.scale != "" {
                        Section(header:
                                    HStack {
                                    Text("Scale").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenScale.toggle()
                            } label: {
                                Image(systemName: vault.hiddenScale ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenScale {
                                if vault.mode == "Input" {
                                    TextField("Enter scale", text: $vault.scale).focused($fieldIsFocused)
                                }
                                if vault.mode == "Generation" {
                                    HStack {
                                        TextField("Enter scale", text: $vault.scale).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            vault.scale = vault.randomScale()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if vault.mode == "Selection" {
                                    Picker(selection: $vault.scale, label: EmptyView()) {
                                        ForEach(vault.scaleList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //FORM
                    if vault.form != "" {
                        Section(header:
                                    HStack {
                                    Text("Form").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenForm.toggle()
                            } label: {
                                Image(systemName: vault.hiddenForm ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenForm {
                                if vault.mode == "Input" {
                                    TextField("Enter form", text: $vault.form).focused($fieldIsFocused)
                                }
                                if vault.mode == "Generation" {
                                    HStack {
                                        TextField("Enter form", text: $vault.form).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            vault.form = vault.randomForm()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if vault.mode == "Selection" {
                                    Picker(selection: $vault.form, label: EmptyView()) {
                                        ForEach(vault.formList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //SHAPE
                    if vault.shape != "" {
                        Section(header:
                                    HStack {
                                    Text("Shape").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenShape.toggle()
                            } label: {
                                Image(systemName: vault.hiddenShape ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenShape {
                                if vault.mode == "Input" {
                                    TextField("Enter shape", text: $vault.shape).focused($fieldIsFocused)
                                }
                                if vault.mode == "Generation" {
                                    HStack {
                                        TextField("Enter shape", text: $vault.shape).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            vault.shape = vault.randomShape()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if vault.mode == "Selection" {
                                    Picker(selection: $vault.shape, label: EmptyView()) {
                                        ForEach(vault.shapeList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //MATERIAL
                    if vault.material != "" {
                        Section(header:
                                    HStack {
                                    Text("Material").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenMaterial.toggle()
                            } label: {
                                Image(systemName: vault.hiddenMaterial ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenMaterial {
                                if vault.mode == "Input" {
                                    TextField("Enter form", text: $vault.material).focused($fieldIsFocused)
                                }
                                if vault.mode == "Generation" {
                                    HStack {
                                        TextField("Enter form", text: $vault.material).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            vault.material = vault.randomMaterial()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if vault.mode == "Selection" {
                                    Picker(selection: $vault.material, label: EmptyView()) {
                                        ForEach(vault.materialList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    //OUTER FIRST LOOK
                    if vault.outerFirstLook != [] && vault.currentZone == "Exterior" {
                        Section(header:
                                    HStack {
                            Text("Outer First Look").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenOuterFirstLook.toggle()
                            } label: {
                                Image(systemName: vault.hiddenOuterFirstLook ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenOuterFirstLook {
                                if vault.mode == "Input" {
                                    ForEach($vault.outerFirstLook) { $look in
                                        TextField("Enter outer first look", text: $look.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        vault.outerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if vault.mode == "Generation" {
                                    ForEach($vault.outerFirstLook) { $look in
                                        HStack {
                                            TextField("Enter outer first look", text: $look.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                look.name = vault.randomOuterFirstLook()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        vault.outerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if vault.mode == "Selection" {
                                    ForEach($vault.outerFirstLook) { $look in
                                        Picker(selection: $look.name, label: EmptyView()) {
                                            ForEach(vault.outerFirstLookList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        vault.outerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //INNER FIRST LOOK
                    if vault.innerFirstLook != [] && vault.currentZone == "Interior" {
                        Section(header:
                                    HStack {
                            Text("Inner First Look").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenInnerFirstLook.toggle()
                            } label: {
                                Image(systemName: vault.hiddenInnerFirstLook ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenInnerFirstLook {
                                if vault.mode == "Input" {
                                    ForEach($vault.innerFirstLook) { $look in
                                        TextField("Enter inner first look", text: $look.name).focused($fieldIsFocused)
                                    }.onDelete { (indexSet) in
                                        vault.innerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if vault.mode == "Generation" {
                                    ForEach($vault.innerFirstLook) { $look in
                                        HStack {
                                            TextField("Enter inner first look", text: $look.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                look.name = vault.randomInnerFirstLook()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        vault.innerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                                if vault.mode == "Selection" {
                                    ForEach($vault.innerFirstLook) { $look in
                                        Picker(selection: $look.name, label: EmptyView()) {
                                            ForEach(vault.innerFirstLookList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        vault.innerFirstLook.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //PURPOSE
                    if vault.vaultPurpose != "" && vault.currentZone == "Interior" {
                        Section(header:
                                    HStack {
                                    Text("Vault Purpose").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenVaultPurpose.toggle()
                            } label: {
                                Image(systemName: vault.hiddenVaultPurpose ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenVaultPurpose {
                                if vault.mode == "Input" {
                                    TextField("Enter purpose", text: $vault.vaultPurpose).focused($fieldIsFocused)
                                }
                                if vault.mode == "Generation" {
                                    HStack {
                                        TextField("Enter purpose", text: $vault.vaultPurpose).focused($fieldIsFocused)
                                        Spacer()
                                        Button {
                                            vault.vaultPurpose = vault.randomPurpose()
                                        } label: {
                                            Image(systemName: "dice").font(.system(size: 20))
                                        }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                    }
                                }
                                if vault.mode == "Selection" {
                                    Picker(selection: $vault.vaultPurpose, label: EmptyView()) {
                                        ForEach(vault.purposeList, id: \.self) { value in
                                            Text(value).font(.system(size: 50))
                                                .tag(value)
                                        }
                                    }.pickerStyle(.menu)
                                }
                            }
                        }
                    }
                    
                }
                Group {
                    //WAYPOINTS
                    if vault.waypoints != [] {
                        Section(header:
                                    HStack {
                            Text("Waypoints").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenWaypoints.toggle()
                            } label: {
                                Image(systemName: vault.hiddenWaypoints ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenWaypoints {
                                ForEach($vault.waypoints, id: \.id) { $point in
                                    NavigationLink(destination: PrecursorVaultsView(vault: $point, campaign: Campaign())) {
                                        Text("\(point.currentZone) of \(point.name)")
                                    }
                                }.onDelete { (indexSet) in
                                    vault.waypoints.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }

                    //THEMES
                    if vault.themes != [] {
                        Section(header:
                                    HStack {
                            Text("Themes").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenThemes.toggle()
                            } label: {
                                Image(systemName: vault.hiddenThemes ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenThemes {
                                if vault.mode == "Generation" {
                                    ForEach($vault.themes) { $theme in
                                        HStack {
                                            Text(theme.name).focused($fieldIsFocused)
                                            Spacer()
                                            Button {
                                                theme.name = vault.oracle.randomTheme()
                                            } label: {
                                                Image(systemName: "dice").font(.system(size: 20))
                                            }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                                        }
                                    }.onDelete { (indexSet) in
                                        vault.themes.remove(atOffsets: indexSet)
                                    }
                                }
                                if vault.mode == "Selection" || vault.mode == "Input" {
                                    ForEach($vault.themes) { $theme in
                                        Picker(selection: $theme.name, label: EmptyView()) {
                                            ForEach(vault.oracle.themeList, id: \.self) { value in
                                                Text(value).font(.system(size: 50))
                                                    .tag(value)
                                            }
                                        }.pickerStyle(.menu)
                                    }.onDelete { (indexSet) in
                                        vault.themes.remove(atOffsets: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    //ROUTES
                    if vault.routes != [] {
                        Section(header:
                                    HStack {
                            Text("Routes").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenRoutes.toggle()
                            } label: {
                                Image(systemName: vault.hiddenRoutes ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenRoutes {
                                ForEach($vault.routes, id: \.id) { $route in
                                    NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                        Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
                                    }
                                }.onDelete { (indexSet) in
                                    vault.routes.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    //DESCRIPTION
                    if vault.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                vault.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: vault.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if vault.hiddenDescription {
                                TextEditor(text: $vault.description)
                                    .focused($fieldIsFocused)
                            }
                        }
                    }
                }
            }.listStyle(.inset)
        }
        //.navigationTitle(vault.name)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide") {
                    fieldIsFocused = false
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Menu {
                    if vault.currentZone == "Interior" || vault.currentZone == "Sanctum" {
                        Toggle(isOn: $vault.travelMode) {
                            Text("Travel Mode")
                        }
                    }
                    Menu {
                        if vault.mode != "Input" {
                            Button {
                                vault.mode = "Input"
                            } label: {
                                Text("Input")
                            }
                        }
                        if vault.mode != "Selection" {
                            Button {
                                vault.mode = "Selection"
                            } label: {
                                Text("Selection")
                            }
                        }
                        if vault.mode != "Generation" {
                            Button {
                                vault.mode = "Generation"
                            } label: {
                                Text("Generation")
                            }
                        }
                    } label: {
                        Text("Mode")
                    }
                    Button {
                        generateVault()
                        campaign.writeToFile()
                    } label: {
                        Text("Generate Precursor Vault")
                    }
                    Menu {
                        Group {
                            if vault.scale == "" {
                                Button {
                                    vault.scale = "Unknown"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Scale")
                                }
                            }
                            if vault.form == "" {
                                Button {
                                    vault.form = "Unknown"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Form")
                                }
                            }
                            if vault.shape == "" {
                                Button {
                                    vault.shape = "Unknown"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Shape")
                                }
                            }
                            if vault.material == "" {
                                Button {
                                    vault.material = "Unknown"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Material")
                                }
                            }
                            if vault.outerFirstLook.count < 2 && vault.currentZone == "Exterior" {
                                Button {
                                    vault.outerFirstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Outer First Look")
                                }
                            }
                            if vault.innerFirstLook.count < 2 && vault.currentZone == "Interior" {
                                Button {
                                    vault.innerFirstLook.insert(StringContainer(name: "Unknown"), at: 0)
                                    campaign.writeToFile()
                                } label: {
                                    Text("Inner First Look")
                                }
                            }
                            if vault.vaultPurpose == "" && vault.currentZone == "Interior" {
                                Button {
                                    vault.vaultPurpose = "Unknown"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Vault Purpose")
                                }
                            }
                        }
                        Group {
                            Button {
                                vault.waypoints.insert(PrecursorVaults(name: vault.name, location: vault.location, rank: vault.rank, scale: vault.scale, form: vault.form, shape: vault.shape, material: vault.material, themes: vault.themes, currentZone: vault.currentZone), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Waypoint")
                            }
                            Button {
                                vault.themes.insert(StringContainer(name: "None"), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Theme")
                            }
                            Button {
                                vault.routes.insert(Route(), at: 0)
                                campaign.writeToFile()
                            } label: {
                                Text("New Route")
                            }

                            if vault.description == "" {
                                Button {
                                    vault.description = "New Description"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Description")
                                }
                            }
                            if vault.subName == "" {
                                Button {
                                    vault.subName = "Any Subtitle"
                                    campaign.writeToFile()
                                } label: {
                                    Text("Subtitle")
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
    func generateVault() {
        vault.location = vault.randomLocation()
        vault.scale = vault.randomScale()
        vault.form = vault.randomForm()
        vault.shape = vault.randomShape()
        vault.material = vault.randomMaterial()

        vault.hiddenOuterFirstLook = false
        vault.outerFirstLook = []
        let howManyOuterFirstLook = Int.random(in: 0...3)
        if howManyOuterFirstLook > 0 {
            vault.outerFirstLook.insert(StringContainer(), at: 0)
            vault.outerFirstLook[0].name = vault.randomOuterFirstLook()
        } else {
            vault.outerFirstLook.insert(StringContainer(), at: 0)
            vault.outerFirstLook[0].name = vault.randomOuterFirstLook()
            vault.outerFirstLook.insert(StringContainer(), at: 0)
            vault.outerFirstLook[0].name = vault.randomOuterFirstLook()
        }

        vault.hiddenInnerFirstLook = false
        vault.innerFirstLook = []
        let howManyInnerFirstLook = Int.random(in: 0...3)
        if howManyInnerFirstLook > 0 {
            vault.innerFirstLook.insert(StringContainer(), at: 0)
            vault.innerFirstLook[0].name = vault.randomInnerFirstLook()
        } else {
            vault.innerFirstLook.insert(StringContainer(), at: 0)
            vault.innerFirstLook[0].name = vault.randomInnerFirstLook()
            vault.innerFirstLook.insert(StringContainer(), at: 0)
            vault.innerFirstLook[0].name = vault.randomInnerFirstLook()
        }
        vault.vaultPurpose = vault.randomPurpose()
    }

    func randomFeature(zone: String) -> String {
        let zoneFeature = getZoneFeature(zone: zone)
        let themeFeature = getThemesFeature()

        func getZoneFeature(zone: String) -> String {
            var featureList: [String] = []
            switch zone {
            case "Interior" :
                featureList.insert(vault.randomInteriorFeature(), at: 0)
            case "Sanctum" :
                featureList.insert(vault.randomSanctumFeature(), at: 0)
            default:
                featureList.insert("no zone", at: 0)
            }
            var answer = featureList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getThemesFeature() -> String {
            var featureList: [String] = []
            if vault.themes.count != 0 {
                for theme in vault.themes {
                    switch theme.name {
                    case "Chaotic" :
                        featureList.insert(vault.oracle.chaoticThemeFeatureSF(), at: 0)
                    case "Fortified" :
                        featureList.insert(vault.oracle.fortifiedThemeFeatureSF(), at: 0)
                    case "Haunted" :
                        featureList.insert(vault.oracle.hauntedThemeFeatureSF(), at: 0)
                    case "Infested" :
                        featureList.insert(vault.oracle.infestedThemeFeatureSF(), at: 0)
                    case "Inhabited" :
                        featureList.insert(vault.oracle.inhabitedThemeFeatureSF(), at: 0)
                    case "Mechanical" :
                        featureList.insert(vault.oracle.mechanicalThemeFeatureSF(), at: 0)
                    case "Ruined" :
                        featureList.insert(vault.oracle.ruinedThemeFeatureSF(), at: 0)
                    case "Sacred" :
                        featureList.insert(vault.oracle.sacredThemeFeatureSF(), at: 0)
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

        if vault.themes != [] {
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
        let thePrice = vault.oracle.payThePrice()
        func getThemesPeril() -> String {
            var perilList: [String] = []
            if vault.themes.count != 0 {
                for theme in vault.themes {
                    switch theme.name {
                    case "Chaotic" :
                        perilList.insert(vault.oracle.chaoticThemePerilSF(), at: 0)
                    case "Fortified" :
                        perilList.insert(vault.oracle.fortifiedThemePerilSF(), at: 0)
                    case "Haunted" :
                        perilList.insert(vault.oracle.hauntedThemePerilSF(), at: 0)
                    case "Infested" :
                        perilList.insert(vault.oracle.infestedThemePerilSF(), at: 0)
                    case "Inhabited" :
                        perilList.insert(vault.oracle.inhabitedThemePerilSF(), at: 0)
                    case "Mechanical" :
                        perilList.insert(vault.oracle.mechanicalThemePerilSF(), at: 0)
                    case "Ruined" :
                        perilList.insert(vault.oracle.ruinedThemePerilSF(), at: 0)
                    case "Sacred" :
                        perilList.insert(vault.oracle.sacredThemePerilSF(), at: 0)
                    default:
                        perilList = []
                    }
                }
            }
            var answer = perilList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getZonePeril(zone: String) -> String {
            var peril = ""
            switch zone {
            case "Interior" :
                peril = vault.randomInteriorPeril()
            case "Sanctum" :
                peril = vault.randomSanctumPeril()
            default:
                peril = "no zone"
            }
            return peril
        }

        var pool: [String] = []

        for _ in 1...5 {
            pool.append(zonePeril)
        }
        pool.append(thePrice)
        if vault.themes != [] {
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
            if vault.themes.count != 0 {
                for theme in vault.themes {
                    switch theme.name {
                    case "Chaotic" :
                        opportunityList.insert(vault.oracle.chaoticThemeOpportunitySF(), at: 0)
                    case "Fortified" :
                        opportunityList.insert(vault.oracle.fortifiedThemeOpportunitySF(), at: 0)
                    case "Haunted" :
                        opportunityList.insert(vault.oracle.hauntedThemeOpportunitySF(), at: 0)
                    case "Infested" :
                        opportunityList.insert(vault.oracle.infestedThemeOpportunitySF(), at: 0)
                    case "Inhabited" :
                        opportunityList.insert(vault.oracle.inhabitedThemeOpportunitySF(), at: 0)
                    case "Mechanical" :
                        opportunityList.insert(vault.oracle.mechanicalThemeOpportunitySF(), at: 0)
                    case "Ruined" :
                        opportunityList.insert(vault.oracle.ruinedThemeOpportunitySF(), at: 0)
                    case "Sacred" :
                        opportunityList.insert(vault.oracle.sacredThemeOpportunitySF(), at: 0)
                    default:
                        opportunityList = []
                    }
                }
            }
            var answer = opportunityList.shuffled()
            return answer.popLast() ?? "error"
        }
        func getZoneOpportunity(zone: String) -> String {
            var opportunity = ""
            switch zone {
            case "Interior" :
                opportunity = vault.randomInteriorOpportunity()
            case "Sanctum" :
                opportunity = vault.randomSanctumOpportunity()
            default:
                opportunity = "no zone"
            }
            return opportunity
        }
        var pool: [String] = []

        for _ in 1...3 {
            pool.append(zoneOpportunity)
        }
        //pool.append(thePrice)
        if vault.themes != [] {
            for _ in 1...3 {
                pool.append(themeOpportunity)
            }
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
}

struct PrecursorVaultsView_Previews: PreviewProvider {
    static var previews: some View {
        PrecursorVaultsView(vault: .constant(PrecursorVaults()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
