//
//  CharacterModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Character: Identifiable {
    var id = UUID()
    var race = ""
    var sex = ""
    var name = ""
    var description = ""
    var firstLook: [String] = []
    var disposition = ""
    var role = ""
    var goal = ""
    var revealdAspect: [String] = []
}
