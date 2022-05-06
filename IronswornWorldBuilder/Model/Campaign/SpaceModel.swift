//
//  PlanetModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct StellarObject: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var description = ""
    var route: [Route] = []
}

struct Planet: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var description = ""
    var type = ""
    var atmosphere = ""
    var viewFromSpace: [String] = []
    var feature: [String] = []
    var settlements = ""
    var life = ""
    var devercity = ""
    var biomes: [String] = []
    var route: [Route] = []
}
