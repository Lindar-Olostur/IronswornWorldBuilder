//
//  RegionsView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import SwiftUI

struct RegionView: View {
    @ObservedObject var campaign: Campaign
    @State var region: Region
    var body: some View {
        VStack {
            List {
                if region.sector != [] {
                    Section(header: Text("Sectors").font(.title)) { ForEach(region.sector, id: \.self) { sector in
                        Text(NSLocalizedString(sector.name, comment: ""))
                        }
                    }
                }
                if region.description != "" {
                    Section("Description") {
                        Text("\(region.description)")
                    }
                }
                
            }
            .listStyle(.sidebar)
            .navigationTitle(region.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading){
//                    Button {
//                        //self.openedEditView.toggle()
//                    } label: {
//                        Text("Edit")
//                    }
////                    .sheet(isPresented: $openedEditView) {
////                        EditView()//hero: self.hero)
////                    }
//                }
//                ToolbarItem(placement: .principal) {
//                    VStack {
//                        Text("\(region.name)")
//                            .font(.title)
//                            .bold()
//                            .frame(maxWidth: .infinity)
////                        Text("In \()")
////                            .font(.subheadline)
////                            .frame(maxWidth: .infinity)
//                    }
//                }
            }
        }
    }
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionView(campaign: Campaign(), region: Region(name: "Popezz"))
    }
}
