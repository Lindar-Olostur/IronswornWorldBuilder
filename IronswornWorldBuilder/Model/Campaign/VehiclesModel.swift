//
//  VehiclesModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Starship: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = Starship.randomName(mod: "")
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenType = true
    var type = "Unknown class" {
        didSet {
            switch type {
            case "Carrier" :
                subName = "Launches fighters"
            case "Corvette" :
                subName = "Light attack ship"
            case "Courier" :
                subName = "Fast transport"
            case "Cruiser" :
                subName = "Medium attack ship"
            case "Dreadnought" :
                subName = "Heavy attack ship"
            case "Escape pod" :
                subName = "Survival craft"
            case "Foundry" :
                subName = "Mobile construction platform"
            case "Harvester" :
                subName = "Fuel or energy excavator"
            case "Hauler" :
                subName = "Heavy transport"
            case "Hunter" :
                subName = "Stealthy attack ship"
            case "Ironhome" :
                subName = "Habitat"
            case "Mender" :
                subName = "Utility or repair"
            case "Outbounder" :
                subName = "Remote survey or research"
            case "Pennant" :
                subName = "Command ship"
            case "Prospector" :
                subName = "Mineral excavator"
            case "Reclaimer" :
                subName = "Salvage or rescue"
            case "Shuttle" :
                subName = "Short-range transport"
            case "Snub fighter" :
                subName = "Small attack craft"
            case "Multipurpose" :
                subName = "Mission: \(randomMission(region: ""))"
            default:
                subName = ""
            }
        }
    }
    var hiddenFleet = true
    var fleet = ""
    var hiddenFirstLook = true
    var firstLook: [StringContainer] = []
    var hiddenContact = true
    var initialContact = ""
    var hiddenMission = true
    var missions: [StringContainer] = []
    var hiddenTheme = true
    var theme = ""
    var homeSector = ""
    var hiddenFactions = true
    var factions: [Faction] = []
    var mode = "Input"
    var oracle = Oracle.sharedOracle
    var hiddenDerilict = true
    var derilict: [Derelict] = []
    var waitingForPerson = false
    var hiddenPersons = true
    var persons: [Person] = []
    var waitingForCreature = false
    var hiddenCreature = true
    var creatures: [Creature] = []
    var waitingForFaction = false
    
    static func randomName(mod: String) -> String {
        var nameFormat = 0
        if mod == "Known" {
            nameFormat = 0
        } else {
            nameFormat = Int.random(in: 0...4)
        }
        var name = "Unknown starship"
        
        func getName() -> String {
            let list = ["Arclight", " Invictus", " Rubicon", " Argent", "Arrow", " Iron Cairn", " Sareea's Tribute", " Artemis", " Karena's Reverie", " Second Chance", " Astral Explorer", " Kraken", " Shard of the Sun", " Atlas", " Kuno's Hammer", " Shattered Siege", " Aurora", " Lightline", " Shattered Star", " Avari's Wake", " Lodestar", " Silver Talon", " Banshee's Cry", " Long Haul", " Smoldering Flame", " Beowulf", " Lost Fortune", " Sovereign Skies", " Bloody Jaw", " Luminous Sorrow", " Sparrowhawk", " Broken Sword", " Manta", " Stardust", " Buccaneer", " Mercy", " Starfall", " Cerelis Nine", " Mutara", " Stellar Hawk", " Clarion Call", " Nebula Prowler", " Stormswept", " Dawn's Herald", " Newton's Folly", " Sundered Aegis", " Dead Reckoning", " Nightfall", " Sundown", " Drift Runner", " Nomad", " Sureshot", " Eclipse", " Obsidian Trident", " Terminus Clipper", " Elara Five", " Onslaught", " Terrapin", " Enchantress", " Orca", " Timber Wolf", " Endurance", " Outward Bound", " Tip of the Spear", " Excalibur", " Phantom", " Titan", " Eye of the Void", " Photon", " Tormentor", " Fall of Icarus", " Poltergeist", " Trithia Six", " Fallen Light", " Profit Margin", " Ultraviolet", " False Hope", " Raven's Call", " Valora's Comet", " Firebreak", " Raya's Promise", " Vengeance", " First Light", " Reaper", " Venture", " Forge Flier", " Reforged Hope", " Vigilant", " Fortune's Favor", " Relentless", " Voidtreader", " Freya’s Wrath", " Royal Signet", " Vulture", "Ghost", " Guiding Star", " Hand of Fate", "Herald of Doom", "Implacable", "Implicit", "Inferno"]
            return list.shuffled()[0].capitalized
        }
        
        if nameFormat == 0 {
            name = getName()
        }

        return name
    }
    var missionList = ["Blockade a location", "Break a blockade", "Collect a resource", "Command others", "Conduct diplomacy", "Conduct espionage", "Conduct piracy", "Conduct research", "Defend against an attack", "Deliver messages or data", "Establish a settlement", "Evacuate a location", "Explore a region", "Hold prisoners", "Hunt down another ship", "Launch an attack", "Patrol an area", "Provide medical aid", "Provide repairs", "Provide shelter", "Quarantine a danger", "Raid a settlement", "Resupply a settlement", "Retrieve salvage", "Search and rescue", "Smuggle cargo", "Survey a site", "Test a technology", "Transport cargo", "Transport passengers"]
    func randomMission(region: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch region {
        case "Terminus" :
            dictionary = [
                "Blockade a location" : 3,
                "Break a blockade" : 3,
                "Collect a resource" : 3,
                "Command others" : 2,
                "Conduct diplomacy" : 3,
                "Conduct espionage" : 3,
                "Conduct piracy" : 3,
                "Conduct research" : 3,
                "Defend against an attack" : 3,
                "Deliver messages or data" : 3,
                "Establish a settlement" : 3,
                "Evacuate a location" : 3,
                "Explore a region" : 2,
                "Hold prisoners" : 2,
                "Hunt down another ship" : 3,
                "Launch an attack" : 3,
                "Patrol an area" : 3,
                "Provide medical aid" : 3,
                "Provide repairs" : 3,
                "Provide shelter" : 3,
                "Quarantine a danger" : 2,
                "Raid a settlement" : 3,
                "Resupply a settlement" : 3,
                "Retrieve salvage" : 3,
                "Search and rescue" : 3,
                "Smuggle cargo" : 3,
                "Survey a site" : 3,
                "Test a technology" : 2,
                "Transport cargo" : 3,
                "Transport passengers" : 3,
                "\(oracle.action()) + \(oracle.theme())" : 5,
                "Roll twice" : 10,
            ]
        case "Outlands" :
            dictionary = [
                "Blockade a location" : 2,
                "Break a blockade" : 2,
                "Collect a resource" : 3,
                "Command others" : 2,
                "Conduct diplomacy" : 2,
                "Conduct espionage" : 2,
                "Conduct piracy" : 3,
                "Conduct research" : 4,
                "Defend against an attack" : 4,
                "Deliver messages or data" : 4,
                "Establish a settlement" : 4,
                "Evacuate a location" : 4,
                "Explore a region" : 4,
                "Hold prisoners" : 2,
                "Hunt down another ship" : 3,
                "Launch an attack" : 3,
                "Patrol an area" : 2,
                "Provide medical aid" : 3,
                "Provide repairs" : 3,
                "Provide shelter" : 3,
                "Quarantine a danger" : 2,
                "Raid a settlement" : 3,
                "Resupply a settlement" : 4,
                "Retrieve salvage" : 3,
                "Search and rescue" : 2,
                "Smuggle cargo" : 2,
                "Survey a site" : 3,
                "Test a technology" : 2,
                "Transport cargo" : 3,
                "Transport passengers" : 2,
                "\(oracle.action()) + \(oracle.theme())" : 5,
                "Roll twice" : 10,
            ]
        case "Expanse" :
            dictionary = [
                "Blockade a location" : 2,
                "Break a blockade" : 2,
                "Collect a resource" : 4,
                "Command others" : 2,
                "Conduct diplomacy" : 2,
                "Conduct espionage" : 2,
                "Conduct piracy" : 2,
                "Conduct research" : 6,
                "Defend against an attack" : 4,
                "Deliver messages or data" : 4,
                "Establish a settlement" : 6,
                "Evacuate a location" : 4,
                "Explore a region" : 6,
                "Hold prisoners" : 2,
                "Hunt down another ship" : 2,
                "Launch an attack" : 2,
                "Patrol an area" : 2,
                "Provide medical aid" : 2,
                "Provide repairs" : 2,
                "Provide shelter" : 4,
                "Quarantine a danger" : 2,
                "Raid a settlement" : 2,
                "Resupply a settlement" : 3,
                "Retrieve salvage" : 4,
                "Search and rescue" : 2,
                "Smuggle cargo" : 2,
                "Survey a site" : 2,
                "Test a technology" : 2,
                "Transport cargo" : 3,
                "Transport passengers" : 2,
                "\(oracle.action()) + \(oracle.theme())" : 5,
                "Roll twice" : 10,
            ]
        default:
            dictionary = [
                "Blockade a location" : 1,
                "Break a blockade" : 1,
                "Collect a resource" : 1,
                "Command others" : 1,
                "Conduct diplomacy" : 1,
                "Conduct espionage" : 1,
                "Conduct piracy" : 1,
                "Conduct research" : 1,
                "Defend against an attack" : 1,
                "Deliver messages or data" : 1,
                "Establish a settlement" : 1,
                "Evacuate a location" : 1,
                "Explore a region" : 1,
                "Hold prisoners" : 1,
                "Hunt down another ship" : 1,
                "Launch an attack" : 1,
                "Patrol an area" : 1,
                "Provide medical aid" : 1,
                "Provide repairs" : 1,
                "Provide shelter" : 1,
                "Quarantine a danger" : 1,
                "Raid a settlement" : 1,
                "Resupply a settlement" : 1,
                "Retrieve salvage" : 1,
                "Search and rescue" : 1,
                "Smuggle cargo" : 1,
                "Survey a site" : 1,
                "Test a technology" : 1,
                "Transport cargo" : 1,
                "Transport passengers" : 1,
                "\(oracle.action()) + \(oracle.theme())" : 4,
                "Roll twice" : 7,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var contactList = ["Familiar", "Friendly", "Neutral / automated", "Wary", "Dismissive", "Uncooperative", "Hostile", "Asking for help", "In battle", "Unresponsive", "Destroyed", "Derelict"]
    func randomContact() -> String {
        let dictionary = [
            "Familiar" : 3,
            "Friendly" : 12,
            "Neutral / automated" : 10,
            "Wary" : 10,
            "Dismissive" : 5,
            "Uncooperative" : 5,
            "Hostile" : 15,
            "Asking for help" : 15,
            "In battle" : 5,
            "Unresponsive" : 5,
            "Destroyed" : 5,
            "Derelict" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var firstLookList = ["Abnormal sensor readings", "Brightly painted", "Bristling with weapons", "Dark or stealthy", "Heavy armor", "Immobile", "Intimidating profile", "Large sensor arrays", "Leaking radiation", "Low-profile or disguised", "Modern or advanced design", "Obsolete design", "Obvious damage", "Biological components", "Ornate markings", "Oversized engines", "Prominent guild emblem", "Refitted or repurposed hull", "Scarred hull", "Built from scrap", "Towing or linked"]
    func randomFirstLook() -> String {
        let dictionary = [
            "Abnormal sensor readings" : 4,
            "Brightly painted" : 4,
            "Bristling with weapons" : 5,
            "Dark or stealthy" : 5,
            "Heavy armor" : 5,
            "Immobile" : 5,
            "Intimidating profile" : 5,
            "Large sensor arrays" : 4,
            "Leaking radiation" : 4,
            "Low-profile or disguised" : 4,
            "Modern or advanced design" : 4,
            "Obsolete design" : 5,
            "Obvious damage" : 5,
            "Biological components" : 4,
            "Ornate markings" : 4,
            "Oversized engines" : 4,
            "Prominent guild emblem" : 4,
            "Refitted or repurposed hull" : 5,
            "Scarred hull" : 5,
            "Built from scrap" : 5,
            "Towing or linked" : 4,
            "\(oracle.description()) + \(oracle.focus())" : 6,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var typeList = ["Carrier", "Corvette", "Courier", "Cruiser", "Dreadnought", "Escape pod", "Foundry", "Harvester", "Hauler", "Hunter", "Ironhome", "Mender", "Outbounder", "Pennant", "Prospector", "Reclaimer", "Shuttle", "Snub fighter", "Multipurpose", "Unusual or unknown", "Fleet", "Ships in conflict", "Unknown class"]
    func randomType() -> String {
        let dictionary = [
            "Carrier" : 2,
            "Corvette" : 4,
            "Courier" : 5,
            "Cruiser" : 3,
            "Dreadnought" : 2,
            "Escape pod" : 3,
            "Foundry" : 3,
            "Harvester" : 5,
            "Hauler" : 6,
            "Hunter" : 3,
            "Ironhome" : 2,
            "Mender" : 4,
            "Outbounder" : 5,
            "Pennant" : 3,
            "Prospector" : 6,
            "Reclaimer" : 5,
            "Shuttle" : 3,
            "Snub fighter" : 3,
            "Multipurpose" : 5,
            "Unusual or unknown" : 2,
            "Fleet: \(randomFleet())" : 10,
            "Ships in conflict (roll twice)" : 6,
        ]

        var pool: [String] = []

        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
    
    var fleetList = ["Battle fleet", "Pirate wing", "Raider horde", "Salvager hive", "Settler caravan", "Trade caravan", "Transport and escorts", "Unknown Fleet"]
    func randomFleet() -> String {
        let dictionary = [
            "Battle fleet" : 10,
            "Pirate wing" : 15,
            "Raider horde" : 10,
            "Salvager hive" : 15,
            "Settler caravan" : 10,
            "Trade caravan" : 10,
            "Transport and escorts" : 10,
            "Mission: \(randomMission(region: ""))" : 10,
        ]

        var pool: [String] = []

        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }

        var answer = pool.shuffled()

        return answer.popLast() ?? "error"
    }
}
