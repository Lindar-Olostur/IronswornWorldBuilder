//
//  CampaignModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import Foundation

struct World: Codable {
    var type: String = "" // stars, world, IS, SF ...
    var name: String = "" {
        willSet {//UserDefaults.standard.set(newValue, forKey: "lastCampaign")
            
        }
    }
    var subName: String = ""
    var description: String = ""
    var hiddenRegions = true
    var hiddenDescription = true
    var hiddenTruth = true
    var regions: [Region] = []
    var truth: [YourTruth] = []
}

struct Region: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: String = ""
    var hiddenSectors = true
    var hiddenDescription = true
    var description: String = ""
    var sectors: [Sector] = []
}

struct Sector: Codable, Hashable, Identifiable {
    var id = UUID()
    var hiddenStellar = true
    var hiddenDescription = true
    var hiddenPlanets = true
    var hiddenSettlements = true
    var hiddenLocations = true
    var hiddenCreatures = true
    var hiddenVehicles = true
    var name = ""
    var homeRegion = ""
    var description = ""
    var stellarObjects: [StellarObject] = []
    var planets: [Planet] = []
    var settlements: [Settlement] = []
    var locations: [Location] = []
    var creatures: [Creature] = []
    var vehicles: [Starship] = []
    
    var oracle = Oracle.sharedOracle
    var mode = "Input"
    var travelMode = false
    
