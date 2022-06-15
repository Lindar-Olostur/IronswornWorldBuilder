//
//  OracleModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 01.05.2022.
//

import Foundation

enum Rank: String, Codable, Hashable, Equatable, CaseIterable {
    case troublesome
    case dangerous
    case formidable
    case extreme
    case epic
}

class movingBuffer {
    static let shared = movingBuffer()
    var starshipBuffer: [Starship] = [] // ^sector, stellarObject, settlement, planet^
    var settlementBuffer: [Settlement] = [] // ^sector, stellarObject, planet ^
    var personBuffer: [Person] = [] // ^settlement, faction, starship^
    var creatureBuffer: [Creature] = [] //^sector, planet, stellarObject, starship, settlement^
    var factionBuffer: [Faction] = [] // ^region, root, sector, stellarObject, planet, settlement, starship^
}

struct Oracle: Codable, Hashable {
    static let sharedOracle = Oracle()
    func ironlandersName() -> String {
        
        let list = ["Solana", "Keelan", "Cadigan", "Sola", "Kodroth", "Kione", "Katja", "Tio", "Artiga", "Eos", "Bastien", "Elli", "Maura", "Haleema", "Abella", "Morter", "Wulan", "Mai", "Farina", "Pearce", "Wynne", "Haf", "Aeddon", "Khinara", "Milla", "Nakata", "Kynan", "Kiah", "Jaggar", "Beca", "Ikram", "Melia", "Sidan", "Deshi", "Tessa", "Sibila", "Morien", "Mona", "Padma", "Avella", "Naila", "Lio", "Cera", "Ithela", "Zhan", "Kaivan", "Valeri", "Hirsham", "Pemba", "Edda", "Lestara", "Lago", "Elstan", "Saskia", "Kabeera", "Caldas", "Nisus", "Serene", "Chenda", "Themon", "Erin", "Alban", "Parcell", "Jelma", "Willa", "Nadira", "Gwen", "Amara", "Masias", "Kanno", "Razeena", "Mira", "Perella", "Myrick", "Qamar", "Kormak", "Zura", "Zanita", "Brynn", "Tegan", "Pendry", "Quinn", "Fanir", "Glain", "Emelyn", "Kendi", "Althus", "Leela", "Ishana", "Flint", "Delkash", "Nia", "Nan", "Keeara", "Katania", "Morell", "Temir", "Bas", "Sabine", "Tallus", "Segura", "Gethin", "Bataar", "Basira", "Joa", "Glynn", "Toran", "Arasen", "Kuron", "Griff", "Owena", "Adda", "Euros", "Kova", "Kara", "Morgan", "Nanda", "Tamara", "Asha", "Delos", "Torgan", "Makari", "Selva", "Kimura", "Rhian", "Tristan", "Siorra", "Sayer", "Cortina", "Vesna", "Kataka", "Keyshia", "Mila", "Lili", "Vigo", "Sadia", "Malik", "Dag", "Kuno", "Reva", "Kai", "Kalina", "Jihan", "Hennion", "Abram", "Aida", "Myrtle", "Nekun", "Menna", "Tahir", "Sarria", "Nakura", "Akiya", "Talan", "Mattick", "Okoth", "Khulan", "Verena", "Beltran", "Del", "Ranna", "Alina", "Muna", "Mura", "Torrens", "Yuda", "Nazmi", "Ghalen", "Sarda", "Shona", "Kalidas", "Wena", "Sendra", "Kori", "Setara", "Lucia", "Maya", "Reema", "Yorath", "Rhoddri", "Shekhar", "Servan", "Reese", "Kenrick", "Indirra", "Giliana", "Jebran", "Kotama", "Fara", "Katrin", "Namba", "Lona", "Taylah", "Kato", "Esra", "Eleri", "Irsia", "Kayu", "Bevan", "Chandra", "Solana", "Keelan", "Cadigan", "Sola", "Kodroth", "Kione", "Katja", "Tio", "Artiga", "Eos", "Bastien", "Elli", "Maura", "Haleema", "Abella", "Morter", "Wulan", "Mai", "Farina", "Pearce", "Wynne", "Haf", "Aeddon", "Khinara", "Milla", "Nakata", "Kynan", "Kiah", "Jaggar", "Beca", "Ikram", "Melia", "Sidan", "Deshi", "Tessa", "Sibila", "Morien", "Mona", "Padma", "Avella", "Naila", "Lio", "Cera", "Ithela", "Zhan", "Kaivan", "Valeri", "Hirsham", "Pemba", "Edda", "Lestara", "Lago", "Elstan", "Saskia", "Kabeera", "Caldas", "Nisus", "Serene", "Chenda", "Themon", "Erin", "Alban", "Parcell", "Jelma", "Willa", "Nadira", "Gwen", "Amara", "Masias", "Kanno", "Razeena", "Mira", "Perella", "Myrick", "Qamar", "Kormak", "Zura", "Zanita", "Brynn", "Tegan", "Pendry", "Quinn", "Fanir", "Glain", "Emelyn", "Kendi", "Althus", "Leela", "Ishana", "Flint", "Delkash", "Nia", "Nan", "Keeara", "Katania", "Morell", "Temir", "Bas", "Sabine", "Tallus", "Segura", "Gethin", "Bataar", "Basira", "Joa", "Glynn", "Toran", "Arasen", "Kuron", "Griff", "Owena", "Adda", "Euros", "Kova", "Kara", "Morgan", "Nanda", "Tamara", "Asha", "Delos", "Torgan", "Makari", "Selva", "Kimura", "Rhian", "Tristan", "Siorra", "Sayer", "Cortina", "Vesna", "Kataka", "Keyshia", "Mila", "Lili", "Vigo", "Sadia", "Malik", "Dag", "Kuno", "Reva", "Kai", "Kalina", "Jihan", "Hennion", "Abram", "Aida", "Myrtle", "Nekun", "Menna", "Tahir", "Sarria", "Nakura", "Akiya", "Talan", "Mattick", "Okoth", "Khulan", "Verena", "Beltran", "Del", "Ranna", "Alina", "Muna", "Mura", "Torrens", "Yuda", "Nazmi", "Ghalen", "Sarda", "Shona", "Kalidas", "Wena", "Sendra", "Kori", "Setara", "Lucia", "Maya", "Reema", "Yorath", "Rhoddri", "Shekhar", "Servan", "Reese", "Kenrick", "Indirra", "Giliana", "Jebran", "Kotama", "Fara", "Katrin", "Namba", "Lona", "Taylah", "Kato", "Esra", "Eleri", "Irsia", "Kayu", "Bevan", "Chandra"]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func randomAction() -> String {

        let list = ["Block a path or cut off an objective", "Cause reckless damage", "Change weapons or tactics", "Compel a surrender or concession", "Coordinate with allies", "Corner trap or entangle", "Counter or reflect an attack", "Create a distraction", "Destroy something or render it useless", "Fall back or stand off", "Hide or sneak", "Intimidate taunt or frighten", "Leverage the advantage of a weapon or ability", "Leverage the terrain or surroundings", "Lure into a vulnerable position", "Make a cautious or probing attack", "Make a ferocious or powerful attack", "Make a precise or careful attack", "Make a sacrificial attack", "Make an indirect attack", "Move in close or grapple", "Nullify a system device or weapon", "Overrun a position", "Perform a feint or trick", "Press an advantage", "Provoke a careless response", "Ready a decisive action", "Shift the fight to a new area", "Summon aid or reinforcements", "Take cover or bolster defenses", "Use an unexpected weapon or ability", "Weaken defenses", "Roll twice"]

        var answer = list.shuffled()
        return answer.popLast() ?? "error"
    }
    
    func payThePrice() -> String {
        
        let dictionary = [
            "A trusted individual or community acts against you" : 2,
            "An individual or community you care about is exposed to danger" : 2,
            "You encounter signs of a looming threat" : 3,
            "You create an opportunity for an enemy" : 3,
            "You face a tough choice" : 4,
            "You face the consequences of an earlier choice" : 4,
            "A surprising development complicates your quest" : 4,
            "You are separated from something or someone" : 4,
            "Your action causes collateral damage or has an unintended effect" : 6,
            "Something of value is lost or destroyed" : 6,
            "The environment or terrain introduces a new hazard" : 6,
            "A new enemy is revealed" : 6,
            "A friend companion or ally is in harm’s way (or you are if alone)" : 6,
            "Your equipment or vehicle malfunctions" : 6,
            "Your vehicle suffers damage" : 6,
            "You waste resources" : 6,
            "You are harmed" : 7,
            "You are stressed" : 7,
            "You are delayed or put at a disadvantage" : 7,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
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
        
        let list = ["Abandoned", "Abundant", "Active", "Advanced", "Alien", "Ancient", "Archaic", "Automated", "Barren", "Biological", "Blighted", "Blocked", "Breached", "Broken", "Captured", "Chaotic", "Civilized", "Collapsed", "Colossal", "Confined", "Conspicuous", "Constructed", "Contested", "Corrupted", "Created", "Damaged", "Dead", "Deadly", "Depleted", "Misleading", "Mysterious", "Desolate", "Destroyed", "Diverse", "Empty", "Ensnaring", "Expansive", "Exposed", "Fiery", "Foreboding", "Forgotten", "Forsaken", "Fortified", "Foul", "Fragile", "Frozen", "Functional", "Grim", "Guarded", "Haunted", "Hidden", "Hoarded", "Hostile", "Immersed", "Inaccessible", "Infested", "Inhabited", "Isolated", "Living", "Lost", "Lush", "Makeshift", "Mechanical", "Decaying", "Moving", "Natural", "New", "Obscured", "Open", "Peaceful", "Pillaged", "Powerful", "Preserved", "Prominent", "Protected", "Radiant", "Rare", "Remote", "Rich", "Ruined", "Sacred", "Safe", "Sealed", "Secret", "Settled", "Shrouded", "Stolen", "Strange", "Subsurface", "Toxic", "Trapped", "Undiscovered", "Unnatural", "Unstable", "Untamed", "Valuable", "Violent", "Defended", "Engulfed"]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func focus() -> String {
        
        let list = ["Alarm", "Anomaly", "Apparition", "Archive", "Art", "Artifact", "Atmosphere", "Battleground", "Beacon", "Being", "Blockade", "Boundary", "Cache", "Cargo", "Commodity", "Confinement", "Connection", "Container", "Creation", "Creature", "Crossing", "Data", "Debris", "Device", "Dimension", "Discovery", "Ecosystem", "Enclosure", "Environment", "Equipment", "Reality", "Remains", "Experiment", "Facility", "Faction", "Fleet", "Fortification", "Gas", "Grave", "Habitat", "Hazard", "Hideaway", "Home", "Illusion", "Industry", "Intelligence", "Lair", "Lifeform", "Liquid", "Machine", "Material", "Mechanism", "Message", "Mineral", "Monument", "Obstacle", "Organism", "Outbreak", "Outpost", "Path", "People", "Person", "Plant", "Portal", "Energy", "Refuge", "Rendezvous", "Resource", "Route", "Ruins", "Settlement", "Shelter", "Ship", "Shortcut", "Signal", "Sound", "Storage", "Storm", "Structure", "Supply", "Symbol", "System", "Technology", "Terrain", "Territory", "Threshold", "Time", "Transport", "Trap", "Treasure", "Vault", "Vehicle", "Viewpoint", "Void", "Weapon", "World", "Wreckage", "Relic", "Force"]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    
    func actionIS() -> String {
        
        let list = ["Scheme", "Clash", "Weaken", "Initiate", "Create", "Swear", "Avenge", "Guard", "Defeat", "Control", "Break", "Risk", "Surrender", "Inspect", "Raid", "Evade", "Assault", "Deflect", "Threaten", "Attack", "Leave", "Preserve", "Manipulate", "Remove", "Eliminate", "Withdraw", "Abandon", "Investigate", "Hold", "Focus", "Uncover", "Breach", "Aid", "Uphold", "Falter", "Suppress", "Hunt", "Share", "Destroy", "Avoid", "Reject", "Demand", "Explore", "Bolster", "Seize", "Mourn", "Reveal", "Gather", "Defy", "Transform", "Persevere", "Serve", "Begin", "Move", "Coordinate", "Resist", "Await", "Impress", "Take", "Oppose", "Capture", "Overwhelm", "Challenge", "Acquire", "Protect", "Finish", "Strengthen", "Restore", "Advance", "Command", "Refuse", "Find", "Deliver", "Hide", "Fortify", "Betray", "Secure", "Arrive", "Affect", "Change", "Defend", "Debate", "Support", "Follow", "Construct", "Locate", "Endure", "Release", "Lose", "Reduce", "Escalate", "Distract", "Journey", "Escort", "Learn", "Communicate", "Depart", "Search", "Charge", "Summon"]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    func themeIS() -> String {
        
        let list = ["Risk", "Ability", "Price", "Ally", "Battle", "Safety", "Survival", "Weapon", "Wound", "Shelter", "Leader", "Fear", "Time", "Duty", "Secret", "Innocence", "Renown", "Direction", "Death", "Honor", "Labor", "Solution", "Tool", "Balance", "Love", "Barrier", "Creation", "Decay", "Trade", "Bond", "Hope", "Superstition", "Peace", "Deception", "History", "World", "Vow", "Protection", "Nature", "Opinion", "Burden", "Vengeance", "Opportunity", "Faction", "Danger", "Corruption", "Freedom", "Debt", "Hate", "Possession", "Stranger", "Passage", "Land", "Creature", "Disease", "Advantage", "Blood", "Language", "Rumor", "Weakness", "Greed", "Family", "Resource", "Structure", "Dream", "Community", "War", "Portent", "Prize", "Destiny", "Momentum", "Power", "Memory", "Ruin", "Mysticism", "Rival", "Problem", "Idea", "Revenge", "Health", "Fellowship", "Enemy", "Religion", "Spirit", "Fame", "Desolation", "Strength", "Knowledge", "Truth", "Quest", "Pride", "Loss", "Law", "Path", "Warning", "Relationship", "Wealth", "Home", "Strategy", "Supply",
        ]
        
        var pool: [String] = []
        
        for value in list {
            pool.append(value)
        }
        
        var answer = pool.shuffled()
        return answer.popLast() ?? "error"
    }
    
// E X P L O R A T I O N
    // STARFORGED THEMES
        //CHAOTIC
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
    
        //FORTIFIED
    func fortifiedThemeFeatureSF() -> String {
        let dictionary = [
            "Captives or prisoners" : 2,
            "Control area or terminal" : 2,
            "Empty or inactive area" : 2,
            "Enemy forces assembled for an event" : 2,
            "Enemy forces offduty or at leisure" : 2,
            "Enemy forces on guard" : 2,
            "Enemy forces on patrol" : 2,
            "Enemy forces transporting supplies or equipment" : 2,
            "Enemy leader makes an inspection" : 2,
            "Prototype technology or equipment" : 2,
            "Robotic assistant or watchful AI" : 2,
            "Support personnel at work" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func fortifiedThemePerilSF() -> String {
        let dictionary = [
            "Alarm is triggered" : 9,
            "Automated security or weapons target you" : 9,
            "Checkpoint or path with restricted access" : 9,
            "Enemies converge on this area" : 9,
            "Enemies reveal new capabilities or technology" : 9,
            "Enemies trick you or lure you into a trap" : 9,
            "Powerful enemy appears" : 9,
            "Problematic alliance or affiliation is revealed" : 9,
            "Revealed schemes of an enemy leader create new urgency" : 9,
            "Your plan is undone by an unexpected complication" : 9,
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
    func fortifiedThemeOpportunitySF() -> String {
        let dictionary = [
            "Insight into the plans or methods of the enemy force" : 1,
            "Opening to get the drop on an enemy" : 1,
            "Opening to outmaneuver or escape enemies" : 1,
            "Potential collaborator or informant reveals themselves" : 1,
            "Access to useful equipment or weapons" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }

        //HAUNTED
    func hauntedThemeFeatureSF() -> String {
        let dictionary = [
            "Disembodied voices" : 2,
            "Eerie cold" : 2,
            "Foreboding omen or message" : 2,
            "Ghostly visions of this place in another time" : 2,
            "Glimpses of shadowy movement" : 2,
            "Objects move of their own accord" : 2,
            "Sensation of being watched" : 2,
            "Signs of death or violence" : 2,
            "Spectral sounds" : 2,
            "Twisted or altered architecture or terrain" : 2,
            "Unnatural blight decay or ruin" : 2,
            "Unnatural mists or darkness" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func hauntedThemePerilSF() -> String {
        let dictionary = [
            "Assailed by an angry or vengeful being" : 9,
            "Beguiling illusions tempt you to linger or stay" : 9,
            "Besieged by frightening sensations" : 9,
            "Equipment is plagued by unexplainable malfunctions" : 9,
            "Plunged into disorienting darkness or illusionary surroundings" : 9,
            "Spectral manifestations of your fears" : 9,
            "Spirits or undead reveal surprising abilities or motivations" : 9,
            "Sudden shocking reveal of a ghostly manifestation or undead form" : 9,
            "Trickery leads you into danger" : 9,
            "Visions reveal a horrifying aspect of this place" : 9,
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
    func hauntedThemeOpportunitySF() -> String {
        let dictionary = [
            "Encounter with a benign spirit or being" :1,
            "Helpful vision of past events" :1,
            "Message or clue offers insight into the nature of this haunting" :1,
            "Secret area or path is revealed" :1,
            "Useful or interesting artifact or device" :1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
        //INFESTED
    func infestedThemeFeatureSF() -> String {
        let dictionary = [
            "Corpse of an unfortunate victim" :2,
            "Eggs cocoons or nest" :2,
            "Environment corrupted by the infestation" :2,
            "Evidence of a lurking creature" :2,
            "Evidence of an illfated victim" :2,
            "Hoarded food" :2,
            "Indistinct movement or sounds" :2,
            "Lair of lesser creatures" :2,
            "Ravaged supplies or equipment" :2,
            "Remains of a creature or remnants of a previous form" :2,
            "Territorial markings" :2,
            "Trail or evidence of a creature’s passage" :2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func infestedThemePerilSF() -> String {
        let dictionary = [
            "Creatures attack without warning" : 9,
            "Creatures guided or controlled by a greater threat" : 9,
            "Creatures reveal new aspects or abilities" : 9,
            "Creatures reveal surprising cleverness" : 9,
            "Creatures take or destroy something important" : 9,
            "Discovery of a live but threatened victim" : 9,
            "Hazardous architecture or terrain" : 9,
            "Lured or driven into a trap or deadend" : 9,
            "Powerful or dominant creature reveals itself" : 9,
            "Toxic or sickening environment" : 9,
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
    func infestedThemeOpportunitySF() -> String {
        let dictionary = [
            "Clue to the nature or vulnerabilities of these creatures" : 1,
            "Creatures turn on each other" : 1,
            "Early warning of an attack or ambush" : 1,
            "External event provides a helpful distraction" : 1,
            "Helpful resource or equipment" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
        //INHABITED
    func inhabitedThemeFeatureSF() -> String {
        let dictionary = [
            "Conspicuous patrols or surveillance" : 2,
            "Crews at work" : 2,
            "Display or monument honors a notable cultural event" : 2,
            "Emergency teams responding to an incident or crisis" : 2,
            "Families gathering or children playing" : 2,
            "Festival celebration or observance" : 2,
            "Fight breaks out" : 2,
            "Notable figure stands out from the crowd" : 2,
            "Protest or strike" : 2,
            "Unrepaired damage" : 2,
            "Unusually empty or quiet area" : 2,
            "Vendor or merchant hawking their wares" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func inhabitedThemePerilSF() -> String {
        let dictionary = [
            "Announcement or notification brings harrowing news" : 9,
            "Arrival of a foe or rival" : 9,
            "Blockade or security cordon cuts off needed access" : 9,
            "Caught in the crossfire of a dispute" : 9,
            "Disturbing evidence of exploitive conditions" : 9,
            "Lured into danger" : 9,
            "Signs of disease infestation or toxic environment" : 9,
            "Signs of unrest or rebellion" : 9,
            "Signs that you are being watched or followed" : 9,
            "Unwanted attention from authority or enemies" : 9,
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
    func inhabitedThemeOpportunitySF() -> String {
        let dictionary = [
            "Intriguing offer from an unexpected source" : 1,
            "Lively festival or gathering place provides a chance to socialize" : 1,
            "Local gossip proves interesting or helpful" : 1,
            "Needed item, resource, or buyer is available" : 1,
            "Old friend or connection resurfaces" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
        //MECHANICAL
    func mechanicalThemeFeatureSF() -> String {
        let dictionary = [
            "Control station or terminal" : 2,
            "Device or technology with a mysterious function" : 2,
            "Disassembled machinery or parts" : 2,
            "Heavy machinery at work" : 2,
            "Machine fabrication or repair" : 2,
            "Machines emulating or fusing with biological life" : 2,
            "Machines in stasis or powered down" : 2,
            "Machines singlemindedly executing a function or program" : 2,
            "Major project under construction" : 2,
            "Mechanical environment in motion or transforming" : 2,
            "Mechanical wreckage or destruction" : 2,
            "Power source for the machines" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func mechanicalThemePerilSF() -> String {
        let dictionary = [
            "Alarm or warning is triggered" : 9,
            "Automated weapon or trap is activated" : 9,
            "Environment made unsuitable for life" : 9,
            "Hostile machines on patrol" : 9,
            "Machines transform to reveal new capabilities" : 9,
            "Machines with corrupted or hacked programming" : 9,
            "Malfunctioning machines or technology" : 9,
            "Moving machinery creates a danger or obstacle" : 9,
            "Under surveillance by a central machine intelligence" : 9,
            "Volatile technology" : 9,
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
    func mechanicalThemeOpportunitySF() -> String {
        let dictionary = [
            "Helpful device" : 1,
            "Insight into the workings or purpose of the machines" : 1,
            "Intelligent machine offers aid" : 1,
            "Salvageable resource" : 1,
            "Wondrous technology" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
        //RUINED
    func ruinedThemeFeatureSF() -> String {
        let dictionary = [
            "Collapsed or broken structures or terrain" : 2,
            "Device or artifact with residual power or function" : 2,
            "Focal point or nexus of the destruction" : 2,
            "Graves or corpses" : 2,
            "Innermost or hidden spaces laid bare by the destruction" : 2,
            "Message or recording from before the fall" : 2,
            "Overgrown or entombed spaces" : 2,
            "Rubblestrewn paths" : 2,
            "Sad memento of a lost life" : 2,
            "Sights or sounds of structural instability" : 2,
            "Signs of looting or scavenging" : 2,
            "Survivors or guardians dwell among the ruins" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func ruinedThemePerilSF() -> String {
        let dictionary = [
            "Dreadful atmosphere of loss and destruction weighs upon you" : 9,
            "Evidence of a horrible fate for others who passed this way" : 9,
            "Hazardous atmosphere or environment" : 9,
            "Hostile creature has staked out their territory" : 9,
            "Imminent collapse or destruction" : 9,
            "Lured into a trap or targeted by automated defenses" : 9,
            "Source of the destruction persists or returns anew" : 9,
            "Unearthed secrets best left buried" : 9,
            "Unstable or broken path" : 9,
            "Volatile device or artifact" : 9,
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
    func ruinedThemeOpportunitySF() -> String {
        let dictionary = [
            "Access to an untouched or preserved area" : 1,
            "Insight into what brought this place to ruin" : 1,
            "Interesting or useful device or artifact" : 1,
            "Salvageable equipment or resources" : 1,
            "Shortcut or passage through the destruction" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
        //SACRED
    func sacredThemeFeatureSF() -> String {
        let dictionary = [
            "Adherents performing worship or enacting rituals" : 2,
            "Altar or temple" : 2,
            "Dwellings for the faithful" : 2,
            "Enigmatic symbols" : 2,
            "Graves or remains of glorified disciples" : 2,
            "Holy text or archives" : 2,
            "Offerings or atonements" : 2,
            "Pilgrims arriving to pay homage" : 2,
            "Protected reliquary of an artifact or token" : 2,
            "Religious art or idols" : 2,
            "Subtle manifestations of mystical power or visions" : 2,
            "Tokens or motifs representing the faith’s domain" : 2,
            "\(description()) + \(focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func sacredThemePerilSF() -> String {
        let dictionary = [
            "An aspect of the faith beguiles you or lures you into danger" : 9,
            "Dreadful aspects or powers of the faith are revealed" : 9,
            "Embodiment of a god or power is given corrupted form or purpose" : 9,
            "Guardians seek martyrdom in defense of this place" : 9,
            "Leaders corrupt or exploit their followers to oppose you" : 9,
            "Prophecies portend a dire threat" : 9,
            "Protective ward or enigmatic puzzle blocks the way" : 9,
            "Religious artifact evokes unnerving power" : 9,
            "Unnatural corruption or decay fouls the environment" : 9,
            "Zealots enact a ceremony to unlock forbidden powers" : 9,
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
    func sacredThemeOpportunitySF() -> String {
        let dictionary = [
            "Access to a hidden or sealed area" : 1,
            "Encounter with a helpful adherent or heretic" : 1,
            "Insight into the nature or history of the faith" : 1,
            "Insight into the schemes or methods of religious zealots" : 1,
            "Interesting or valuable artifact or device" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    // D E L V E
    // THEMES
        // ANCIENT
    var ancientThemeFeatureDelve = [
        "Evidence of lost knowledge" : 4,
        "Inscrutable relics" : 4,
        "Ancient artistry or craft" : 4,
        "Preserved corpses or fossils" : 4,
        "Visions of this place in another time" : 4,
    ]
    var ancientThemeDangerDelve = [
        "Ancient trap" : 5,
        "Hazardous architecture or terrain" : 5,
        "Blocked or broken path" : 2,
        "Denizen protects an ancient secret" : 2,
        "Denizen reveres an ancient power" : 2,
        "Living relics of a lost age" : 2,
        "Ancient evil resurgent" : 2,
        "Dire warnings of a long-buried danger" : 2,
        "Ancient desease or contamination" : 2,
        "Artifact of terrible meaning or power" : 2,
        "Disturbing evidence of ancient wrongs" : 2,
        "Others seek power or knowledge" : 2,
    ]
    
        // CORRUPTED
    var corruptedThemeFeatureDelve = [
        "Mystic focus or conduit" : 4,
        "Strange environmental disturbances" : 4,
        "Mistyc runes or markings" : 4,
        "Blight or decay" : 4,
        "Evidence of a foul ritual" : 4,
    ]
    var corruptedThemeDangerDelve = [
        "Denizen spawned from dark magic" : 5,
        "Denizen controls dark magic" : 5,
        "Denizen corrupted by dark magic" : 2,
        "Corruption marks you" : 2,
        "Innosents held in thrall" : 2,
        "Revelations of a terrible truth" : 2,
        "Mistyc trap or trigger" : 2,
        "Mystic barrier or ward" : 2,
        "Illusions lead you astray" : 2,
        "Dark ritual in progress" : 2,
        "Lingering effects of a dark ritual" : 2,
        "Dread harbingers of a greater magic" : 2,
    ]
    
        //FORTIFIED
    var fortifiedThemeFeatureDelve = [
        "Camp or quarters" : 4,
        "Guarded location" : 4,
        "Storage or ripository" : 4,
        "Work or training area" : 4,
        "Command center or leadership" : 4,
    ]
    var fortifiedThemeDangerDelve = [
        "Denizen patrols the area" : 5,
        "Denizen on guard" : 5,
        "Denizen ready to sound the alarm" : 2,
        "Denizen sets an ambush" : 2,
        "Denizen lures you into a trap" : 2,
        "Denizens converge on this area" : 2,
        "Pets or underlings" : 2,
        "Unexpected alliance revealed" : 2,
        "Nefarious plans revealed" : 2,
        "Unexpected leader revealed" : 2,
        "Trap" : 2,
        "Alarm trigger" : 2,
    ]
    
        //HALLOWED
    var hallowedThemeFeatureDelve = [
        "Temple or altar" : 4,
        "Offerings or atonements" : 4,
        "Religious relic or idol" : 4,
        "Consecrated ground" : 4,
        "Dwellings or gathering place" : 4,
    ]
    var hallowedThemeDangerDelve = [
        "Denizen defends their sanctum" : 5,
        "Denizen enacts the will of their god" : 5,
        "Denizen seeks martyrdom" : 2,
        "Secret of the faith is revealed" : 2,
        "Greater purpose are revealed" : 2,
        "Unexpected disciples are revealed" : 2,
        "Divine manifeststions" : 2,
        "Aspect of the faith beguiles you" : 2,
        "Unexpected leader is revealed" : 2,
        "Embodiment of a god or myth" : 2,
        "Protective ward or barrier" : 2,
        "Prophecies reveal a dark fate" : 2,
    ]
    
        //HAUNTED
    var hauntedThemeFeatureDelve = [
        "Tomb or burial site" : 4,
        "Blood was spilled here" : 4,
        "Unnatural mists or darkness" : 4,
        "Messages from beyond the grave" : 4,
        "Apparitions of a person or event" : 4,
    ]
    var hauntedThemeDangerDelve = [
        "Denizen haunts this area" : 5,
        "Unsettling sounds or foreboding signs" : 5,
        "Denizen attacks withiut warning" : 2,
        "Denizen makes a costly demand" : 2,
        "Denizen seizes your body or mind" : 2,
        "Denizen taunts or lures you" : 2,
        "A disturbing truth is revealed" : 2,
        "Frightening visions" : 2,
        "The environment is used against you" : 2,
        "Trickery leads you astray" : 2,
        "True nature of this place is revealed" : 2,
        "Sudden, shocking manifestation" : 2,
    ]
    
        //INFESTED
    var infestedThemeFeatureDelve = [
        "Inhabited nest" : 4,
        "Abandoned nest" : 4,
        "Ravaged terrain or architecture" : 4,
        "Remains or carrion" : 4,
        "Hoarded food" : 4,
    ]
    var infestedThemeDangerDelve = [
        "Denizens swarm and attack" : 5,
        "Toxic or sickening environment" : 5,
        "Denizen stalks you" : 2,
        "Denizen takes or destroys something" : 2,
        "Denizen reveals surprising cleverness" : 2,
        "Denizen guided by a greater threat" : 2,
        "Denizen blocks the path" : 2,
        "Denizen funnels you down a new path" : 2,
        "Denizen undermines the path" : 2,
        "Denizen lays in wait" : 2,
        "Trap or snare" : 2,
        "Victim’s horrible fate is revealed" : 2,
    ]
    
        //RAVAGED
    var ravagedThemeFeatureDelve = [
        "Path of destruction" : 4,
        "Abandoned or ruined dwelling" : 4,
        "Untouched or preserved area" : 4,
        "Traces of what was lost" : 4,
        "Ill-fated victims" : 4,
    ]
    var ravagedThemeDangerDelve = [
        "Precarious architecture or terrain" : 5,
        "Imminent collapse or destruction" : 5,
        "Path undermined" : 2,
        "Blocked or broken path" : 2,
        "Vestiges of a destructive force" : 2,
        "Unexpected environmental threat" : 2,
        "Echoes of a troubling past" : 2,
        "Signs of a horrible fate" : 2,
        "Denizen seeks retribution" : 2,
        "Denizen leverages the environment" : 2,
        "Denizen restores what was lost" : 2,
        "Ravages return anew" : 2,
    ]
    
        //WILD
    var wildThemeFeatureDelve = [
        "Denizen’s lair" : 4,
        "Territorial markings" : 4,
        "Impressive flora or fauna" : 4,
        "Hunting ground or watering hole" : 4,
        "Remains or carrion" : 4,
    ]
    var wildThemeDangerDelve = [
        "Denizen hunts" : 5,
        "Denizen strikes without warning" : 5,
        "Denizen leverages the environment" : 2,
        "Denizen wields unexpected abilities" : 2,
        "Denizen guided by a greater threat" : 2,
        "Denizen protects something" : 2,
        "Hazardous terrain" : 2,
        "Weather or environmental threat" : 2,
        "Benign aspect becomes a threat" : 2,
        "Overzealous hunter" : 2,
        "Disturbing evidence of a victim’s fate" : 2,
        "Ill-fated victim in danger" : 2,
    ]
    
    //DOMAINS
        //BARROW
    var barrowDomainFeatureDelve = [
        "Burial chambers" : 22,
        "Maze of narrow passages" : 13,
        "Shrine" : 8,
        "Stately vault" : 4,
        "Offerings to the dead" : 4,
        "Statuary or tapestries" : 4,
        "Remains of a grave robber" : 4,
        "Mass grave" : 4,
        "Exhumed corpses" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var barrowDomainDangerDelve = [
        "Denizen guards this area" : 3,
        "Trap" : 3,
        "Death makes its presence known" : 3,
        "Crumbling architecture" : 3,
        "Grave goods with hidden dangers" : 3,
    ]
    
        //CAVERN
    var cavernDomainFeatureDelve = [
        "Twisting passages" : 22,
        "Cramped caves" : 13,
        "Vast chamber" : 8,
        "Subterranean waterway" : 4,
        "Cave pool" : 4,
        "Natural bridge" : 4,
        "Towering stone formations" : 4,
        "Natural illumination" : 4,
        "Dark pit" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var cavernDomainDangerDelve = [
        "Denizen lairs here" : 3,
        "Cave-in" : 3,
        "Flooding" : 3,
        "Perilous climb or descent" : 3,
        "Fissure or sinkhole" : 3,
    ]
    
        //FROZEN CAVERN
    var frozenCavernDomainFeatureDelve = [
        "Maze of icy tunnels" : 22,
        "Glistening cave" : 13,
        "Vast chamber" : 8,
        "Frigid waterway" : 4,
        "Icy pools" : 4,
        "Magnificent ice formations" : 4,
        "Frozen waterfall" : 4,
        "Deep crevasses" : 4,
        "Discovery locked in the ice" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var frozenCavernDomainDangerDelve = [
        "Denizen lairs here" : 3,
        "Fracturing ice" : 3,
        "Crumbling chasm" : 3,
        "Bitter chill" : 3,
        "Disorienting reflections" : 3,
    ]
    
        //ICEREACH
    var icereachDomainFeatureDelve = [
        "Plains of ice and snow" : 22,
        "Seawater channel" : 13,
        "Icy highlands" : 8,
        "Crevasse" : 4,
        "Ice floes" : 4,
        "Ship trapped in ice" : 4,
        "Animal herd or habitat" : 4,
        "Frozen carcass" : 4,
        "Camp or outpost" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var icereachDomainDangerDelve = [
        "Denizen hunts" : 3,
        "Fragile ice above watery depths" : 3,
        "Perilous climb or descent" : 3,
        "Avalanche or icefall" : 3,
        "Foul weather" : 3,
    ]
    
        //MINE
    var mineDomainFeatureDelve = [
        "Cramped tunnels" : 22,
        "Mine works" : 13,
        "Excavated chamber" : 8,
        "Mineshaft" : 4,
        "Collapsed tunnel" : 4,
        "Cluttered storage" : 4,
        "Housing or common areas" : 4,
        "Flooded chamber" : 4,
        "Unearthed secret" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var mineDomainDangerDelve = [
        "Cave-in" : 3,
        "Flooding" : 3,
        "Unstable platforms or architecture" : 3,
        "Hazardous gas pocket" : 3,
        "Weakened terrain" : 3,
    ]
    
        //PASS
    var passDomainFeatureDelve = [
        "Winding mountain path" : 22,
        "Snowfield or glacial rocks" : 13,
        "River gorge" : 8,
        "Crashing waterfall" : 4,
        "Highland lake" : 4,
        "Forgotten cairn" : 4,
        "Bridge" : 4,
        "Overlook" : 4,
        "Camp or outpost" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var passDomainDangerDelve = [
        "Denizen lairs here" : 3,
        "Denizen hunts" : 3,
        "Perilous climb or descent" : 3,
        "Avalanche or rockslide" : 3,
        "Foul weather" : 3,
    ]
    
        //RUIN
    var ruinDomainFeatureDelve = [
        "Crumbling corridors and chambers" : 22,
        "Collapsed architecture" : 13,
        "Rubble-choked hall" : 8,
        "Courtyard" : 4,
        "Archive or library" : 4,
        "Broken statuary or fading murals" : 4,
        "Preserved vault" : 4,
        "Temple to forgotten gods" : 4,
        "Mausoleum" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var ruinDomainDangerDelve = [
        "Ancient mechanism or trap" : 3,
        "Collapsing wall or ceiling" : 3,
        "Blocked or broken passage" : 3,
        "Unstable floor above a new danger" : 3,
        "Ancient secrets best left buried" : 3,
    ]
    
        //SEA CAVE
    var seaCaveDomainFeatureDelve = [
        "Watery tunnels" : 22,
        "Eroded chamber" : 13,
        "Flooded chamber" : 8,
        "Vast chamber" : 4,
        "Dry passages" : 4,
        "Freshwater inlet" : 4,
        "Rocky island" : 4,
        "Waterborne debris" : 4,
        "Shipwreck or boat" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var seaCaveDomainDangerDelve = [
        "Denizen strikes without warning" : 3,
        "Denizen lurks below" : 3,
        "Flooding" : 3,
        "Rushing current" : 3,
        "Claustrophobic squeeze" : 3,
    ]
    
        //SHADOWFEN
    var shadowfenDomainFeatureDelve = [
        "Narrow path through a fetid bog" : 22,
        "Stagnant waterway" : 13,
        "Flooded thicket" : 8,
        "Island of dry land" : 4,
        "Submerged discovery" : 4,
        "Preserved corpses" : 4,
        "Overgrown structure" : 4,
        "Tall reeds" : 4,
        "Camp or outpost" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var shadowfenDomainDangerDelve = [
        "Denizen hunts" : 3,
        "Deep water blocks the path" : 3,
        "Toxic environment" : 3,
        "Concealing or disorienting mist" : 3,
        "Hidden quagmire" : 3,
    ]
    
        //STRONGHOLD
    var strongholdDomainFeatureDelve = [
        "Connecting passageways" : 22,
        "Barracks or common quarters" : 13,
        "Large hall" : 8,
        "Workshop or library" : 4,
        "Command center or leadership" : 4,
        "Ladder or stairwell" : 4,
        "Storage" : 4,
        "Kitchen or larder" : 4,
        "Courtyard" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var strongholdDomainDangerDelve = [
        "Blocked or guarded path" : 3,
        "Caught in the open" : 3,
        "Chokepoint" : 3,
        "Trap" : 3,
        "Alarm trigger" : 3,
    ]
    
        //TANGLEWOOD
    var tanglewoodDomainFeatureDelve = [
        "Dense thicket" : 22,
        "Overgrown path" : 13,
        "Waterway" : 8,
        "Clearing" : 4,
        "Elder tree" : 4,
        "Brambles" : 4,
        "Overgrown structure" : 4,
        "Rocky outcrop" : 4,
        "Camp or outpost" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var tanglewoodDomainDangerDelve = [
        "Denizen hunts" : 3,
        "Denizen lairs here" : 3,
        "Trap or snare" : 3,
        "Path leads you astray" : 3,
        "Entangling plant life" : 3,
    ]
    
        //UNDERKEEP
    var underkeepDomainFeatureDelve = [
        "Carved passages" : 22,
        "Hall or chamber" : 13,
        "Stairs into the depths" : 8,
        "Grand doorway or entrance" : 4,
        "Tomb or catacombs" : 4,
        "Rough-hewn cave" : 4,
        "Foundry or workshop" : 4,
        "Shrine or temple" : 4,
        "Imposing architecture or artistry" : 4,
        "Something unusual or unexpected" : 10,
        "You transition into a new theme" : 1,
        "You transition into a new domain" : 1,
    ]
    var underkeepDomainDangerDelve = [
        "Ancient mechanism or trap" : 3,
        "Crumbling architecture" : 3,
        "Blocked or broken passage" : 3,
        "Artifact with a hidden danger" : 3,
        "Denizen lurks in darkness" : 3,
    ]
    
    // REVEAL DANGER MOVE
    var revealDangerMoveDelve = [
        "You encounter a hostile denizen" : 12,
        "You face an environmental or architectural hazard" : 11,
        "A discovery undermines or complicates your quest" : 8,
        "You confront a harrowing situation or sensation" : 3,
        "You face the consequences of an earlier choice or approach" : 3,
        "Your way is blocked or trapped" : 3,
        "A resource is diminished, broken, or lost" : 3,
        "You face a perplexing mystery or tough choice" : 3,
        "You lose your way or are delayed" : 3,
        "Roll twice more on this table. Both results occur. If they are the same result, make it worse." : 6,
    ]
    // FIND AN OPPORTUNITY
    var findOpportunityMoveDelve = [
        "The terrain favors you, or you find a hidden path" : 25,
        "An aspect of the history or nature of this place is revealed" : 20,
        "You locate a secure area" : 12,
        "A clue offers insight or direction" : 11,
        "You get the drop on a denizen" : 10,
        "This area provides an opportunity to scavenge, forage, or hunt" : 8,
        "You locate an interesting or helpful object" : 4,
        "You are alerted to a potential threat" : 4,
        "You encounter a denizen who might support you" : 4,
        "You encounter a denizen in need of help" : 2,
    ]
    
    var themeList = ["Chaotic", "Fortified", "Haunted", "Infested", "Inhabited", "Mechanical", "Ruined", "Sacred"]
    func randomTheme() -> String {
        var newList = themeList.shuffled()
        return newList.popLast() ?? "Error"
    }
    
    var themeDelveList = ["Ancient", "Corrupted", "Fortified", "Hallowed", "Haunted", "Infested", "Ravaged", "Wild"]
    var domainDelveList = ["Barrow", "Cavern", "Frozen cavern", "Icereach", "Mine", "Pass", "Ruin", "Sea Cave", "Shadowfen", "Stronghold", "Tanglewood", "Underkeep"]
    
    func randomDelveTheme() -> String {
        var newList = themeDelveList.shuffled()
        return newList.popLast() ?? "Error"
    }
    
    func randomDelveDomain() -> String {
        var newList = domainDelveList.shuffled()
        return newList.popLast() ?? "Error"
    }
    
    
}


