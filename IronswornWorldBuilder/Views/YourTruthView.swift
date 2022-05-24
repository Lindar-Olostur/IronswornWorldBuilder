//
//  YourTruthView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 17.05.2022.
//

import SwiftUI

struct YourTruthView: View {
    @ObservedObject var campaign: Campaign
    @Binding var truth: YourTruth
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                VStack {
                    HStack {
                        TextField("Enter truth title", text: $truth.title).font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .focused($fieldIsFocused)
                        if truth.mode == "Generation" {
                            Spacer()
                            Button {
                                truth.current = Int.random(in: 0...2)
                                truth.truth = truth.options[truth.current]
                            } label: {
                                Image(systemName: "dice")
                            }
                            .padding(.trailing)
                            .buttonStyle(.bordered)
                        }
                        if truth.mode == "Selection" {
                            Spacer()
                            Button {
                                truth.current += 1
                                truth.truth = truth.options[truth.current]
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                            .padding(.trailing)
                            .buttonStyle(.bordered)
                        }
                    }
                    
                    TextEditor(text: $truth.truth)
                        .padding()
                        .focused($fieldIsFocused)
                    

                }
                    }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Button("Hide") {
                            fieldIsFocused = false
                        }
                    }
                ToolbarItem(placement: .destructiveAction) {
                    if campaign.world.type == "IS" || campaign.world.type == "SF" {
                        Menu {
                            if truth.mode != "Input" {
                                Button {
                                    truth.mode = "Input"
                                } label: {
                                    Text("Input")
                                }
                            }
                            if truth.mode != "Selection" {
                                Button {
                                    truth.mode = "Selection"
                                } label: {
                                    Text("Selection")
                                }
                            }
                            if truth.mode != "Generation" {
                                Button {
                                    truth.mode = "Generation"
                                } label: {
                                    Text("Generation")
                                }
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        
    }
}

struct YourTruthView_Previews: PreviewProvider {
    static var previews: some View {
        YourTruthView(campaign: Campaign(), truth: .constant(YourTruth()))
            .environmentObject(Campaign())
    }
}
