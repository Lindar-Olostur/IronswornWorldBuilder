//
//  LocationsModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Derelict: Identifiable {
    var id = UUID()
    var locationType = ""
    var typeByLocation = ""
    var condition = ""
    var outerFirstLook = ""
    var innerFirstLook: [String] = []
    var name = ""
    var description = ""
    var rank = Rank.troublesome
    var theme = ""
}

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

enum Theme {
    case chaotic
    case fortified
    case haunted
    case infested
    case inhabited
    case ruined
    case sacred
    case ancient
    case corrupted
    case hallowed
    case ravaged
    case wild
}

enum Domain {
    case barrow
    case cavern
    case frozenCavern
    case icereach
    case mine
    case pass
    case ruin
    case seaCave
    case shadowfen
    case stronghold
    case tanglewood
    case underkeep
}

