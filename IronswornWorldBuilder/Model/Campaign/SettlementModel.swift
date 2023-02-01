//
//  SettlementFantasyModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Settlement: Codable, Hashable, Identifiable {
    
    var id = UUID()
    var name = "" {
        didSet {
            if derilict != [] {
                derilict[0].name = self.name
            }
        }
    }
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenLocType = true
    var locationType = ""
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
    var hiddenFactions = true
    var factions: [Faction] = []
    var trouble = ""
    var hiddenRoutes = true
    var routes: [Route] = []
    var homeSector = ""
    var mode = "Input"
    var oracle = Oracle.sharedOracle
    var travelMode = false
    var hiddenLocations = true
    var locations: [Location] = []
    var hiddenPersons = true
    var persons: [Person] = []
    var hiddenDerilict = true
    var derilict: [Derelict] = []
    var hiddenVault = true
    var vaults: [PrecursorVaults] = []
    var waitingForStarship = false
    var vehicles: [Starship] = []
    var hiddenVehicles: Bool = true
    var waitingForPerson = false
    var waitingForCreature = false
    var hiddenCreature = true
    var creatures: [Creature] = []
    var waitingForFaction = false
    var clocks: [Clock] = []
    var hiddenClock = true
    
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
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
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
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    var firstLookList = ["Beautiful architecture", "Built from natural materials", "Built from scrap metal", "Built within repurposed ship", "Built within terrain or asteroid", "Elevated or multilevel construction", "Hidden or subsurface location", "Hightech construction", "Industrial architecture", "Intimidating defenses", "Moving or transforming", "Obvious social stratification", "Precarious location", "Prominent emblems or signage", "Rustic architecture", "Significant structural damage", "Sprawling or dispersed structures", "Temporary or seasonal location", "Toxic or polluted habitat", "Within or near Precursor Vault"]
    func randomFirstLook() -> String {
        let dictionary = [
            "Beautiful architecture" : 4,
            "Built from natural materials" : 4,
            "Built from scrap metal" : 6,
            "Built within repurposed ship" : 6,
            "Built within terrain or asteroid" : 5,
            "Elevated or multilevel construction" : 4,
            "Hidden or subsurface location" : 5,
            "Hightech construction" : 3,
            "Industrial architecture" : 6,
            "Intimidating defenses" : 5,
            "Moving or transforming" : 3,
            "Obvious social stratification" : 5,
            "Precarious location" : 5,
            "Prominent emblems or signage" : 4,
            "Rustic architecture" : 6,
            "Significant structural damage" : 6,
            "Sprawling or dispersed structures" : 4,
            "Temporary or seasonal location" : 3,
            "Toxic or polluted habitat" : 4,
            "Within or near Precursor Vault" : 2,
            "\(NSLocalizedString(oracle.description(), comment: "")) + \(NSLocalizedString(oracle.focus(), comment: ""))" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
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
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
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
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
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
            "\(NSLocalizedString(oracle.action(), comment: "")) + \(NSLocalizedString(oracle.theme(), comment: ""))" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    var troubleListSf = ["Battle for leadership", "Mounting debt", "Betrayal from within", "Mysterious deaths", "Caught in the crossfire", "Overdue delivery", "Changing environment", "Plagued by sickness", "Clash of cultures", "Preyed upon by raiders", "Dangerous discovery", "Revolt against leadership", "Depleted supplies", "Sabotaged technology", "Deprived of a resource", "Shunned by others", "Failing technology", "Social strife", "Feuding factions", "Someone is ill or injured", "Ghostly visitations", "Someone is missing", "Hazardous environment", "Stolen technology or object", "Hostile lifeforms", "Strange phenomenon", "Impassable route", "Toxic waste or pollution", "Impending attack", "Volatile energy source", "Impending natural disaster", "Vulnerable lifeforms", "Invasive organisms"]
    var troubleListIs = ["Outsiders rejected", "Dangerous discovery", "Dreadful omens", "Natural disaster", "Old wounds reopened", "Important object is lost", "Someone is captured", "Mysterious phenomenon", "Revolt against a leader", "Vengeful outcast", "Rival settlement", "Nature strikes back", "Someone is missing", "Production halts", "Mysterious murders", "Debt comes due", "Unjust leadership", "Disastrous accident", "In league with the enemy", "Raiders prey on the weak", "Cursed past", "An innocent is accused", "Corrupted by dark magic", "Isolated by brutal weather", "Provisions are scarce", "Sickness run amok", "Allies become enemies", "Attack is imminent", "Lost caravan", "Dark secret revealed", "Urgent expedition", "A leader falls", "Families in conflict", "Incompetent leadership", "Reckless warmongering", "Beast on the hunt", "Betrayed from within", "Broken truce", "Wrathful haunt", "Conflict with firstborn", "Trade route blocked", "In the crossfire", "Stranger causes discord", "Important event threatened", "Dangerous tradition"]
    func randomTroubleSf() -> String {
        let dictionary = [
            "Battle for leadership" : 3,
            "Mounting debt" : 2,
            "Betrayal from within" : 3,
            "Mysterious deaths" : 2,
            "Caught in the crossfire" : 2,
            "Overdue delivery" : 3,
            "Changing environment" : 3,
            "Plagued by sickness" : 2,
            "Clash of cultures" : 2,
            "Preyed upon by raiders" : 3,
            "Dangerous discovery" : 4,
            "Revolt against leadership" : 2,
            "Depleted supplies" : 4,
            "Sabotaged technology" : 2,
            "Deprived of a resource" : 3,
            "Shunned by others" : 2,
            "Failing technology" : 4,
            "Social strife" : 3,
            "Feuding factions" : 4,
            "Someone is ill or injured" : 2,
            "Ghostly visitations" : 2,
            "Someone is missing" : 2,
            "Hazardous environment" : 4,
            "Stolen technology or object" : 2,
            "Hostile lifeforms" : 4,
            "Strange phenomenon" : 3,
            "Impassable route" : 3,
            "Toxic waste or pollution" : 3,
            "Impending attack" : 3,
            "Volatile energy source" : 2,
            "Impending natural disaster" : 3,
            "Vulnerable lifeforms" : 2,
            "Invasive organisms" : 2,
            "\(NSLocalizedString(oracle.action(), comment: "")) + \(NSLocalizedString(oracle.theme(), comment: ""))" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    func randomTroubleIs() -> String {
        let pool = ["Outsiders rejected", "Dangerous discovery", "Dreadful omens", "Natural disaster", "Old wounds reopened", "Important object is lost", "Someone is captured", "Mysterious phenomenon", "Revolt against a leader", "Vengeful outcast", "Rival settlement", "Nature strikes back", "Someone is missing", "Production halts", "Mysterious murders", "Debt comes due", "Unjust leadership", "Disastrous accident", "In league with the enemy", "Raiders prey on the weak", "Cursed past", "An innocent is accused", "Corrupted by dark magic", "Isolated by brutal weather", "Provisions are scarce", "Sickness run amok", "Allies become enemies", "Attack is imminent", "Lost caravan", "Dark secret revealed", "Urgent expedition", "A leader falls", "Families in conflict", "Incompetent leadership", "Reckless warmongering", "Beast on the hunt", "Betrayed from within", "Broken truce", "Wrathful haunt", "Conflict with firstborn", "Trade route blocked", "In the crossfire", "Stranger causes discord", "Important event threatened", "Dangerous tradition", "\(NSLocalizedString(oracle.actionIS(), comment: "")) + \(NSLocalizedString(oracle.themeIS(), comment: ""))"]
        
        var answer = pool.shuffled()
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    static func randomName(isLand: Bool) -> String {
        var name = "Unknown"
        if isLand == false {
            let nameFormat = Int.random(in: 0...15)
            
            
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

            
        }
        if isLand == true {
            let nameIL = Oracle.ironlandersName(Oracle())
            let nameFormat = Int.random(in: 0...8)
            
            if nameFormat > 0 && nameFormat < 8 {
                name = "\(getPrefix())\(getSuffix())"
            }
            if nameFormat == 0 {
                name = "\(getPrefix())'s \(getSuffix())"
            }
            if nameFormat == 8 {
                name = "\(nameIL())'s \(getSuffix())"
            }
            func getPrefix() -> String {
                let list = ["Bleak", "Green", "Wolf", "Raven", "Gray", "Red", "Axe", "Great", "Wood", "Low", "White", "Storm", "Black", "Mourn", "New", "Stone", "Grim", "Lost", "High", "Rock", "Shield", "Sword", "Frost", "Thorn", "Long", "Deep", "Dark", "Timber", "Lone", "Cinder", "Fallow", "Raven", "Bear", "Eagle", "Fox", "Elder", "Elk", "Dragon", "First", "Broken", "Last", "Rock", "Old"]
                return list.shuffled()[0]
            }
            func getSuffix() -> String {
                let list = ["moor", "ford", "crag", "watch", "hope", "wood", "ridge", "stone", "heaven", "fall", "river", "field", "hill", "bridge", "mark", "cairn", "land", "hall", "mount", "rock", "brook", "barrow", "stead", "home", "wick", "water", "crest", "tree", "cliff", "fort", "well", "wall", "tower", "spire", "rest", "hollow", "shadow", "break", "meet", "helm", "haunt", "stand", "lamment", "march", "hold", "burg", "ville"]
                return list.shuffled()[0]
            }
        }
        return name
    }

}

struct Route: Codable, Hashable, Identifiable {
    var id = UUID()
    var destination = ""
    var rank = Rank.troublesome
}

