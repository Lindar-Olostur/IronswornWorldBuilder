//
//  RouteView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 10.05.2022.
//

import SwiftUI

struct RouteView: View {
    @Binding var route: Route
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                Text("\(route.rank.rawValue.capitalized) route to \(route.destination)").font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                
                List {
                    Section(header: Text("Destination").font(.title)) {
                        TextField("Enter destination", text: $route.destination)
                            .focused($fieldIsFocused)
                    }
                    Section(header: Text("Rank").font(.title)) {
                        Picker(selection: $route.rank, label: EmptyView()) {
                            ForEach(Rank.allCases, id: \.self) { value in
                                Text(value.rawValue.capitalized)
                                    .tag(value)
                            }
                        }.pickerStyle(.inline)
                    }
                }.listStyle(.inset)
                
                
            }
            Spacer()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                            Button("Hide") {
                                fieldIsFocused = false
                            }
                        }
                }
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView(route: .constant(Route()), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
