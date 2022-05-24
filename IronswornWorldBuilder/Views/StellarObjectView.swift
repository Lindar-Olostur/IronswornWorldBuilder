//
//  StellarObjectView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct StellarObjectView: View {
    @Binding var stellarObject: StellarObject
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Enter Stellar Object name", text: $stellarObject.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                }
                
                
               
                List {
                    //TYPE
                    Section(header: Text("Type").font(.title)) {
                        if stellarObject.mode == "Input" {
                            TextField("Enter Stellar Object class", text: $stellarObject.type).focused($fieldIsFocused)
                        }
                        if stellarObject.mode == "Generation" {
                            HStack {
                                TextField("Enter Stellar Object class", text: $stellarObject.type).focused($fieldIsFocused)
                                Spacer()
                                Button {
                                    stellarObject.type = stellarObject.randomType()
                                } label: {
                                    Image(systemName: "dice").font(.system(size: 20))
                                }.transition(AnyTransition.opacity.animation(.easeInOut(duration:0.6)))
                            }
                        }
                        if stellarObject.mode == "Selection" {
                            Picker(selection: $stellarObject.type, label: EmptyView()) {
                                ForEach(stellarObject.typeList, id: \.self) { value in
                                    Text(value).font(.system(size: 50))
                                        .tag(value)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                    
                    //PLANETS
                    if stellarObject.planets != [] {
                        Section(header:
                                    HStack {
                            Text("Planets").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenPlanets.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenPlanets ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenPlanets {
                                ForEach($stellarObject.planets, id: \.id) { $planet in
                                        NavigationLink(destination: PlanetView(planet: $planet, campaign: self.campaign)) {
                                            Text(planet.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.planets.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //SETTLEMENTS
                    if stellarObject.settlements != [] {
                        Section(header:
                                    HStack {
                            Text("Settlements").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenSettlements.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenSettlements ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenSettlements {
                                ForEach($stellarObject.settlements, id: \.id) { $settlement in
                                    NavigationLink(destination: SettlementView(settlement: $settlement, campaign: self.campaign)) {
                                        Text(settlement.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.settlements.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //ROUTES
                    if stellarObject.routes != [] {
                        Section(header:
                                    HStack {
                            Text("Routes").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenRoutes.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenRoutes ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenRoutes {
                                ForEach($stellarObject.routes, id: \.id) { $route in
                                    NavigationLink(destination: RouteView(route: $route, campaign: Campaign())) {
                                        Text("\(route.rank.rawValue.capitalized) route to \(route.destination)")
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.routes.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }

                    //LOCATION
                    if stellarObject.locations != [] {
                        Section(header:
                                    HStack {
                            Text("Locations").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenLocations.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenLocations ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenLocations {
                                ForEach($stellarObject.locations, id: \.id) { $location in
                                    NavigationLink(destination: LocationView()) {
                                        Text(location.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.locations.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //CREATURE
                    if stellarObject.creatures != [] {
                        Section(header:
                                    HStack {
                            Text("Creatures").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenCreatures.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenCreatures ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenCreatures {
                                ForEach($stellarObject.creatures, id: \.id) { $creature in
                                    NavigationLink(destination: CreatureView(creature: $creature, campaign: Campaign())) {
                                        Text(creature.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.creatures.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //VEHICLE
                    if stellarObject.vehicles != [] {
                        Section(header:
                                    HStack {
                            Text("Starships").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenVehicles.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenVehicles ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenVehicles {
                                ForEach($stellarObject.vehicles, id: \.id) { $vehicle in
                                    NavigationLink(destination: StarshipView(starship: $vehicle, campaign: Campaign())) {
                                        Text(vehicle.name)
                                    }
                                }.onDelete { (indexSet) in
                                    stellarObject.vehicles.remove(atOffsets: indexSet)
                                }
                            }
                        }
                    }
                    
                    //DESCRIPTION
                    if stellarObject.description != "" {
                        Section(header:
                                    HStack {
                            Text("Description").font(.title)
                            Spacer()
                            Button {
                                stellarObject.hiddenDescription.toggle()
                            } label: {
                                Image(systemName: stellarObject.hiddenDescription ? "chevron.down" : "chevron.right")
                            }
                        }
                        ) {
                            if stellarObject.hiddenDescription {
                                TextEditor(text: $stellarObject.description)
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
                            if stellarObject.mode != "Input" {
                                Button {
                                    stellarObject.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if stellarObject.mode != "Selection" {
                                Button {
                                    stellarObject.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if stellarObject.mode != "Generation" {
                                Button {
                                    stellarObject.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Text("Mode")
                        }
                        
                        
                        if stellarObject.description == "" {
                            Button {
                                campaign.writeToFile()
                                stellarObject.description = " "
                            } label: {
                                Text("Description")
                            }
                        }

                        Button {
                            campaign.writeToFile()
                            stellarObject.planets.insert(Planet(homeSector: stellarObject.homeSector, homeStar: stellarObject.name, name: stellarObject.randomPlanetName()), at: 0)
                        } label: {
                            Text("Add Planet")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            stellarObject.settlements.insert(Settlement(homeSector: stellarObject.homeSector), at: 0)
                        } label: {
                            Text("Add Settlement")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            stellarObject.locations.insert(Location(name: "Unknown Location"), at: 0)
                        } label: {
                            Text("Add Location")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            stellarObject.creatures.insert(Creature(homeSector: stellarObject.homeSector, name: "Unknown Creature"), at: 0)
                        } label: {
                            Text("Add Creature")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            stellarObject.vehicles.insert(Starship(name: "Unknown Starship", homeSector: stellarObject.homeSector), at: 0)
                        } label: {
                            Text("Add Starship")
                        }
                        
                        Button {
                            campaign.writeToFile()
                            stellarObject.routes.insert(Route(), at: 0)
                        } label: {
                            Text("Add Route")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct StellarObjectView_Previews: PreviewProvider {
    static var previews: some View {
        StellarObjectView(stellarObject: .constant(StellarObject()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
