//
//  OracleModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 01.05.2022.
//

import Foundation

struct Oracle: Codable, Hashable {
    static let sharedOracle = Oracle()
    
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
    
// E X P L O R A T I O N
    // THEMES
    
    func chaoticThemeFeatureSF() -> String {
        let dictionary = [
            "Alterations in the flow of time" : 2,
            "Chaotic portal, focus, or conduit" : 2,
            "Corrupted or warped architecture or terrain" : 2,
            "Corrupted or warped environment or ecosystem" : 2,
            "Corrupted or warped technology" : 2,
            "Cryptic device harnesses or powers chaos" : 2,
            "Distortions of gravity or physics" : 2,
            "Energy field or barrier" : 2,
            "Glimpses of alternate realities" : 2,
            "Lifeforms mutated or altered by chaos" : 2,
            "Lifeforms spawned from chaos" : 2,
            "Visions of your past or future" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func chaoticThemePerilSF() -> String {
        let dictionary = [
            "Chaos makes its mark upon you" : 9,
            "Chaos spreads or intensifies" : 9,
            "Chaos tempts or lures you" : 9,
            "Chaotic energies block the path or assail you" : 9,
            "Disorienting changes in time or location" : 9,
            "Dreadful scene of those who fell prey to chaos" : 9,
            "Equipment is made unstable or dangerous" : 9,
            "Foes harness or wield chaos" : 9,
            "Hazardous environmental changes" : 9,
            "Lifeforms made hostile by chaos" : 9,
            "\(action()) + \(theme())" : 8,
            "Roll twice" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func chaoticThemeOpportunitySF() -> String {
        let dictionary = [
            "Chaos ebbs or withdraws for a time" : 1,
            "Chaos empowers you with strange but useful abilities" : 1,
            "Chaos manifests as comforting or inspiring visions" : 1,
            "Chaotic changes hamper your foes" : 1,
            "Insight into the source or nature of the chaos" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
}
