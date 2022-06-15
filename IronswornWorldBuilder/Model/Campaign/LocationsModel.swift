//
//  LocationsModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation


struct Location: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var hiddenDescription = false
    var description = ""
    var hiddenRank = false
    var rank = Rank.troublesome.rawValue
    var hiddenWaypoints = true
    var waypoints: [Location] = []
    var hiddenDomains = false
    var domains: [StringContainer] = [StringContainer(name: "Barrow")] {
        didSet {
            domainsSummary = ""
            for domain in domains {
                domainsSummary += "\(domain.name) "
            }
            subName = "\(themesSummary) \(domainsSummary)"
        }
    }
    var hiddenThemes = false
    var themes: [StringContainer] = [StringContainer(name: "Ancient")] {
        didSet {
            themesSummary = ""
            for theme in themes {
                themesSummary += "\(theme.name) "
            }
            subName = "\(themesSummary) \(domainsSummary)"
        }
    }
    var hiddenRoutes = true
    var routes: [Route] = []
    var subName = ""
    var mode = "Selection"
    var travelMode = false
    var oracle = Oracle.sharedOracle
    var themesSummary = ""
    var domainsSummary = ""
    var waitingForFaction = false
    var waitingForPerson = false
    var waitingForCreature = false
    var hiddenCreature = true
    var creatures: [Creature] = []
    var hiddenFactions = true
    var factions: [Faction] = []
    var hiddenPersons = true
    var persons: [Person] = []
    
    func locationName(domains: [String]) -> String {
        var result = ""
        var domain = domains.shuffled()
        let dom = domain.popLast()
        
        let nameFormat = randomFormat()
        
        switch nameFormat {
        case 0 : result = "\(description()) \(place(domain: dom ?? "no domain"))"
        case 1 : result = "\(place(domain: dom ?? "no domain")) of \(detail())"
        case 2 : result = "\(place(domain: dom ?? "no domain")) of \(description()) \(detail())"
        case 3 : result = "\(place(domain: dom ?? "no domain")) of \(namesake())'s \(detail())"
        case 4 : result = "\(namesake())'s \(place(domain: dom ?? "no domain"))"
        case 5 : result = "\(description()) \(place(domain: dom ?? "no domain")) of \(namesake())"
        case 6 : result = "\(place(domain: dom ?? "no domain")) of \(namesake())"
        default:
            result = "error location"
        }
        
        func randomFormat() -> Int {
            let dictionary = [
                0 : 25,
                1 : 25,
                2 : 20,
                3 : 10,
                4 : 5,
                5 : 5,
                6 : 5,
            ]
            
            var pool: [Int] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? 0
        }
        func description() -> String {
            let list = ["Deep", "Tainted", "Grey", "Forgotten", "Flooded", "Forbidden", "Barren", "Lost", "Cursed", "Fell", "Sunken", "Nightmare", "Infernal", "Dark", "Bloodstained", "Haunted", "White", "Shrouded", "Wasted", "Grim", "Endless", "Crumbling", "Undying", "Bloodied", "Forsaken", "Silent", "Blighted", "Iron", "Frozen", "Abyssal", "Crimson", "Silver", "Desecrated", "Ashen", "Elder", "Scorched", "Unknown", "Scarred", "Broken", "Chaotic", "Black", "Hidden", "Sundered", "Shattered", "Dreaded", "Secret", "High", "Sacred", "Fallen", "Ruined"]
            var newRoll = list.shuffled()
            return newRoll.popLast() ?? "Empty list ERROR"
        }
        func detail() -> String {
            let list = ["Blight", "Strife", "Nightfall", "Fury", "Terror", "Truth", "Spring", "Sanctuary", "Bone", "Specters", "Daybreak", "Doom", "Treachery", "Blood", "War", "Torment", "Iron", "Silence", "Mist", "Isolation", "Runes", "Rot", "Corruption", "Prophesy", "Fate", "Twilight", "Power", "Darkness", "Gloom", "Storms", "Hope", "Lament", "Frost", "Souls", "Winter", "Sadness", "Desolation", "Bane", "Lies", "Ash", "Banishment", "Shadow", "Madness", "Stone", "Secrets", "Despair", "Blades", "Dread", "Light", "Wrath"]
            var newRoll = list.shuffled()
            return newRoll.popLast() ?? "Empty list ERROR"
        }
        func namesake() -> String {
            let list = ["Breckon", "Kajir", "Farina", "Issara", "Saiven", "Yala", "Milenna", "Callwen", "Kodroth", "Thorval", "Zhan", "Morien", "Khulan", "Solana", "Akida", "Aurvang", "Ildar", "Haldorr", "Kalida", "Keelan", "Nyrad", "Keeara", "Thrain", "Edda", "Andor", "Kynan", "Jorund", "Zakaria", "Jadina", "Morraine", "Willa", "Radek", "Lindar", "Etana", "Wulan", "Sithra", "Valgard", "Garion", "Torgan", "Kenrick", "Eysa", "Arnorr", "Wyland", "Kolor", "Thyri", "Sidura", "Katarra", "Erisia", "Svala", "Dain"]
            var newRoll = list.shuffled()
            return newRoll.popLast() ?? "Empty list ERROR"
        }
        func place(domain: String) -> String {
            

            var dictionary: [String: Int] = [:]
            
            switch domain {
            case "Barrow" :
                dictionary = [
                    "Sepulcher" : 1,
                    "Grave" : 1,
                    "Crypt" : 1,
                    "Mound" : 1,
                    "Tomb" : 1,
                    "Barrow" : 1,
                ]
            case "Cavern" :
                dictionary = [
                    "Abyss" : 1,
                    "Caverns" : 1,
                    "Caves" : 1,
                    "Chasm" : 1,
                    "Depths" : 1,
                    "Hollow" : 1,
                    "Lair" : 1,
                    "Rift" : 1,
                    "Tunnels" : 1,
                    "Warren" : 1,
                ]
            case "Frozen cavern" :
                dictionary = [
                    "Abyss" : 1,
                    "Caverns" : 1,
                    "Caves" : 1,
                    "Chasm" : 1,
                    "Depths" : 1,
                    "Hollow" : 1,
                    "Lair" : 1,
                    "Rift" : 1,
                    "Tunnels" : 1,
                    "Warren" : 1,
                ]
            case "Icereach" :
                dictionary = [
                    "Icemark" : 1,
                    "Wintertide" : 1,
                    "Reach" : 1,
                    "Waste" : 1,
                    "Expanse" : 1,
                    "Barrens" : 1,
                ]
            case "Mine" :
                dictionary = [
                    "Lode" : 1,
                    "Dig" : 1,
                    "Forge" : 1,
                    "Mine" : 1,
                    "Tunnels" : 1,
                    "Cut" : 1,
                ]
            case "Pass" :
                dictionary = [
                    "Cliffs" : 1,
                    "Crag" : 1,
                    "Cut" : 1,
                    "Gap" : 1,
                    "Gorge" : 1,
                    "Heights" : 1,
                    "Highlands" : 1,
                    "Pass" : 1,
                    "Reach" : 1,
                    "Ridge" : 1,
                ]
            case "Ruin" :
                dictionary = [
                    "Enclave" : 1,
                    "Citadel" : 1,
                    "Fortress" : 1,
                    "Hall" : 1,
                    "Keep" : 1,
                    "Sanctuary" : 1,
                    "Sanctum" : 1,
                    "Spire" : 1,
                    "Temple" : 1,
                    "Tower" : 1,
                ]
            case "Sea Cave" :
                dictionary = [
                    "Caves" : 1,
                    "Channel" : 1,
                    "Cove" : 1,
                    "Hollow" : 1,
                    "Pools" : 1,
                    "Gouge" : 1,
                ]
            case "Shadowfen" :
                dictionary = [
                    "Bog" : 1,
                    "Fen" : 1,
                    "Lowland" : 1,
                    "Marsh" : 1,
                    "Mire" : 1,
                    "Morass" : 1,
                    "Quagmire" : 1,
                    "Floodlands" : 1,
                    "Slough" : 1,
                    "Wetlands" : 1,
                ]
            case "Stronghold" :
                dictionary = [
                    "Bastion" : 1,
                    "Citadel" : 1,
                    "Fortress" : 1,
                    "Garrison" : 1,
                    "Haven" : 1,
                    "Keep" : 1,
                    "Outpost" : 1,
                    "Refuge" : 1,
                    "Sanctuary" : 1,
                    "Watch" : 1,
                ]
            case "Tanglewood" :
                dictionary = [
                    "Weald" : 1,
                    "Tangle" : 1,
                    "Bramble" : 1,
                    "Briar" : 1,
                    "Thicket" : 1,
                    "Forest" : 1,
                    "Wilds" : 1,
                    "Wood" : 1,
                ]
            case "Underkeep" :
                dictionary = [
                    "Catacomb" : 1,
                    "Chambers" : 1,
                    "Den" : 1,
                    "Hall" : 1,
                    "Labyrinth" : 1,
                    "Maze" : 1,
                    "Pit" : 1,
                    "Sanctum" : 1,
                    "Underkeep" : 1,
                    "Vault" : 1,
                ]
            default:
                dictionary = [
                    "Domain error" : 1,
                ]
            }
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        
        
        return result
    }
    
}



