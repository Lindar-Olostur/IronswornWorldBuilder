//
//  SettlementFantasyModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Settlement: Codable, Hashable, Identifiable {
    
    var id = UUID()
    var name = Settlement.randomName()
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenLocType = true
    var locationType = "Unknown"
    var hiddenInhabitants = true
    var inhabitants: [StringContainer] = []
    var hiddenPopulation = true
    var population = ""
    var hiddenFirstLook = true
    var firstLook: [StringContainer] = []
    var hiddenContact = true
    var initialContact = ""
    var hiddenAuth = true
    var authority = ""
    var hiddenProjects = true
    var projects: [StringContainer] = []
    var hiddenTrouble = true
    var trouble = ""
    var hiddenRoutes = true
    var routes: [Route] = []
    var homeSector = ""
    var hiddenTheme = true
    var theme: [StringContainer] = []
    var mode = "Input"
    var oracle = Oracle.sharedOracle
    var travelMode = false
    var hiddenLocations = true
    var places: [Location] = []
    var hiddenPersons = true
    var persons: [Person] = []
    var isDerilict = false
    var hiddenDerilict = true
    var derilict: [Derelict] = [Derelict(isChild: true)]
    
    func randomLocationType() -> String {
        let dictionary = [
            "Planetside" : 8,
            "Orbital" : 7,
            "Deep Space" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomPopulation(region: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch region {
        case "Terminus" :
            dictionary = [
                "Few" : 10,
                "Dozens" : 15,
                "Hundreds" : 30,
                "Thousands" : 30,
                "Tens of thousands" : 15,
            ]
        case "Outlands" :
            dictionary = [
                "Few" : 15,
                "Dozens" : 20,
                "Hundreds" : 30,
                "Thousands" : 25,
                "Tens of thousands" : 10,
            ]
        case "Expanse" :
            dictionary = [
                "Few" : 20,
                "Dozens" : 30,
                "Hundreds" : 30,
                "Thousands" : 15,
                "Tens of thousands" : 5,
            ]
        default:
            dictionary = [
                "Few" : 40,
                "Dozens" : 30,
                "Hundreds" : 20,
                "Thousands" : 8,
                "Tens of thousands" : 2,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var firstLookList = ["Beautiful architecture", "Built from organic materials", "Built from random scrap", "Built within repurposed ship", "Built within terrain or asteroid", "Defensible location", "Elevated or multi-level construction", "Hidden or subsurface location", "Intimidating defenses", "Precarious location", "Rustic architecture", "Significant structural damage", "Sprawling or dispersed structures", "Temporary or seasonal location", "Toxic or polluted habitat", "Within or near Precursor Vault"]
    func randomFirstLook() -> String {
        let dictionary = [
            "Beautiful architecture" : 3,
            "Built from organic materials" : 6,
            "Built from random scrap" : 6,
            "Built within repurposed ship" : 6,
            "Built within terrain or asteroid" : 5,
            "Defensible location" : 5,
            "Elevated or multi-level construction" : 4,
            "Hidden or subsurface location" : 5,
            "High-tech construction" : 3,
            "Industrial architecture" : 6,
            "Intimidating defenses" : 4,
            "Moving or transforming" : 3,
            "Obvious social stratification" : 5,
            "Precarious location" : 5,
            "Rustic architecture" : 6,
            "Significant structural damage" : 4,
            "Sprawling or dispersed structures" : 4,
            "Temporary or seasonal location" : 3,
            "Toxic or polluted habitat" : 4,
            "Within or near Precursor Vault" : 3,
            "\(oracle.description()) + \(oracle.focus())" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var contactList = ["Welcoming", "Neutral / automated", "Wary", "Uncooperative", "Hostile", "Asking for help", "In battle", "Captured", "Unresponsive", "Destroyed", "Derelict"]
    func randomContact() -> String {
        let dictionary = [
            "Welcoming" : 20,
            "Neutral / automated" : 10,
            "Wary" : 15,
            "Uncooperative" : 10,
            "Hostile" : 10,
            "Asking for help" : 13,
            "In battle" : 3,
            "Captured" : 3,
            "Unresponsive" : 3,
            "Destroyed" : 3,
            "Derelict" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var authorityList = ["None / lawless", "Ineffectual", "Tolerant", "Fair", "Unyielding", "Corrupt", "Oppressive"]
    func randomAuthority() -> String {
        let dictionary = [
            "None / lawless" : 15,
            "Ineffectual" : 15,
            "Tolerant" : 15,
            "Fair" : 10,
            "Unyielding" : 15,
            "Corrupt" : 15,
            "Oppressive" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var projectList = ["Agriculture", "Archeology", "Automation", "Black market", "Command", "Defense", "Energy", "Engineering", "Entertainment", "Environmentalism", "Evacuation", "Expansion", "Exploration", "Festival", "History", "Hunting", "Manufacturing", "Medical", "Migration", "Mining", "Pacifism", "Raiding", "Research", "Salvage", "Secrecy", "Shipbuilding", "Spirituality", "Subsistence", "Surveillance", "Terraforming", "Trade", "Warfare"]
    func randomProject() -> String {
        let dictionary = [
            "Agriculture" : 5,
            "Archeology" : 2,
            "Automation" : 2,
            "Black market" : 2,
            "Command" : 2,
            "Defense" : 4,
            "Energy" : 5,
            "Engineering" : 3,
            "Entertainment" : 2,
            "Environmentalism" : 2,
            "Evacuation" : 2,
            "Expansion" : 2,
            "Exploration" : 4,
            "Festival" : 2,
            "History" : 2,
            "Hunting" : 2,
            "Manufacturing" : 3,
            "Medical" : 3,
            "Migration" : 2,
            "Mining" : 6,
            "Pacifism" : 2,
            "Raiding" : 3,
            "Research" : 3,
            "Salvage" : 4,
            "Secrecy" : 3,
            "Shipbuilding" : 3,
            "Spirituality" : 3,
            "Subsistence" : 6,
            "Surveillance" : 2,
            "Terraforming" : 2,
            "Trade" : 4,
            "Warfare" : 3,
            "\(oracle.action()) + \(oracle.theme())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var troubleList = ["Betrayal from within", "Blocked resource", "Caught in the crossfire", "Changing environment", "Clash of cultures", "Dangerous discovery", "Depleted resource", "Failing technology", "Feuding factions", "Ghostly visitations", "Hazardous environment", "Hostile lifeforms", "Impending attack", "Impending natural disaster", "Invasive nature or lifeform", "Mysterious deaths", "Plagued by sickness", "Preyed upon by raiders", "Revolt against leadership", "Sabotaged technology", "Social strife", "Someone is ill or injured", "Someone is missing", "Stolen technology or object", "Strange phenomenon", "Toxic waste or pollution", "Volatile energy source", "Vulnerable lifeforms"]
    func randomTrouble() -> String {
        let dictionary = [
            "Betrayal from within" : 3,
            "Blocked resource" : 4,
            "Caught in the crossfire" : 2,
            "Changing environment" : 4,
            "Clash of cultures" : 2,
            "Dangerous discovery" : 4,
            "Depleted resource" : 4,
            "Failing technology" : 4,
            "Feuding factions" : 4,
            "Ghostly visitations" : 2,
            "Hazardous environment" : 4,
            "Hostile lifeforms" : 4,
            "Impending attack" : 3,
            "Impending natural disaster" : 3,
            "Invasive nature or lifeform" : 2,
            "Mysterious deaths" : 2,
            "Plagued by sickness" : 3,
            "Preyed upon by raiders" : 3,
            "Revolt against leadership" : 2,
            "Sabotaged technology" : 2,
            "Social strife" : 3,
            "Someone is ill or injured" : 2,
            "Someone is missing" : 2,
            "Stolen technology or object" : 2,
            "Strange phenomenon" : 3,
            "Toxic waste or pollution" : 3,
            "Volatile energy source" : 2,
            "Vulnerable lifeforms" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 10,
            "Roll twice" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    static func randomName() -> String {
        
        let nameFormat = Int.random(in: 0...15)
        var name = "Unknown settlement"
        
        func getPrefix() -> String {
            let list = ["Base", "Citadel", "Depot", "Fortress", "Hold", "Landing", "Outpost", "Port", "Station", "Terminal"]
            return list.shuffled()[0]
        }
        
        func getSuffix() -> String {
            let list = ["aegis", "kepler", "redemption", "altair", "koshiba", "redhaven", "altura", "lagrange", "relic", "amity", "larissa", "reprise", "apex", "lasthope", "reverie", "apogee", "lastport", "rhiannon", "argosy", "legacy", "rockhome", "astra", "lodestar", "rust", "aurora", "luminus", "sagan", "beowulf", "lyra", "scirocco", "brink", "marrow", "selena", "bulwark", "meridian", "sepulcher", "burnell", "moirai", "sigil", "burrow", "mudd", "silvana", "concord", "neoma", "sirius", "crux", "nerio", "sisyphus", "deadrock", "nova", "solitude", "deception", "nyx", "spire", "elysium", "osseus", "starfall", "enigma", "paradox", "sundown", "erebus", "paragon", "tranquility", "eris", "paxton", "tyson", "evenfall", "perchance", "unity", "eventide", "pinnacle", "utopia", "farpoint", "polaris", "vega", "felicity", "portent", "vesper", "florin", "prism", "wayward", "forlorn", "providence", "welkin", "forsaken", "purgatory", "wellpsring", "freya", "rampart", "weyland", "glimmer", "ramshackle", "wreck", "gloam", "hearth", "helia", "hypatia", "karma", "hyperion", "janus",]
            return list.shuffled()[0].capitalized
        }
        
        
        if nameFormat <= 6 {
            name = getSuffix()
        }

        if nameFormat >= 9 {
            name = "\(getPrefix()) \(getSuffix())"
        }

        return name
    } //куда вставить генератор названий

}

struct Route: Codable, Hashable, Identifiable {
    var id = UUID()
    var destination = ""
    var rank = Rank.troublesome
}