    func randomEncounter() -> String {
        
        var dictionary: [String: Int] = [:]
        
        switch homeRegion {
        case "Terminus" :
            dictionary = [
                "Stellar Object" : 15,
                "Planet" : 20,
                "Settlement" : 5,
                "Starship" : 7,
                "Derelict" : 4,
                "Precursor Vault" : 2,
                "Creature" : 2,
                "\(oracle.description()) + \(oracle.focus())" : 4,
                "Debris field: Mineral asteroids" : 5,
                "Debris field: Frozen asteroids" : 3,
                "Debris field: Crystalline asteroids" : 2,
                "Debris field: Creature boneyard" : 2,
                "Debris field: Metallic wreckage" : 2,
                "Large rogue asteroid" : 2,
                "Comet with a tail of ionized gas" : 2,
                "Fiery energy storm" : 3,
                "Chaotic meteoroid storm" : 2,
                "Turbulent gravitational wave" : 2,
                "Dense nebula cloud" : 8,
                "Roll twice" : 5,
                "Roll three times" : 2,
            ]
        case "Outlands" :
            dictionary = [
                "Stellar Object" : 15,
                "Planet" : 20,
                "Settlement" : 3,
                "Starship" : 5,
                "Derelict" : 3,
                "Precursor Vault" : 3,
                "Creature" : 3,
                "\(oracle.description()) + \(oracle.focus())" : 6,
                "Debris field: Mineral asteroids" : 5,
                "Debris field: Frozen asteroids" : 3,
                "Debris field: Crystalline asteroids" : 2,
                "Debris field: Creature boneyard" : 2,
                "Debris field: Metallic wreckage" : 2,
                "Large rogue asteroid" : 2,
                "Comet with a tail of ionized gas" : 2,
                "Fiery energy storm" : 4,
                "Chaotic meteoroid storm" : 2,
                "Turbulent gravitational wave" : 3,
                "Dense nebula cloud" : 8,
                "Roll twice" : 5,
                "Roll three times" : 2,
            ]
        case "Expanse" :
            dictionary = [
                "Stellar Object" : 15,
                "Planet" : 20,
                "Settlement" : 2,
                "Starship" : 2,
                "Derelict" : 2,
                "Precursor Vault" : 4,
                "Creature" : 4,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Debris field: Mineral asteroids" : 5,
                "Debris field: Frozen asteroids" : 3,
                "Debris field: Crystalline asteroids" : 2,
                "Debris field: Creature boneyard" : 2,
                "Debris field: Metallic wreckage" : 2,
                "Large rogue asteroid" : 2,
                "Comet with a tail of ionized gas" : 2,
                "Fiery energy storm" : 5,
                "Chaotic meteoroid storm" : 2,
                "Turbulent gravitational wave" : 4,
                "Dense nebula cloud" : 8,
                "Roll twice" : 5,
                "Roll three times" : 2,
            ]
        default:
            dictionary = [
                "Stellar Object" : 4,
                "Planet" : 1,
                "Settlement" : 1,
                "Starship" : 1,
                "Derelict" : 1,
                "Precursor Vault" : 1,
                "Creature" : 1,
                "\(oracle.description()) + \(oracle.focus())" : 5,
                "Debris field: Mineral asteroids" : 10,
                "Debris field: Frozen asteroids" : 10,
                "Debris field: Crystalline asteroids" : 10,
                "Debris field: Creature boneyard" : 2,
                "Debris field: Metallic wreckage" : 6,
                "Large rogue asteroid" : 7,
                "Comet with a tail of ionized gas" : 7,
                "Fiery energy storm" : 5,
                "Chaotic meteoroid storm" : 5,
                "Turbulent gravitational wave" : 5,
                "Dense nebula cloud" : 8,
                "Roll twice" : 1,
                "Roll three times" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomPeril() -> String {
        
        let dictionary = [
            "Artificial gravity generator malfunctions" : 3,
            "Automated defenses or mines protect this area" : 3,
            "Compartment catches fire or is breached" : 3,
            "Contagion or illness threatens to take hold" : 3,
            "Dust clouds imperil navigation or conceal foes" : 3,
            "Energy storm looms" : 3,
            "Familiar foe appears or sends an ominous message" : 3,
            "Gravity well or vortex takes hold" : 3,
            "Imperiled ship calls for help" : 3,
            "Important device fails or malfunctions" : 3,
            "Infestation is revealed" : 3,
            "Intruder or stowaway creates trouble" : 3,
            "Isolation or fear presses in" : 3,
            "Life support system malfunctions" : 3,
            "Meteoroid storm fills the sky" : 3,
            "Mysterious wreckage portends a new threat" : 3,
            "Nearby settlement calls for help" : 3,
            "Old repair or patch fails" : 3,
            "Onboard dispute or inner turmoil causes a disruption" : 3,
            "Others obstruct your path or form a blockade" : 3,
            "Phantom signals suggest a lurking foe" : 3,
            "Pirates hunt for prey" : 3,
            "Power fails" : 3,
            "Primary drive or generator malfunctions" : 3,
            "Sabotage is revealed" : 3,
            "Shockwave or gravity wave approaches" : 3,
            "Someone questions your presence here" : 3,
            "Stellar anomaly emits hazardous energies" : 3,
            "Threatening lifeform draws near" : 3,
            "Troubling visions or apparitions" : 3,
            "True nature of a cargo, occupant, or passenger is revealed" : 3,
            "Unsettling sounds or disturbances" : 3,
            "\(oracle.action()) + \(oracle.theme())" : 3,
            "Roll twice" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomOpportunity() -> String {
        
        let dictionary = [
            "Advance warning of an environmental threat" : 4,
            "Automated signal offers a helpful message or warning" : 4,
            "Cache of cargo or supplies" : 4,
            "Chance for fellowship or a moment of inner peace" : 4,
            "Clear path through otherwise perilous space" : 4,
            "Clue offers insight into a current quest or mystery" : 4,
            "Clue to a lifeform's nature or vulnerabilities" : 4,
            "Derelict ripe for the picking" : 4,
            "Foe inadvertently reveals themselves or tips their hand" : 4,
            "Friendly interaction with a benign lifeform" : 4,
            "Friendly settlement in range" : 4,
            "Friendly spacers at work here" : 4,
            "Friendly starship crosses your path" : 4,
            "Helpful or encouraging message from an acquaintance" : 4,
            "Impressive vista offers comfort or inspiration" : 4,
            "Interesting site offers opportunities for exploration" : 4,
            "Mineral or energy resource detected" : 4,
            "Navigational or environmental hazard is left behind" : 4,
            "Opening to escape or avoid foes" : 4,
            "Plea for help from a potential benefactor" : 4,
            "Probe or beacon with useful data" : 4,
            "Refuge offers a place to hide, plan, or recover" : 4,
            "Sensors pinpoint a lurking foe" : 4,
            "Sensors reveal helpful or interesting environmental data" : 4,
            "Vehicle or equipment performs beyond expectations" : 4,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func randomSectorName() -> String {
        
        let prefix = ["Accursed", "Ashen", "Asteria", "Bitter", "Blighted", "Bloodied", "Boundless", "Burning", "Cortana", "Corvus", "Crimson", "Cygnus", "Delphi", "Delphian", "Devil's", "Ebon", "Essus", "Fallen", "Ferrous", "Fool's", "Forgotten", "Haunted", "Hidden", "Hollow", "Igneous", "Infernal", "Invidia", "Iron", "Kalidas", "Kronos", "Lacuna", "Lumen", "Mobius", "Morien", "Onyx", "Outer", "Sanguis", "Scarred", "Scorched", "Shattered", "Shrouded", "Sindri", "Solana", "Stygian", "Sulaco", "Sundered", "Thunor", "Vanguard", "Veiled", "Wasted"]
        let suffix = ["Abyss", "Anvil", "Arch", "Breach", "Chain", "Channel", "Chasm", "Circlet", "Cluster", "Crossing", "Crown", "Currents", "Deep", "Desolation", "Drift", "Flow", "Flux", "Gap", "Gate", "Gyre", "Heart", "Helix", "Juncture", "Limits", "Locus", "Maelstrom", "Margin", "Maw", "Maze", "Nexus", "Oasis", "Pass", "Pit", "Pyre", "Reach", "Rest", "Rift", "Sanctum", "Shallows", "Shoal", "Spine", "Straits", "Threshold", "Tide", "Verge", "Vertex", "Vigil", "Void", "Web", "Zenith"]

        return "\(prefix.shuffled()[0]) \(suffix.shuffled()[0])"
    }
    func randomStarName() -> String {
        
        let nameFormat = Int.random(in: 0...3)
        var name = ""
        
        func numberPart() -> String {
            let numFormat = Int.random(in: 1...3)
            var sum = ""
            if numFormat == 1 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                sum = "\(x)\(y)"
            }
            if numFormat == 2 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                let z = Int.random(in: 0...9)
                let a = Int.random(in: 0...9)
                sum = "\(x)\(y)\(z)\(a)"
            }
            if numFormat == 3 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                let z = Int.random(in: 0...9)
                let a = Int.random(in: 0...9)
                let x1 = Int.random(in: 0...9)
                let y1 = Int.random(in: 0...9)
                let z1 = Int.random(in: 0...9)
                let a1 = Int.random(in: 0...9)
                sum = "\(x)\(y)\(z)\(a)-\(x1)\(y1)\(z1)\(a1)"
            }
            return sum
        }
        
        func letterPart() -> String {
            let greekLetters = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ", "μ", "ν", "ξ", "ο", "π", "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω"]
            return greekLetters.shuffled()[0].capitalized
            //return greekLetters.popLast() ?? ""
        }
        
        func codePart() -> String {
            
            var dictionary: [String: Int] = [:]
            
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "\(self.name)" : 75,
                    "PZQ" : 5,
                    "WTF" : 5,
                    "MF" : 5,
                    "HD" : 5,
                    "LO" : 5,
                ]
            case "Expanse" :
                dictionary = [
                    "\(self.name)" : 50,
                    "PZQ" : 12,
                    "WTF" : 12,
                    "MF" : 12,
                    "HD" : 12,
                    "LO" : 12,
                ]
            case "Outlands" :
                dictionary = [
                    "\(self.name)" : 30,
                    "PZQ" : 15,
                    "WTF" : 15,
                    "MF" : 15,
                    "HD" : 10,
                    "LO" : 15,
                ]
            case "Void" :
                dictionary = [
                    "\(self.name)" : 10,
                    "PZQ" : 20,
                    "WTF" : 20,
                    "MF" : 20,
                    "HD" : 20,
                    "LO" : 10,
                ]
            default:
                dictionary = [
                    "\(self.name)" : 1,
                    "PZQ" : 1,
                    "WTF" : 1,
                    "MF" : 1,
                    "HD" : 1,
                    "LO" : 1,
                ]
            }
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        
        if nameFormat == 0 {
            name = "Unknown stellar object"
        }
        if nameFormat == 1 {
            name = "\(letterPart()) \(codePart()) \(numberPart())"
        }
        if nameFormat == 2 {
            name = "\(codePart()) \(numberPart())"
        }
        if nameFormat == 3 {
            name = "\(letterPart()) \(codePart())"
        }
        return name
    }
    func randomRoguePlanetName() -> String {
        
        let nameFormat = Int.random(in: 0...3)
        var name = "Unknown planet"
        
        func numberPart() -> String {
            let numFormat = Int.random(in: 1...3)
            var sum = ""
            if numFormat == 1 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                sum = "\(x)\(y)"
            }
            if numFormat == 2 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                let z = Int.random(in: 0...9)
                let a = Int.random(in: 0...9)
                sum = "\(x)\(y)\(z)\(a)"
            }
            if numFormat == 3 {
                let x = Int.random(in: 1...9)
                let y = Int.random(in: 0...9)
                let z = Int.random(in: 0...9)
                let a = Int.random(in: 0...9)
                let x1 = Int.random(in: 0...9)
                let y1 = Int.random(in: 0...9)
                let z1 = Int.random(in: 0...9)
                let a1 = Int.random(in: 0...9)
                sum = "\(x)\(y)\(z)\(a)-\(x1)\(y1)\(z1)\(a1)"
            }
            return sum
        }
        
//        func letterPart() -> String {
//            let greekLetters = ["a", "b", "c", "d", "i", "f", "g", "h", "e", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
//            return greekLetters.shuffled()[0].capitalized
//            //return greekLetters.popLast() ?? ""
//        }
        
        func codePart() -> String {
            
            let dictionary = [
                "PZQ" : 1,
                "WTF" : 1,
                "MF" : 1,
                "HD" : 1,
                "LO" : 1,
            ]
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        
        if nameFormat == 0 {
            name = "Unknown planet"
        }

        if nameFormat >= 1 {
            name = "\(codePart()) \(numberPart())"
        }

        return name
    }
    
}

struct StringContainer: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = "Unknown"
}

struct YourTruth: Codable, Hashable, Identifiable {
    var id = UUID()
    var title = ""
    var truth = ""
    var options: [String] = []
    var mode = "Input"
    var current = 0 {
        didSet {
            if oldValue == 2 {current = 0}
        }
    }
}
