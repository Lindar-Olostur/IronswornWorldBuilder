//
//  RootView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var campaign: Campaign// = Campaign()
    @State private var openedLoadView = false
    @State private var openedFirstLaunchView = false
    @State private var isShowingRegionView = false
    @FocusState private var fieldIsFocused: Bool
    @State private var displayText = ""
    var buffer = movingBuffer.shared
    init() {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.clear]
        }
    
    var body: some View {
        NavigationView {
            if UserDefaults.standard.value(forKey: "isNotFirstLaunch") != nil {
                VStack(alignment: .leading) {
                    
                    VStack {
                        TextField("Enter Campaign name", text: $campaign.world.name).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        TextField("Another campaign info", text: $campaign.world.subName)
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                    }
                    //STORY BUTTONS
                    if campaign.world.storyGenerator {
                        VStack {
                            HStack(spacing: 15) {
                                Button {
                                    displayText = randomStory()
                                } label: {
                                    Text("Generate Story")
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
                                                .padding(.horizontal, 7)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                            .padding(.top, 5)
                            .frame(minHeight: 40)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    List {
                        // REGIONS
                        if campaign.world.regions != [] {
                            Section(header:
                                        HStack {
                                Text("Regions").font(.title)
                                Spacer()
                                Button {
                                    campaign.world.hiddenRegions.toggle()
                                } label: {
                                    Image(systemName: campaign.world.hiddenRegions ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if campaign.world.hiddenRegions {
                                    ForEach($campaign.world.regions, id: \.id) { $region in
                                       NavigationLink(destination: RegionView(region: $region, campaign: self.campaign)) {
                                           Text(region.name)
                                       }
                                   }.onDelete { (indexSet) in
                                       campaign.world.regions.remove(atOffsets: indexSet)
                                   }
                                }
                            }
                        }
    //                    // FACTIONS
    //                    if campaign.world.factions != [] {
    //                        Section(header:
    //                                    HStack {
    //                            Text("Factions").font(.title)
    //                            Spacer()
    //                            Button {
    //                                campaign.world.hiddenFactions.toggle()
    //                            } label: {
    //                                Image(systemName: campaign.world.hiddenFactions ? "chevron.down" : "chevron.right")
    //                            }
    //                        }
    //                        ) {
    //                            if campaign.world.hiddenFactions {
    //                                ForEach($campaign.world.factions, id: \.id) { $faction in
    //                                   NavigationLink(destination: FactionView(faction: $faction, campaign: self.campaign)) {
    //                                       Text(faction.name)
    //                                   }
    //                               }.onDelete { (indexSet) in
    //                                   campaign.world.factions.remove(atOffsets: indexSet)
    //                               }
    //                            }
    //                        }
    //                    }
                        // DESCRIPTION
                        if campaign.world.description != "" {
                            Section(header:
                                        HStack {
                                Text("Description").font(.title)
                                Spacer()
                                Button {
                                    campaign.world.hiddenDescription.toggle()
                                } label: {
                                    Image(systemName: campaign.world.hiddenDescription ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if campaign.world.hiddenDescription {
                                    TextEditor(text: $campaign.world.description)
                                        .focused($fieldIsFocused)
                                }
                            }
                        }
                        
                        // TRUTH
                        if campaign.world.truth != [] {
                            Section(header:
                                        HStack {
                                Text("Your Truth").font(.title)
                                Spacer()
                                Button {
                                    campaign.world.hiddenTruth.toggle()
                                } label: {
                                    Image(systemName: campaign.world.hiddenTruth ? "chevron.down" : "chevron.right")
                                }
                            }
                            ) {
                                if campaign.world.hiddenTruth {
                                    ForEach($campaign.world.truth, id: \.id) { $truth in
                                        NavigationLink(destination: YourTruthView(campaign: self.campaign, truth: $truth)) {
                                           Text(truth.title)
                                       }
                                   }.onDelete { (indexSet) in
                                       campaign.world.truth.remove(atOffsets: indexSet)
                                   }

                                }
                            }
                        }
                    }.listStyle(.inset)

                }
                .navigationTitle(campaign.world.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                            Button("Hide") {
                                fieldIsFocused = false
                            }
                        }
                    ToolbarItem(placement: .cancellationAction) {
                        Menu  {
                            Button {
                                openedLoadView.toggle()
                            } label: {
                                Text("Load Campaign")
                            }
                            
                            Button {
                                campaign.getStarforged()
                                campaign.writeToFile()
                            } label: {
                                Text("New Strforged Campaign")
                            }
                            
                            Button {
                                campaign.getStarSystem()
                                campaign.writeToFile()
                            } label: {
                                Text("New Custom Star System")
                            }
                            
                            Button {
                                campaign.getIronsworn()
                                campaign.writeToFile()
                            } label: {
                                Text("New Ironsworn Campaign")
                            }
                            
                            Button {
                                campaign.getWorld()
                                campaign.writeToFile()
                            } label: {
                                Text("New Custom World")
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                    ToolbarItem(placement: .destructiveAction) {
                        Menu {
    //                        if campaign.world.waitingForFaction {
    //                            Button {
    //                                campaign.world.factions.insert(buffer.factionBuffer[0], at: 0)
    //                                buffer.factionBuffer = []
    //                                campaign.writeToFile()
    //                            } label: {
    //                                Text("Insert the faction")
    //                            }
    //                        }
                            Button {
                                campaign.world.truth.insert(YourTruth(title: "New Truth"), at: 0)
                                campaign.world.hiddenTruth = true
                                campaign.writeToFile()
                            } label: {
                                Text("Add Truth")
                            }
                            if campaign.world.description == "" {
                                Button {
                                    campaign.world.description = " "
                                    campaign.writeToFile()
                                } label: {
                                    Text("Add Description")
                                }
                            }
                            
                            Button {
                                campaign.world.regions.insert(Region(name: "New Region"), at: 0)
                                campaign.world.hiddenRegions = true
                                campaign.writeToFile()
                            } label: {
                                Text("Add Region")
                            }
    //                        Button {
    //                            campaign.writeToFile()
    //                            campaign.world.factions.append(Faction())
    //                        } label: {
    //                            Text("Add Faction")
    //                        }
                            if campaign.world.sectorIsLand == false {
                                Toggle(isOn: $campaign.world.storyGenerator) {
                                    Text("Story Generator")
                                }
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .onAppear {
            if UserDefaults.standard.value(forKey: "isNotFirstLaunch") == nil { openedFirstLaunchView.toggle()
            } else {
                UserDefaults.standard.set(true, forKey: "isNotFirstLaunch")
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $openedLoadView) {
            LoadView(campaign: self.campaign)
        }
        .fullScreenCover(isPresented: $openedFirstLaunchView) {
            FirstLaunchView(campaign: self.campaign)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if let last = UserDefaults.standard.string(forKey: "lastCampaign") {
                    campaign.getData(file: "\(last).json")}
            }
            else if newPhase == .inactive {
                campaign.writeToFile()
            }
            else if newPhase == .background {
                campaign.writeToFile()
            }
        }
    }
    func randomStory() -> String {
        let action = Oracle.action(Oracle())
        let theme = Oracle.theme(Oracle())
        let description = Oracle.description(Oracle())
        let focus = Oracle.focus(Oracle())
        let sector = Sector.randomSectorName(Sector())
        let enemyName = Person.randomName(Person())
        let role = Person.randomRole(Person())
        let goal = Person.randomGoal(Person())
        
        let story = "I swear to \(action()) a \(theme()) of a \(description()) \(focus()) located in \(sector()). I am opposed by \(enemyName(false)), a \(role(false)) who wants to \(goal(false))."

        return story
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(Campaign())
    }
}
