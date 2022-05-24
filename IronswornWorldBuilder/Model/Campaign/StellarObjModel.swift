//
//  PlanetModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct StellarObject: Codable, Hashable, Identifiable {
    var id = UUID()
    var type = "Unknown Stellar Object" {
        didSet {
            switch type {
            case "Red star" :
                description = "Smoldering red star"
            case "Orange star" :
                description = "Glowing orange star"
            case "Yellow star" :
                description = "Burning yellow star"
            case "Blue star" :
                description = "Blazing blue star"
            case "Molecular cloud" :
                description = "Young star incubating in a molecular cloud"
            case "White dwarf" :
                description = "White dwarf shining with spectral light"
            case "Corrupted star" :
                description = "Corrupted star radiating with unnatural light"
            case "Neutron star" :
                description = "Neutron star surrounded by intense magnetic fields"
            case "Binary star" :
                description = "Two stars in close orbit connected by fiery tendrils of energy"
            case "Black hole" :
                description = "Black hole allows nothing to escape—not even light"
            case "Hypergiant star" :
                description = "Hypergiant star generating turbulent solar winds"
            case "Artificial star" :
                description = "Artificial star constructed by a long-dead civilization"
            case "Unstable star" :
                description = "Unstable star showing signs of impending supernova"
            default:
                description = ""
            }
        }
    }
    var subName = ""
    var name = ""
    var description = ""
    var homeSector = ""
    var hiddenPlanets = true
    var hiddenDescription = true
    var hiddenSettlements = true
    var hiddenLocations = true
    var hiddenCreatures = true
    var hiddenVehicles = true
    var hiddenRoutes = true
    var planets: [Planet] = []
    var settlements: [Settlement] = []
    var locations: [Location] = []
    var creatures: [Creature] = []
    var vehicles: [Starship] = []
    var routes: [Route] = []
    var mode = "Generation"
    var travelMode = false
    
    var typeList = ["Red star", "Orange star", "Yellow star", "Blue star", "Molecular cloud", "White dwarf", "Corrupted star", "Neutron star", "Binary star", "Black hole", "Hypergiant star", "Artificial star", "Unstable star", "Unknown Stellar Object"]
    func randomType() -> String {
        let dictionary = [
            "Red star" : 15,
            "Orange star" : 15,
            "Yellow star" : 15,
            "Blue star" : 5,
            "Molecular cloud" : 10,
            "White dwarf" : 10,
            "Corrupted star" : 5,
            "Neutron star" : 5,
            "Binary star" : 5,
            "Black hole" : 5,
            "Hypergiant star" : 8,
            "Artificial star" : 1,
            "Unstable star" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var engLetters = ["z", "y", "x", "w", "v", "u", "t", "s", "r", "q", "p", "o", "n", "m", "l", "k", "j", "i", "h", "g", "f", "e", "d", "c", "b", "a"]
    mutating func randomPlanetName() -> String {
        var result = ""
        if self.name != "Unknown stellar object" {
            result = "\(self.name) \(engLetters.popLast() ?? "")"
        } else {
            result = "Unknown Planet"
        }
        
        return result
    }
}


