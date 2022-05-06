//
//  VehiclesModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Starship: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var description = ""
    var type = ""
    var fleet = ""
    var firstLook: [String] = []
    var initialContact = ""
    var mission = ""
    var theme = ""
}
