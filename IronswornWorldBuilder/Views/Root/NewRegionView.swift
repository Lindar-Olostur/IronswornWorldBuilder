//
//  NewRegionView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 06.05.2022.
//

import SwiftUI

struct NewRegionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var campaign: Campaign
    @State var region: Region = Region()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Region name")
                TextField("Enter name", text: $region.name)
                    .textFieldStyle(.roundedBorder)
//                Text("Description")
//                ScrollView {
//                    TextEditor(text: $region.description)
//                        .textFieldStyle(.roundedBorder)
//                } .frame(minHeight: 100)
                Spacer()
            }
                .toolbar {
                    ToolbarItem {
                        Button {
                            campaign.world.regions.append(region)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                }.navigationBarTitle("New Region", displayMode: .inline)
        }.padding(.horizontal)
    }
}

struct NewRegionView_Previews: PreviewProvider {
    static var previews: some View {
        NewRegionView()
            .environmentObject(Campaign())
    }
}
