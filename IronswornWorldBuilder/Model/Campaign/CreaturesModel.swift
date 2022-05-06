//
//  CreaturesModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Creature: Codable, Hashable, Identifiable {
    var id = UUID()
    var environment = ""
    var scale = ""
    var form = ""
    var firstLook: [String] = []
    var behavior = ""
    var revealdAspect: [String] = []
    var name = ""
    var description = ""
}

