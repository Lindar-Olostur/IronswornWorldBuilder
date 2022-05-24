//
//  LocationsModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation



struct PrecursorVault: Identifiable {
    var id = UUID()
    var locationType = ""
    var scale = ""
    var form = ""
    var shape = ""
    var material = ""
    var outerFirstLook: [String] = []
    var innerFirstLook: [String] = []
    var name = ""
    var description = ""
    var rank = Rank.troublesome
    var theme = ""
}

struct Location: Codable, Hashable, Identifiable {
    var id = UUID()
    var theme = ""
    var domain = ""
    var name = ""
    var description = ""
    var rank = Rank.troublesome
//  ----;m;ll
//    var locationType = ""
//    var scale = ""
//    var form = ""
//    var shape = ""
//    var material = ""
//    var outerFirstLook: [String] = []
//    var innerFirstLook: [String] = []
}



