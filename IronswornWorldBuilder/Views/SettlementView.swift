//
//  ContentView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import SwiftUI

struct SettlementView: View {
    @EnvironmentObject var oracle: Oracle
    var settlement: Settlement
    
    @State var trouble = ""
    @State var projects = ""
    @State var contact = ""
    @State var inhabitants = ""
    @State var population = ""
    @State var authority = ""
    @State var look = ""
    @State var oracleButtons = true
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Description")) {
                    VStack {
                        
                        Toggle("Oracle", isOn: $oracleButtons).padding(.horizontal)
                        VStack {
                            Divider()
                            
                            HStack {
                                Text("First look: ")
                                TextField("Enter your text or ask the oracle", text: $look)
                                if oracleButtons {
                                    HStack {
                                        Button {
                                            look = oracle.settlementLook()
                                        } label: {
                                            Image(systemName: "1.circle")
                                        }
                                        Button {
                                            look = "\(oracle.settlementLook()), \(oracle.settlementLook())"
                                        } label: {
                                            Image(systemName: "2.circle")
                                        }
                                    }
                                }
                            } .padding(.horizontal)
                            
                            HStack {
                                Text("Initial contact: ")
                                TextField("Enter your text or ask the oracle", text: $contact)
                                if oracleButtons {
                                    Button {
                                        contact = oracle.settlementContact()
                                    } label: {
                                        Image(systemName: "1.circle")
                                    }
                                }
                            } .padding(.horizontal)
                            Divider()
                            HStack {
                                Text("Inhabitants: ")
                                TextField("Enter your text", text: $inhabitants)
                            } .padding(.horizontal)
                            
                            HStack {
                                Text("Population: ")
                                TextField("Enter your text", text: $population)
                            } .padding(.horizontal)
                            HStack {
                                Text("Authtority: ")
                                TextField("Enter your text or ask the oracle", text: $authority)
                                if oracleButtons {
                                    Button {
                                        authority = oracle.settlementAuthtority()
                                    } label: {
                                        Image(systemName: "1.circle")
                                    }
                                }
                            } .padding(.horizontal)
                            Divider()
                            HStack {
                                Text("Trouble: ")
                                TextField("Enter your text or ask the oracle", text: $trouble)
                                if oracleButtons {
                                    Button {
                                        trouble = oracle.settlementTrouble()
                                    } label: {
                                        Image(systemName: "1.circle")
                                    }
                                }
                            } .padding(.horizontal)
                            
                            HStack {
                                Text("Projects: ")
                                TextField("Enter your text or ask the oracle", text: $projects)
                                if oracleButtons {
                                    HStack {
                                        Button {
                                            projects = oracle.settlementProjects()
                                        } label: {
                                            Image(systemName: "1.circle")
                                        }
                                        Button {
                                            projects = "\(oracle.settlementProjects()), \(oracle.settlementProjects())"
                                        } label: {
                                            Image(systemName: "2.circle")
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Places")) {
                    //
                }
                Section(header: Text("Persons")) {
                    //
                }
                Section(header: Text("Connections")) {
                    //
                }
            }.listStyle(.sidebar)
            
            
            .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text(settlement.name).font(.title)
                                    .bold()
                                Text("\(settlement.locationType) settlement").font(.subheadline)
                            }
                        }
                    }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementView(settlement: Settlement(id: UUID(), name: "Kepler", description: "My own text.", locationType: "Orbital", inhabitants: "Humans", population: "Hundreds", firstLook: ["Beautiful architecture"], initialContact: "Hostile", authority: "Corrupt", projects: ["Energy"], trouble: "Social strife", route: [], theme: ""))
            //.environmentObject(Oracle())
    }
}
