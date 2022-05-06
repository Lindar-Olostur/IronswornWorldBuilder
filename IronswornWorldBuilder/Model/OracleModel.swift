//
//  OracleModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 01.05.2022.
//

import Foundation

class Oracle: ObservableObject {
    
    func action() -> String {
        
        let list = ["Abandon", "Acquire", "Advance", "Affect", "Aid", "Arrive", "Assault", "Attack", "Avenge", "Avoid", "Await", "Begin", "Betray", "Bolster", "Breach", "Break", "Capture", "Challenge", "Change", "Charge", "Clash", "Command", "Communicate", "Construct", "Control", "Coordinate", "Create", "Debate", "Defeat", "Defend", "Deflect", "Defy", "Deliver", "Demand", "Depart", "Destroy", "Distract", "Eliminate", "Endure", "Escalate", "Escort", "Evade", "Explore", "Falter", "Find", "Finish", "Focus", "Follow", "Fortify", "Gather", "Guard", "Hide", "Hold", "Hunt", "Impress", "Initiate", "Inspect", "Investigate", "Journey", "Learn", "Leave", "Locate", "Lose", "Manipulate", "Mourn", "Move", "Oppose", "Overwhelm", "Persevere", "Preserve", "Protect", "Raid", "Reduce", "Refuse", "Reject", "Release", "Remove", "Research", "Resist", "Restore", "Reveal", "Risk", "Scheme", "Search", "Secure", "Seize", "Serve", "Share", "Strengthen", "Summon", "Support", "Suppress", "Surrender", "Swear", "Threaten", "Transform", "Uncover", "Uphold", "Weaken", "Withdraw",
        ]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func theme() -> String {
        
        let list = [ "Ability", "Advantage", "Alliance", "Authority", "Balance", "Barrier", "Belief", "Blood", "Bond", "Burden", "Commerce", "Community", "Corruption", "Creation", "Crime", "Culture", "Cure", "Danger", "Death", "Debt", "Decay", "Deception", "Defense", "Destiny", "Disaster", "Discovery", "Disease", "Dominion", "Dream", "Duty", "Enemy", "Expedition", "Faction", "Fame", "Family", "Fear", "Fellowship", "Freedom", "Greed", "Hardship", "Hate", "Health", "History", "Home", "Honor", "Hope", "Humanity", "Innocence", "Knowledge", "Labor", "Language", "Law", "Legacy", "Life", "Love", "Memory", "Nature", "Opportunity", "Passage", "Peace", "Phenomenon", "Possession", "Power", "Price", "Pride", "Prize", "Prophesy", "Protection", "Quest", "Relationship", "Religion", "Reputation", "Resource", "Revenge", "Rival", "Rumor", "Safety", "Sanctuary", "Secret", "Solution", "Spirit", "Stranger", "Strategy", "Strength", "Superstition", "Supply", "Survival", "Technology", "Time", "Tool", "Trade", "Truth", "Vengeance", "Vow", "War", "Warning", "Weakness", "Wealth", "Weapon", "World",
        ]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func description() -> String {
        
        let list = [ "Abandoned", "Abundant", "Active", "Advanced", "Alien", "Ancient", "Archaic", "Automated", "Barren", "Biological", "Blighted", "Blocked", "Breached", "Broken", "Captured", "Chaotic", "Civilized", "Collapsed", "Colossal", "Confined", "Conspicuous", "Constructed", "Contested", "Corrupted", "Created", "Damaged", "Dead", "Deadly", "Decaying", "Defended", "Depleted", "Desolate", "Destroyed", "Diverse", "Empty", "Engulfed", "Ensnaring", "Expansive", "Exposed", "Fiery", "Foreboding", "Forgotten", "Forsaken", "Fortified", "Foul", "Fragile", "Frozen", "Functional", "Grim", "Guarded", "Haunted", "Hidden", "High-Tech", "Hoarded", "Hostile", "Immersed", "Inaccessible", "Infested", "Inhabited", "Isolated", "Living", "Lost", "Lush", "Makeshift", "Mechanical", "Misleading", "Moving", "Mysterious", "Natural", "New", "Obscured", "Open", "Peaceful", "Perilous", "Pillaged", "Powerful", "Preserved", "Prominent", "Protected", "Radiant", "Rare", "Remote", "Rich", "Ruined", "Sacred", "Safe", "Sealed", "Secret", "Settled", "Stolen", "Strange", "Subsurface", "Toxic", "Trapped", "Undiscovered", "Unnatural", "Unstable", "Untamed", "Valuable", "Violent",
        ]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func focus() -> String {
        
        let list = [ "AI", "Alarm", "Anomaly", "Apparition", "Archive", "Art", "Artifact", "Atmosphere", "Battleground", "Beacon", "Being", "Blockade", "Boundary", "Cache", "Cargo", "Commodity", "Confinement", "Container", "Creature", "Crossing", "Data", "Debris", "Device", "Dimension", "Ecosystem", "Enclosure", "Energy", "Environment", "Equipment", "Facility", "Fleet", "Force", "Fortification", "Fuel", "Gas", "Grave", "Gravity", "Habitat", "Hazard", "Hideaway", "Home", "Illusion", "Industry", "Lair", "Lifeform", "Liquid", "Machine", "Material", "Mechanism", "Message", "Mineral", "Monument", "Network", "Obstacle", "Orbit", "Organism", "Path", "People", "Person", "Plant", "Portal", "Probe", "Reality", "Recording", "Refuge", "Relic", "Remains", "Rendezvous", "Resource", "Route", "Ruins", "Salvage", "Sector", "Settlement", "Shelter", "Shortcut", "Signal", "Sound", "Spacetime", "Starship", "Station", "Storage", "Storm", "Structure", "Supply", "Symbol", "System", "Technology", "Terrain", "Territory", "Transportation", "Trap", "Treasure", "Vault", "Vehicle", "Viewpoint", "Void", "Weapon", "World", "Wreckage",
        ]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    
    // Первый взгляд на поселение STARFORGED
    func settlementLook() -> String {
 
        let dictionary = [
            "eautiful architecture" : 3,
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
            "\(description()) + \(focus())" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    // Власть в поселении STARFORGED
    func settlementAuthtority() -> String {
 
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
    // Контакт с поселением STARFORGED
    func settlementContact() -> String {
 
        let dictionary = [
            "Welcoming" : 20,
            "Neutral / automated" : 10,
            "Wary" : 20,
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
    // Проблемы поселения STARFORGED
    func settlementTrouble() -> String {
 
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
            "\(action()) + \(theme())" : 10,
            "Roll twice" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    // Проекты поселения STARFORGED
    func settlementProjects() -> String {
 
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
            "Manufacturing" : 2,
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
            "\(action()) + \(theme())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
}
