//
//  FactionModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.05.2022.
//

import Foundation

struct Faction: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = Faction.randomName()
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenType = true
    var type = "" {
        didSet {
            subName = "\(influence) \(type)"
            
            switch type {
            case "Dominion" :
                typeSummary = "Governing power"
            case " Guild" :
                typeSummary = "Organization of specialists"
            case "Fringe Group" :
                typeSummary = "Band of outlaws, outcasts, or rogues"
            default:
                typeSummary = ""
            }
        }
    }
    var typeSummary = "" {
        didSet {
            description = "\(influenceSummary) \(typeSummary)"
        }
    }
    var hiddenInfluence = true
    var influence = "" {
        didSet {
            subName = "\(influence) \(type)"
            
            switch influence {
            case "Forsaken" :
                influenceSummary = "Banished or forgotten"
            case " Isolated" :
                influenceSummary = "Limited influence in a remote location"
            case "Localized" :
                influenceSummary = "Marginal influence in a single sector"
            case "Established" :
                influenceSummary = "Strong influence in a single sector"
            case "Notable" :
                influenceSummary = "Dispersed influence across a few sectors"
            case "Dominant" :
                influenceSummary = "Far-reaching influence across many sectors"
            case "Inescapable" :
                influenceSummary = "Pervasive influence across inhabited space"
            default:
                influenceSummary = ""
            }
        }
    }
    var influenceSummary = "" {
        didSet {
            description = "\(influenceSummary) \(typeSummary)"
        }
    }
    var hiddenDominion = true
    var dominion: [StringContainer] = []
    var hiddenDominionLeadership = true
    var dominionLeadership = ""
    var hiddenGuild = true
    var guild = ""
    var hiddenPersons = true
    var persons: [Person] = []
    var hiddenFringeGroup = true
    var fringeGroup = ""
    var hiddenProjects = true
    var projects: [StringContainer] = []
    var hiddenRelationships = true
    var relationships: [StringContainer] = []
    var hiddenRumors = true
    var rumors: [StringContainer] = []
    var hiddenQuirks = true
    var quirks: [StringContainer] = []
    var mode = "Selection"
    var oracle = Oracle.sharedOracle
    var waitingForPerson = false
    
    
    static func randomName() -> String {
        var result = "Unknown name"
        
        func getNameTemplate() -> String {
            let dictionary = [
                "a" : 40,
                "b" : 15,
                "c" : 15,
                "d" : 30,
            ]
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        func randomLegacy() -> String {
            let list = ["Ancient", "Infinite", "Silent", "Ashen", "Iron", "Silver", "Awakened", "Kindred", "Sovereign", "Azure", "Obsidian", "Stellar", "Blessed", "Radiant", "Sundered", "Bloody", "Risen", "Supreme", "Broken", "Sacred", "Undying", "Ceaseless", "Sapphire", "Unified", "Crimson", "Scarlet", "United", "Cursed", "Serene", "Universal", "Dawning", "Shattered", "Veiled", "Dissident", "Shining", "Wandering", "Ebon", "Elder", "Enduring", "Enlightened", "Exalted", "Fallen", "Fated", "First name", "Forgotten", "Forsaken", "Gloaming", "Golden", "Hidden", "Infernal"]
            var newList = list.shuffled()
            return newList.popLast() ?? "Error"
        }
        func randomAffiliation() -> String {
            let list = ["Accord", "Alliance", "Ascendancy", "Circle", "Coalition", "Collective", "Commonwealth", "Confederation", "Consortium", "Council", "Court", "Covenant", "Dominion", "Empire", "Federation", "Imperium", "League", "Legion", "Order", "Pact", "Regiment", "Republic", "Sphere", "Syndicate", "Union"]
            var newList = list.shuffled()
            return newList.popLast() ?? "Error"
        }
        func randomIdentity() -> String {
            let list = ["Blades", "Realms", "Builders", "Reavers", "Daggers", "Relics", "Defenders", "Seekers", "Disciples", "Sentinels", "Domains", "Serpents", "Drifters", "Servants", "Embers", "Shadows", "Flames", "Shards", "Fleet", "Skulls", "Guardians", "Souls", "Hammers", "Specters", "Harbingers", "Stars", "Heralds", "Suns", "Hounds", "Swarm", "Hunters", "Swords", "Jackals", "Talons", "Keepers", "Vanguards", "Knights", "Wardens", "Menders", "Watchers", "Outcasts", "Wolves", "Phantoms", "Worlds", "Planets", "Wraiths", "Raiders", "Wreckers", "Ravens", "Wrights"]
            var newList = list.shuffled()
            return newList.popLast() ?? "Error"
        }
        
        let temp = getNameTemplate()
        
        switch temp {
        case "a" :
            result = "\(randomLegacy()) \(randomAffiliation())"
        case "b" :
            result = "\(randomLegacy()) \(randomIdentity())"
        case "c" :
            result = "\(randomIdentity()) of the \(randomLegacy()) \(randomAffiliation())"
        case "d" :
            result = "\(randomAffiliation()) of the \(randomLegacy()) \(randomIdentity())"
        default:
            result = "\(randomLegacy()) \(randomAffiliation())"
        }

        return result
    }
    var rumorsList = ["Caught in the crossfire of feuding factions", "Colluding with a criminal enterprise", "Corrupted by a dangerous power", "Critical resource is in short supply", "Defenses are overextended", "Developing revolutionary technology", "Digital systems are corrupted or infiltrated", "Heavily in debt", "Hit hard by a recent attack or calamity", "Holds a powerful artifact", "Holds incriminating information against a leader or faction", "Hoarding a valuable commodity", "Infiltrated by a rival faction", "Knows the location of a fabled treasure or lost technology", "Leaders are haunted by a dark prophecy", "Leaders are incompetent", "Leaders are puppets of another power or faction", "Lesser members of the leadership are plotting a coup", "New belief or religion is creating a schism among members", "Operations are a false front for their true purpose", "Overdependence on a failing or vulnerable technology", "Plagued by infighting and low morale", "Plotting to betray an allied faction", "Preparing a major offensive or operation", "Pulling the strings of a leader or faction", "Recently acquired an unexpected fortune", "Secretly supporting a reviled faction", "Sheltering an infamous or dangerous fugitive", "Suffered destructive sabotage from within", "Suffering a shortage of key workers or personnel", "Uprising or revolt is brewing from within", "Vulnerable to attack or aggression"]
    func randomRumor() -> String {
        let list = ["Caught in the crossfire of feuding factions", "Colluding with a criminal enterprise", "Corrupted by a dangerous power", "Critical resource is in short supply", "Defenses are overextended", "Developing revolutionary technology", "Digital systems are corrupted or infiltrated", "Heavily in debt", "Hit hard by a recent attack or calamity", "Holds a powerful artifact", "Holds incriminating information against a leader or faction", "Hoarding a valuable commodity", "Infiltrated by a rival faction", "Knows the location of a fabled treasure or lost technology", "Leaders are haunted by a dark prophecy", "Leaders are incompetent", "Leaders are puppets of another power or faction", "Lesser members of the leadership are plotting a coup", "New belief or religion is creating a schism among members", "Operations are a false front for their true purpose", "Overdependence on a failing or vulnerable technology", "Plagued by infighting and low morale", "Plotting to betray an allied faction", "Preparing a major offensive or operation", "Pulling the strings of a leader or faction", "Recently acquired an unexpected fortune", "Secretly supporting a reviled faction", "Sheltering an infamous or dangerous fugitive", "Suffered destructive sabotage from within", "Suffering a shortage of key workers or personnel", "Uprising or revolt is brewing from within", "Vulnerable to attack or aggression", "\(oracle.action()) + \(oracle.theme())"]
        var newList = list.shuffled()
        return newList.popLast() ?? "Error"
    }
    var quirksList = ["Ancient or coded language", "Animal or creature motif used as a faction symbol", "Banishes the disloyal", "Body augmentations are respected and valued", "Body ornamentations signify castes or roles", "Conceals individual identity", "Dependent on an addictive substance", "Distinctive or elaborate clothing", "Elite soldiers provide defense or serve as bodyguards", "Favors a signature weapon", "Guided by superstition or prophecy", "Heavily stratified social structure", "Hoards precursor artifacts", "Honors the fallen through unusual death rites", "Idolizes a longdead founder or martyr", "Keeps exhaustive records or archives", "Lives offplanet in spaceborne fleets", "Members take a new name when joining the faction", "Nomadic people and mobile operations", "Operates under strict codes or laws", "Recognizes others through a distinctive greeting or gesture", "Reliant on machine intelligence", "Resolves disputes through formal duels", "Rites of adulthood or ascension", "Shuns or distrusts machine intelligence", "Starships share a distinctive and recognizable profile", "Suspicious of outsiders", "Symbiotic relationship with a specific type of creature", "Trades in a unique currency or commodity", "Trains in a demanding physical discipline or martial art", "Wields unnatural abilities or strange technologies", "Work or environment causes mutations"]
    func randomQuirk() -> String {
        let list = ["Ancient or coded language", "Animal or creature motif used as a faction symbol", "Banishes the disloyal", "Body augmentations are respected and valued", "Body ornamentations signify castes or roles", "Conceals individual identity", "Dependent on an addictive substance", "Distinctive or elaborate clothing", "Elite soldiers provide defense or serve as bodyguards", "Favors a signature weapon", "Guided by superstition or prophecy", "Heavily stratified social structure", "Hoards precursor artifacts", "Honors the fallen through unusual death rites", "Idolizes a longdead founder or martyr", "Keeps exhaustive records or archives", "Lives offplanet in spaceborne fleets", "Members take a new name when joining the faction", "Nomadic people and mobile operations", "Operates under strict codes or laws", "Recognizes others through a distinctive greeting or gesture", "Reliant on machine intelligence", "Resolves disputes through formal duels", "Rites of adulthood or ascension", "Shuns or distrusts machine intelligence", "Starships share a distinctive and recognizable profile", "Suspicious of outsiders", "Symbiotic relationship with a specific type of creature", "Trades in a unique currency or commodity", "Trains in a demanding physical discipline or martial art", "Wields unnatural abilities or strange technologies", "Work or environment causes mutations", "\(oracle.action()) + \(oracle.theme())", ]
        var newList = list.shuffled()
        return newList.popLast() ?? "Error"
    }
    var relationshipList = ["Antagonistic towards", "Owes a debt to", "Apathetic or unaware of", "Shares a rivalry with", "Betrayed by", "Shares power with", "Broke faith with", "Shows respect for", "Distrustful of", "Splintered from", "Does business with", "Subordinate to", "Extorted by", "Supplied with resources by", "Holds contempt for", "Supplies resources to", "Holds leverage over", "Temporary alliance with", "In control of", "Tolerates", "Maneuvering against", "Trades favors with", "Needs aid from", "Unjustly accused by", "Negotiating with", "Warring with", "Open alliance with"]
    func randomRelationship() -> String {
        var newList = relationshipList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var projectList = ["Broaden scope of the faction to include a new focus", "Build or secure a powerful device", "Consolidate control of a valuable commodity", "Destroy or defeat a rival", "Disrupt the operations of a rival", "Escape the control of another faction or power", "Establish a monument or memorial", "Establish a safe refuge or headquarters", "Expand operations to a new location or sector", "Form an alliance", "Fulfill a prophecy", "Give aid to a faction", "Harness unnatural or forbidden power", "Hunt down a rogue asset", "Incite conflict among rivals", "Negotiate an agreement", "Obtain a needed commodity", "Obtain an important cultural artifact", "Obtain crucial data or information", "Obtain incriminating information about a rival", "Prevent a prophecy", "Put down an internal revolt or rebellion", "Repay a debt", "Rescue or recover a group or asset", "Research an innovation", "Resolve a conflict with another faction", "Reunite splintered elements of the faction", "Seize a powerful artifact or valuable treasure", "Seize rival territory or operations", "Subsume another faction", "Transport a valued asset", "Usurp leadership within a rival faction"]
    func randomProject() -> String {
        let list = ["Broaden scope of the faction to include a new focus", "Build or secure a powerful device", "Consolidate control of a valuable commodity", "Destroy or defeat a rival", "Disrupt the operations of a rival", "Escape the control of another faction or power", "Establish a monument or memorial", "Establish a safe refuge or headquarters", "Expand operations to a new location or sector", "Form an alliance", "Fulfill a prophecy", "Give aid to a faction", "Harness unnatural or forbidden power", "Hunt down a rogue asset", "Incite conflict among rivals", "Negotiate an agreement", "Obtain a needed commodity", "Obtain an important cultural artifact", "Obtain crucial data or information", "Obtain incriminating information about a rival", "Prevent a prophecy", "Put down an internal revolt or rebellion", "Repay a debt", "Rescue or recover a group or asset", "Research an innovation", "Resolve a conflict with another faction", "Reunite splintered elements of the faction", "Seize a powerful artifact or valuable treasure", "Seize rival territory or operations", "Subsume another faction", "Transport a valued asset", "Usurp leadership within a rival faction", "\(oracle.action()) + \(oracle.theme())", ]
        var newList = list.shuffled()
        return newList.popLast() ?? "Error"
    }
    var fringeGroupList = ["Cultists", "Monster hunters", "Rogue AI", "Exiles", "Pirates", "Scavengers", "Gangsters", "Raiders", "Smugglers", "Hackers", "Rebels", "Roll twice"]
    func randomFringeGroup() -> String {
        var newList = fringeGroupList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var guildList = ["Assassins", "Healers", "Navigators", "Bounty hunters", "Industrialists", "Peacekeepers", "Couriers", "Mercenaries", "Researchers", "Courtesans", "Merchants", "Spies", "Engineers", "Mystics", "Roll twice"]
    func randomGuild() -> String {
        var newList = guildList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var dominionLeadershipList = ["Anarchist", "Fated or prophesied leader", "Disputed leadership", "Clan chiefs or elders", "Authoritarian dictatorship", "Elected representatives", "Oligarchical elite", "Machine intelligence", "Dynastic lineage", "Varied / decentralized"]
    func randomDominionLeadership() -> String {
        var newList = dominionLeadershipList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var dominionList = ["Agriculture", "Exploration", "Pacifism", "Artistry", "Faith", "Prophecy", "Commerce", "History", "Science", "Conquest", "Honor", "Secrecy", "Construction", "Industry", "Technology", "Diplomacy", "Isolationism", "Treachery", "Education", "Law", "Warfare", "Environmentalism", "Mysticism", "Wealth"]
    func randomDominion() -> String {
        var newList = dominionList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var influenceList = ["Forsaken", "Isolated", "Localized", "Established", "Notable", "Dominant", "Inescapable"]
    func randomInfluence() -> String {
        
        let dictionary = [
            "Forsaken" : 10,
            "Isolated" : 20,
            "Localized" : 20,
            "Established" : 20,
            "Notable" : 15,
            "Dominant" : 10,
            "Inescapable" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var typeList = ["Dominion", "Guild", "Fringe Group", "Unknown"]
    func randomType() -> String {
        
        let dictionary = [
            "Dominion" : 4,
            "Guild" : 3,
            "Fringe Group" : 3,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
}

//struct Relationship: Codable, Hashable, Identifiable {
//    var id = UUID()
//    var fraction = ""
//    var rank = Rank.troublesome
//}
