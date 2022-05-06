//
//  RootEditView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 05.05.2022.
//

import SwiftUI

struct RootEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var campaign: Campaign
    @State private var showAlert = false
    @State private var openedNewRegion = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("CAMPAIGN NAME")
                    TextField("Enter Campaign Name", text: $campaign.world.name)
                        .textFieldStyle(.roundedBorder)
                }.padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("DESCRIPTION")
                    ScrollView {
                        TextEditor(text: $campaign.world.description)
                    } .frame(minHeight: 100)
                }
                
                List {
                    Section(header:
                                HStack {
                        Text("Regions").font(.title)
                        Spacer()
                        Button {
                            openedNewRegion.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }.sheet(isPresented: $openedNewRegion) {
                            NewRegionView()
                        }

                    }
                    
                    ) { ForEach(campaign.world.regions, id: \.self) { region in
                        Text(region.name)
                        } .onDelete(perform: deleteTrack)
                    }
                }.listStyle(.plain)
                .toolbar {
                    ToolbarItem {
                        Button {
                            if campaign.world.name == "" {
                                self.showAlert = true
                            } else {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text("Save")
                        } .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("You need to enter campaign name."))
                        }

                    }
                }.navigationBarTitle("Edit Campaign", displayMode: .inline)
            } .padding(.horizontal)
                //.padding(.top, 100)
        }
    }
    private func deleteTrack(at offsets: IndexSet) {
        campaign.world.regions.remove(atOffsets: offsets)
    }
}

struct RootEditView_Previews: PreviewProvider {
    static var previews: some View {
        RootEditView()
            .environmentObject(Campaign())
    }
}
