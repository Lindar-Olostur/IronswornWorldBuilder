//
//  ClockView.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 22.07.2022.
//

import SwiftUI


struct ClockView: View {
    @Binding var clock: Clock
    @ObservedObject var campaign: Campaign
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Enter Clock name", text: $clock.name).font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .focused($fieldIsFocused)
                    
                    VStack {
                        HStack {
                            TextField("0", value: $clock.currentClock, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .font(.system(size: 60))
                                .multilineTextAlignment(.trailing)
                                .frame(width: 80)
                            Text("/").font(.system(size: 60))
                            Menu {
                                Picker(selection: $clock.maxClock, label: EmptyView()) {
                                    ForEach(clock.maxList, id: \.self) { value in
                                        Text("\(value)").font(.system(size: 50))
                                            .tag(value)
                                    }
                                }
                            } label: {
                                Text("\(clock.maxClock)").font(.system(size: 60))
                            }
                        }.padding(.leading, -35)
                    }
                    Button  {
                        clock.currentClock += 1
                    } label: {
                        Text("+").font(.system(size: 60))
                    }.buttonStyle(.bordered)

                    Text("Description").font(.system(size: 40))
                        .foregroundColor(.gray)
                    TextEditor(text: $clock.description)
                        .padding()
                        .focused($fieldIsFocused)
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
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(clock: .constant(Clock(name: "My clock", currentClock: 10)), campaign: Campaign())
            .environmentObject(Campaign())
    }
}
