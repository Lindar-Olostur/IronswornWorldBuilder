//
//  PersonModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 19.05.2022.
//

import Foundation

struct Person: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenFirstLook = true
    var firstLook: [StringContainer] = []
    var hiddenDisposition = true
    var disposition = ""
    var hiddenRole = true
    var clocks: [Clock] = []
    var hiddenClock = true
    var role = "" {
        didSet {
            subName = NSLocalizedString(role, comment: "")
        }
    }
    var hiddenGoal = true
    var goal = ""
    var hiddenAspect = true
    var revealdAspect: [StringContainer] = []
    var mode = "Input"
    var combatMode = false
    var oracle = Oracle.sharedOracle
    
    var firstLookListSF = ["Accented", "Energetic", "Shifty", "Accompanied", "Flashy", "Sickly", "Adorned", "Graceful", "Slight", "Aged", "Grim", "Swaggering", "Alluring", "Haggard", "Tattooed", "Armed", "Illequipped", "Threatened", "Armored", "Imposing", "Uncanny", "Athletic", "Large", "Visibly disabled", "Attractive", "Mutated", "Weathered", "Augmented", "Plain", "Wellequipped", "Concealed", "Poised", "Wiry", "Distracted", "Scarred", "Wounded", "Eccentric", "Scruffy", "Youthful"]
    var firstLookListIS = ["Stoic", "Attractive", "Passive", "Aloof", "Affectionate", "Generous", "Smug", "Armed", "Clever", "Brave", "Ugly", "Sociable", "Doomed", "Connected", "Bold", "Jealous", "Angry", "Active", "Suspicious", "Hostile", "Hardhearted", "Successful", "Talented", "Experienced", "Deceitful", "Ambitious", "Aggressive", "Conceited", "Proud", "Stern", "Dependent", "Wary", "Strong", "Insightful", "Dangerous", "Quirky", "Cheery", "Disfigured", "Intolerant", "Skilled", "Stingy", "Timid", "Insensitive", "Wild", "Bitter", "Cunning", "Remorseful", "Kind", "Charming", "Oblivious", "Critical", "Cautious", "Resourceful", "Weary", "Wounded", "Anxious", "Powerful", "Athletic", "Driven", "Cruel", "Quiet", "Honest", "Infamous", "Dying", "Reclusive", "Artistic", "Disabled", "Confused", "Manipulative", "Relaxed", "Stealthy", "Confident", "Weak", "Friendly", "Wise", "Influential", "Young", "Adventurous", "Oppressed", "Vengeful", "Cooperative", "Armored", "Apathetic", "Determined", "Loyal", "Sick", "Religious", "Selfish", "Old", "Fervent", "Violent", "Agreeable", "Hottempered", "Stubborn", "Incompetent", "Greedy", "Cowardly", "Obsessed", "Careless", "Ironsworn"]
    func randomFirstLook(isLand: Bool) -> String {
        
        var answer: [String] = []
        if isLand {
            answer = firstLookListIS.shuffled()
        } else {
            answer = firstLookListSF.shuffled()
        }
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    
    var dispositionList = ["Helpful", "Friendly", "Cooperative", "Curious", "Indifferent", "Suspicious", "Wanting", "Desperate", "Demanding", "Unfriendly", "Threatening", "Hostile"]
    func randomDisposition() -> String {
        
        let dictionary = [
            "Helpful" : 6,
            "Friendly" : 8,
            "Cooperative" : 8,
            "Curious" : 8,
            "Indifferent" : 10,
            "Suspicious" : 10,
            "Wanting" : 10,
            "Desperate" : 10,
            "Demanding" : 8,
            "Unfriendly" : 8,
            "Threatening" : 8,
            "Hostile" : 6,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    
    var roleListSF = ["Agent", "Guide", "Pirate", "AI", "Healer", "Preacher", "Artisan", "Historian", "Prophet", "Assassin", "Hunter", "Raider", "Bounty Hunter", "Investigator", "Researcher", "Courier", "Laborer", "Scavenger", "Crew", "Lawkeeper", "Scholar", "Criminal", "Leader", "Scout", "Cultist", "Mercenary", "Shipwright", "Diplomat", "Merchant", "Smuggler", "Engineer", "Miner", "Soldier", "Entertainer", "Mystic", "Spacer", "Explorer", "Navigator", "Technician", "Farmer", "Outcast", "Thief", "Fugitive", "Pilgrim", "Guardian", "Pilot"]
    var roleListIS = ["Criminal", "Healer", "Bandit", "Guide", "Performer", "Miner", "Mercenary", "Outcast", "Vagrant", "Forester", "Traveler", "Mystic", "Priest", "Sailor", "Pilgrim", "Thief", "Adventurer", "Forager", "Leader", "Guardian", "Artisan", "Scout", "Herder", "Fisher", "Warrior", "Hunter", "Raider", "Trader", "Farmer", "Unusual Role"]
    func randomRole(isLand: Bool) -> String {
        var answer: [String] = []
        
        if isLand == false {
            let dictionary = [
                "Agent" : 2,
                "Guide" : 2,
                "Pirate" : 2,
                "AI" : 2,
                "Healer" : 2,
                "Preacher" : 2,
                "Artisan" : 2,
                "Historian" : 2,
                "Prophet" : 2,
                "Assassin" : 2,
                "Hunter" : 2,
                "Raider" : 2,
                "Bounty Hunter" : 2,
                "Investigator" : 2,
                "Researcher" : 2,
                "Courier" : 2,
                "Laborer" : 2,
                "Scavenger" : 2,
                "Crew" : 2,
                "Lawkeeper" : 2,
                "Scholar" : 2,
                "Criminal" : 2,
                "Leader" : 2,
                "Scout" : 2,
                "Cultist" : 2,
                "Mercenary" : 2,
                "Shipwright" : 2,
                "Diplomat" : 2,
                "Merchant" : 2,
                "Smuggler" : 2,
                "Engineer" : 2,
                "Miner" : 2,
                "Soldier" : 2,
                "Entertainer" : 2,
                "Mystic" : 2,
                "Spacer" : 2,
                "Explorer" : 2,
                "Navigator" : 2,
                "Technician" : 2,
                "Farmer" : 2,
                "Outcast" : 2,
                "Thief" : 2,
                "Fugitive" : 2,
                "Pilgrim" : 2,
                "\(oracle.action()) + \(oracle.theme())" : 3,
                "Guardian" : 2,
                "Pilot" : 2,
                "Roll twice" : 5,
            ]
            
            var pool: [String] = []
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            answer = pool.shuffled()
        }
        
        if isLand == true {
            let dictionary = [
                "Criminal" : 2,
                "Healer" : 2,
                "Bandit" : 2,
                "Guide" : 3,
                "Performer" : 3,
                "Miner" : 3,
                "Mercenary" : 3,
                "Outcast" : 3,
                "Vagrant" : 3,
                "Forester" : 3,
                "Traveler" : 3,
                "Mystic" : 3,
                "Priest" : 3,
                "Sailor" : 3,
                "Pilgrim" : 3,
                "Thief" : 3,
                "Adventurer" : 3,
                "Forager" : 3,
                "Leader" : 3,
                "Guardian" : 4,
                "Artisan" : 4,
                "Scout" : 4,
                "Herder" : 4,
                "Fisher" : 4,
                "Warrior" : 5,
                "Hunter" : 5,
                "Raider" : 5,
                "Trader" : 5,
                "Farmer" : 5,
                "Unusual Role" : 1,
            ]
            var pool: [String] = []
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            answer = pool.shuffled()
        }

        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    
    var goalListSF = ["Avenge a wrong", "Build a home", "Build a relationship", "Claim a resource", "Collect a debt", "Craft an object", "Cure an ill", "Defeat a rival", "Defend a person", "Defend a place", "Discover a truth", "End a conflict", "Escape a captor", "Fight injustice", "Find a person", "Forge an alliance", "Gain knowledge", "Gain riches", "Maintain order", "Make an agreement", "Obtain an object", "Pay a debt", "Protect a lifeform", "Protect a secret", "Prove worthiness", "Rebel against power", "Refute a falsehood", "Repair a technology", "Resolve a dispute", "Restore a relationship", "Sabotage a technology", "Secure a resource", "Seek redemption", "Seize power", "Solve a mystery", "Spread faith", "Travel to a place", "Undermine a relationship"]
    var goalListIS = ["Obtain an object", "Make an agreement", "Build a relationship", "Undermine a relationship", "Seek a truth", "Pay a debt", "Refute a falsehood", "Harm a rival", "Cure an ill", "Find a person", "Find a home", "Seize power", "Restore a relationship", "Create an item", "Travel to a place", "Secure provisions", "Rebel against power", "Collect a debt", "Protect a secret", "Spread faith", "Enrich themselves", "Protect a person", "Protect the status quo", "Advance status", "Defend a place", "Avenge a wrong", "Fulfill a duty", "Gain knowledge", "Prove worthiness", "Find redemption", "Escape from something", "Resolve a dispute", "Roll twice"]
    func randomGoal(isLand: Bool) -> String {
        var answer: [String] = []
        if isLand == false {
            let dictionary = [
                "Avenge a wrong" : 2,
                "Build a home" : 2,
                "Build a relationship" : 2,
                "Claim a resource" : 2,
                "Collect a debt" : 2,
                "Craft an object" : 2,
                "Cure an ill" : 2,
                "Defeat a rival" : 2,
                "Defend a person" : 2,
                "Defend a place" : 2,
                "Discover a truth" : 2,
                "End a conflict" : 2,
                "Escape a captor" : 2,
                "Fight injustice" : 2,
                "Find a person" : 2,
                "Forge an alliance" : 2,
                "Gain knowledge" : 2,
                "Gain riches" : 2,
                "Maintain order" : 2,
                "Make an agreement" : 2,
                "Obtain an object" : 2,
                "Pay a debt" : 2,
                "Protect a lifeform" : 2,
                "Protect a secret" : 2,
                "Prove worthiness" : 2,
                "Rebel against power" : 2,
                "Refute a falsehood" : 2,
                "Repair a technology" : 2,
                "Resolve a dispute" : 2,
                "Restore a relationship" : 2,
                "Sabotage a technology" : 2,
                "Secure a resource" : 2,
                "Seek redemption" : 2,
                "Seize power" : 2,
                "Solve a mystery" : 2,
                "Spread faith" : 2,
                "Travel to a place" : 2,
                "Undermine a relationship" : 2,
                "\(oracle.action()) + \(oracle.theme())" : 10,
                "Roll twice" : 10,
            ]
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            answer = pool.shuffled()
        }
        if isLand == true {
            answer = goalListIS.shuffled()
        }
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    
    var aspectList = ["Addicted", "Generous", "Quiet", "Adventurous", "Gifted", "Quirky", "Afflicted", "Greedy", "Rebellious", "Aggressive", "Grief-stricken", "Reclusive", "Ambitious", "Handy", "Relaxed", "Angry", "Hardhearted", "Remorseful", "Anxious", "Haunted", "Resourceful", "Apathetic", "Honorable", "Secretive", "Bitter", "Hot-tempered", "Selfish", "Boastful", "Impulsive", "Sociable", "Boisterous", "Incompetent", "Stealthy", "Bold", "Independent", "Stern", "Brave", "Infamous", "Stingy", "Careless", "Influential", "Stoic", "Cautious", "Insensitive", "Strong", "Charismatic", "Insightful", "Stubborn", "Clever", "Intelligent", "Successful", "Conceited", "Intolerant", "Suspicious", "Confident", "Ironsworn", "Talented", "Confused", "Kind", "Technical", "Connected", "Law-abiding", "Timid", "Corrupted", "Lonely", "Tolerant", "Cowardly", "Loving", "Tough", "Creative", "Loyal", "Vengeful", "Critical", "Manipulative", "Violent", "Cruel", "Oblivious", "Wary", "Cunning", "Obsessed", "Watchful", "Dangerous", "Oppressed", "Weak", "Deceitful", "Passive", "Weary", "Defiant", "Powerful", "Wild", "Determined", "Proud", "Wise", "Disabled", "Doomed", "Driven", "Dying", "Envious", "Experienced", "Faithful"]
    func randomAspect() -> String {
        var answer = aspectList.shuffled()
        
        let x = "\(answer.popLast() ?? "error")"
        return NSLocalizedString(x, comment: "")
    }
    
    func randomFirstName() -> String {
        let firstNameList = ["Akim", "Alex", "Alexis", "Alisa", "Althea", "Amari", "Aparna", "Argus", "Arnav", "Ash", "Asha", "Astrid", "Aurora", "Ayako", "Azriel", "Blake", "Brennan", "Brianna", "Bruna", "Bruno", "Cassidy", "Christa", "Cole", "Corey", "Creed", "Derya", "Dex", "Doran", "Echo", "Eren", "Given", "Erim", "Esana", "Eveline", "Faye", "Fletcher", "Flint", "Florian", "Gavin", "Halia", "Ike", "Issac", "James", "Janya", "Jihun", "Jorunn", "Juliana", "Juro", "Kaisa", "Karthik", "Kayla", "Kei", "Kiana", "Kieran", "Kierra", "Kimora", "Kiri", "Kirsa", "Kwan", "Kylar", "Landry", "Logan", "Lowell", "Lucas", "Curtis", "Luna", "Lux", "Mae", "Magnus", "Mave", "Merrick", "Mina", "Nashida", "Nassar", "Ostara", "Qasira", "Quinn", "Ragnar", "Raven", "Ria", "Rokuro", "Roland", "Rowena", "Sage", "Saren", "Annora", "Severinus", "Shen", "Talia", "Tomiko", "Ulan", "Valda", "Venri", "Vesper", "Vuldar", "William", "Yelena", "Zakia", "Zari", "Zephyr", "Zoya"]
        var answer = firstNameList.shuffled()
        return "\(answer.popLast() ?? "Error")"
//        let x = "\(answer.popLast() ?? "error")"
//        return NSLocalizedString(x, comment: "")
    }
    func randomLastName() -> String {
        let lastNameList = ["Kuzmin", "Durant", "Jefferies", "Velez", "Lontoc", "Wade", "Kade", "Thorn", "Khosla", "Hendrix", "Okiro", "Ripley", "Talin", "Jin", "Finn", "Solas", "Quint", "Keelan", "Silva", "Valk", "O'Brien", "Ruiz", "Stallard", "Mackenson", "Jensen", "Sakir", "Tolari", "Kain", "Carr", "Valenus", "Kaan", "Taylan", "Legrand", "Jemison", "Arden", "Sayer", "Kai", "Slater", "Edris", "Sutton", "Savarin", "Bridger", "Mital", "Shin", "Nadir", "Santos", "Mihara", "Buhari", "Salvi", "Adler", "Takara", "Shelton", "Vandu", "Vega", "Zhang", "Savela", "Hawking", "Jen", "Hobbs", "Holland", "Silvius", "Freeman", "Barbosa", "Winter", "Hammond", "Archer", "Barlowe", "Shepherd", "Griffin", "Frost", "Quon", "Malek", "Murad", "Becker", "Ammar", "Braddock", "Blackstone", "Hadley", "Farin", "Kobayashi", "Duval", "Hunter", "Beckett", "Dykstra", "Gray", "Sedano", "Bai", "Booker", "Sato", "Vayan", "Bond", "Stark", "Stirling", "Wolfe", "O'Niel", "Petrov", "Nazari", "Darwin", "Pearson", "Volkov"]
        var answer = lastNameList.shuffled()
        return "\(answer.popLast() ?? "Error")"
        //let x = "\(answer.popLast() ?? "error")"
        //return NSLocalizedString(x, comment: "")
    }
    func randomCallsign() -> String {
        let callsignList = ["Angler", "Anvil", "Badger", "Bandit", "Bash", "Basilisk", "Bingo", "Blackbird", "Blade", "Bloodshot", "Bluewing", "Bonfire", "Book", "Breaker", "Brick", "Buzz", "Buzzard", "Centurion", "Chimera", "Circuit", "Clank", "Cleric", "Crash", "Cutter", "Cutthroat", "Cypher", "Dagger", "Dancer", "Dash", "Deadeye", "Deuce", "Failsafe", "Farseer", "Fidget", "Firestarter", "Fixer", "Flatline", "Ghost", "Grudge", "Gutshot", "Harrow", "Havoc", "Hellhound", "Hellion", "Hex", "Hush", "Ironclad", "Jackal", "Jackpot", "Jester", "Link", "Longshot", "Mainframe", "Mantis", "Mimic", "Mole", "Monarch", "Mongoose", "Nails", "Ogre", "Omega", "Overload", "Packrat", "Paladin", "Phantom", "Phoenix", "Pyro", "Quickdraw", "Razor", "Rogue", "Rook", "Rover", "Scout", "Shadow", "Shark", "Shutdown", "Slack", "Slag", "Snipe", "Spider", "Splinter", "Static", "Stinger", "Straggler", "Swindle", "Tinker", "Touchdown", "Tycoon", "Vagabond", "Valkyrie", "Vanguard", "Vertigo", "Warden", "Watchdog", "Wayfinder", "Whisper", "Wraith", "Wrongway", "Zephyr"]
        var answer = callsignList.shuffled()
        
        return "'\(answer.popLast() ?? "Error")'"
    }
    func randomName(isLand: Bool) -> String {
        
        var name = "Unknown person"
        if isLand == false {
            let nameFormat = Int.random(in: 0...6)
            switch nameFormat {
            case 0 :
                name = NSLocalizedString(randomFirstName(), comment: "")
            case 1 :
                name = NSLocalizedString(randomLastName(), comment: "")
            case 2 :
                name = randomCallsign()
            case 3 :
                name = "\(NSLocalizedString(randomFirstName(), comment: "")) \(NSLocalizedString(randomLastName(), comment: ""))"
            case 4 :
                name = "\(NSLocalizedString(randomFirstName(), comment: "")) \(randomCallsign())"
            case 5 :
                name = "\(randomCallsign()) \(NSLocalizedString(randomLastName(), comment: ""))"
            case 6 :
                name = "\(NSLocalizedString(randomFirstName(), comment: "")) \(randomCallsign()) \(NSLocalizedString(randomLastName(), comment: ""))"
            default:
                name = "Unknown person"
            }
        }
        if isLand == true {
            let ILname = Oracle.ironlandersName(Oracle())
            name = "\(ILname())"
        }
        return NSLocalizedString(name, comment: "")
    }
    
    
}
