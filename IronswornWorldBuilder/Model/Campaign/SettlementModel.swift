//
//  SettlementFantasyModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Settlement: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var description = ""
    var locationType = ""
    var inhabitants = ""
    var population = ""
    var firstLook: [String] = []
    var initialContact = ""
    var authority = ""
    var projects: [String] = []
    var trouble = ""
    var route: [Route] = []
    var theme = ""
   // var places: [Location] = []
   // var persons: [Person] = []
}

struct Route: Codable, Hashable, Identifiable {
    var id = UUID()
    var destination = ""
    var rank = Rank.troublesome
}

