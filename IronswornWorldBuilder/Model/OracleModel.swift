//
//  OracleModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 01.05.2022.
//

import Foundation

struct Oracle: Codable, Hashable {
    static let sharedOracle = Oracle()
    
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
    
    var themeList = ["Chaotic", "Fortified", "Haunted", "Infested", "Inhabited", "Mechanical", "Ruined", "Sacred"]
    func randomTheme() -> String {
        var newList = themeList.shuffled()
        return newList.popLast() ?? "Error"
    }
}
