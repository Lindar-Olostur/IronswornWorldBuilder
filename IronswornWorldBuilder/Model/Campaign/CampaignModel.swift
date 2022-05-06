//
//  CampaignModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import Foundation

struct World: Codable {
    var type: String = "" // stars, world, IS, SF ...
    var name: String = "" {
        willSet {UserDefaults.standard.set(newValue, forKey: "lastCampaign")}
    }
   // var subName: String = ""
    var description: String = ""
    var regions: [Region] = []
}

struct Region: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: String = ""
    var description: String = ""
    var sector: [Sector] = []
}

struct Sector: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var description = ""
    var stellarObject: [StellarObject] = []
    var planet: [Planet] = []
    var settlement: [Settlement] = []
    var location: [Location] = []
    var creature: [Creature] = []
    var vehicle: [Starship] = []
}


