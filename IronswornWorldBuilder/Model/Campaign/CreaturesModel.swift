//
//  CreaturesModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

struct Creature: Codable, Hashable, Identifiable {
    var id = UUID()
    var homeSector = ""
    var hiddenEnvironment = true
    var environment = "Unknown"
    var hiddenScale = true
    var scale = "Unknown"
    var hiddenForm = true
    var form = ""
    var hiddenFirstLook = true
    var firstLook: [StringContainer] = []
    var hiddenBehavior = true
    var behavior = ""
    var hiddenRevealdAspect = true
    var revealdAspect: [StringContainer] = []
    var name = ""
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var mode = "Selection"
    var oracle = Oracle.sharedOracle
    var combatMode = false
    
    var environmentList = ["Space", "Interior", "Land", "Liquid", "Air", "Unknown"]
    func randomEnvironment() -> String {
        
        let dictionary = [
            "Space" : 5,
            "Interior" : 10,
            "Land" : 40,
            "Liquid" : 25,
            "Air" : 20,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var scaleList = ["Minuscule (bug-sized)", "Tiny (rodent-sized)", "Small (dog-sized)", "Medium (person-sized)", "Large (vehicle-sized)", "Huge (whale-sized)", "Titanic (hill-sized)", "Colossal (mountain-sized)", "Vast (planet-sized)", "Unknown"]
    func randomScale() -> String {
        
        func ultraScale() -> String {
            let dictionary = [
                "Titanic (hill-sized)" : 89,
                "Colossal (mountain-sized)" : 10,
                "Vast (planet-sized)" : 1,
            ]
            
            var pool: [String] = []
            
            for (value, ratio) in dictionary {
                pool.append(contentsOf: repeatElement(value, count: ratio))
            }
            
            var answer = pool.shuffled()
            
            return answer.popLast() ?? "error"
        }
        
        let dictionary = [
            "Minuscule (bug-sized)" : 3,
            "Tiny (rodent-sized)" : 7,
            "Small (dog-sized)" : 15,
            "Medium (person-sized)" : 35,
            "Large (vehicle-sized)" : 30,
            "Huge (whale-sized)" : 9,
            "\(ultraScale())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var formList = ["Amoeba / pseudopods", "Amorphous / elemental", "Avian / winged", "Beast / mammal", "Crustacean / shelled", "Fish / torpedo-shaped", "Humanoid / bipedal", "Insectoid / exoskeletal", "Jellyfish / gasbag", "Lizard / reptilian", "Octopoid / tentacled", "Plant / fungus", "Ray / flat-bodied", "Snake / eel", "Spider / web-weaver", "Starfish / symmetrical", "Worm / slug / larva"]
    func randomForm(environment: String) -> String {

        var dictionary: [String: Int] = [:]
        
        switch environment {
        case "Space" :
            dictionary = [
                "Amoeba / pseudopods" : 5,
                "Amorphous / elemental" : 15,
                "Avian / winged" : 10,
                "Beast / mammal" : 2,
                "Crustacean / shelled" : 2,
                "Fish / torpedo-shaped" : 3,
                "Humanoid / bipedal" : 2,
                "Insectoid / exoskeletal" : 2,
                "Jellyfish / gasbag" : 18,
                "Lizard / reptilian" : 2,
                "Octopoid / tentacled" : 5,
                "Plant / fungus" : 5,
                "Ray / flat-bodied" : 10,
                "Snake / eel" : 2,
                "Spider / web-weaver" : 2,
                "Starfish / symmetrical" : 2,
                "Worm / slug / larva" : 2,
                "Roll twice" : 10,
            ]
        case "Interior" :
            dictionary = [
                "Amoeba / pseudopods" : 3,
                "Amorphous / elemental" : 3,
                "Avian / winged" : 6,
                "Beast / mammal" : 7,
                "Crustacean / shelled" : 3,
                "Fish / torpedo-shaped" : 2,
                "Humanoid / bipedal" : 13,
                "Insectoid / exoskeletal" : 12,
                "Jellyfish / gasbag" : 2,
                "Lizard / reptilian" : 5,
                "Octopoid / tentacled" : 2,
                "Plant / fungus" : 5,
                "Ray / flat-bodied" : 2,
                "Snake / eel" : 3,
                "Spider / web-weaver" : 15,
                "Starfish / symmetrical" : 2,
                "Worm / slug / larva" : 5,
                "Roll twice" : 10,
            ]
        case "Land" :
            dictionary = [
                "Amoeba / pseudopods" : 2,
                "Amorphous / elemental" : 3,
                "Avian / winged" : 5,
                "Beast / mammal" : 15,
                "Crustacean / shelled" : 7,
                "Fish / torpedo-shaped" : 2,
                "Humanoid / bipedal" : 5,
                "Insectoid / exoskeletal" : 10,
                "Jellyfish / gasbag" : 2,
                "Lizard / reptilian" : 7,
                "Octopoid / tentacled" : 2,
                "Plant / fungus" : 5,
                "Ray / flat-bodied" : 2,
                "Snake / eel" : 7,
                "Spider / web-weaver" : 7,
                "Starfish / symmetrical" : 2,
                "Worm / slug / larva" : 7,
                "Roll twice" : 10,
            ]
        case "Liquid" :
            dictionary = [
                "Amoeba / pseudopods" : 5,
                "Amorphous / elemental" : 3,
                "Avian / winged" : 3,
                "Beast / mammal" : 6,
                "Crustacean / shelled" : 7,
                "Fish / torpedo-shaped" : 15,
                "Humanoid / bipedal" : 3,
                "Insectoid / exoskeletal" : 3,
                "Jellyfish / gasbag" : 8,
                "Lizard / reptilian" : 3,
                "Octopoid / tentacled" : 7,
                "Plant / fungus" : 5,
                "Ray / flat-bodied" : 7,
                "Snake / eel" : 5,
                "Spider / web-weaver" : 2,
                "Starfish / symmetrical" : 5,
                "Worm / slug / larva" : 2,
                "Roll twice" : 10,
            ]
        case "Air" :
            dictionary = [
                "Amoeba / pseudopods" : 2,
                "Amorphous / elemental" : 10,
                "Avian / winged" : 25,
                "Beast / mammal" : 3,
                "Crustacean / shelled" : 2,
                "Fish / torpedo-shaped" : 5,
                "Humanoid / bipedal" : 2,
                "Insectoid / exoskeletal" : 2,
                "Jellyfish / gasbag" : 15,
                "Lizard / reptilian" : 2,
                "Octopoid / tentacled" : 2,
                "Plant / fungus" : 2,
                "Ray / flat-bodied" : 10,
                "Snake / eel" : 2,
                "Spider / web-weaver" : 2,
                "Starfish / symmetrical" : 2,
                "Worm / slug / larva" : 2,
                "Roll twice" : 10,
            ]
        default:
            dictionary = [
                "Amoeba / pseudopods" : 1,
                "Amorphous / elemental" : 1,
                "Avian / winged" : 1,
                "Beast / mammal" : 1,
                "Crustacean / shelled" : 1,
                "Fish / torpedo-shaped" : 1,
                "Humanoid / bipedal" : 1,
                "Insectoid / exoskeletal" : 1,
                "Jellyfish / gasbag" : 1,
                "Lizard / reptilian" : 1,
                "Octopoid / tentacled" : 1,
                "Plant / fungus" : 1,
                "Ray / flat-bodied" : 1,
                "Snake / eel" : 1,
                "Spider / web-weaver" : 1,
                "Starfish / symmetrical" : 1,
                "Worm / slug / larva" : 1,
                "Roll twice" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var firstLookList = ["Antennae or sensory organs", "Armored", "Beautiful", "Biotech", "Bony or gaunt", "Brutish or muscled", "Camouflaged", "Claws or talons", "Compound eyes", "Comprised of many creatures", "Corrupted", "Crystalline", "Dead or undead", "Distinctive markings", "Distinctive smell", "Distinctive sound", "Dripping mucus", "Elongated Neck", "Energy emissions", "Extra limbs", "Faceless or inexpressive", "Fangs or rows of teeth", "Feathered", "Fungal growth", "Fur, hair, or filaments", "Graceful", "Hideous", "Hooded or crested", "Immobile or trapped", "Injured or scarred", "Iridescent", "Long-limbed", "Luminescent", "Mandibles or pincers", "Many-eyed", "Mineral or metallic", "Multi-jointed", "Multi-segmented body", "Ornamented or colorful", "Oversized mouth", "Prominent tail", "Prominent wings or fins", "Ridges or plates", "Scaled", "Single eye or oversized eyes", "Spikes or spines", "Stinger or barbs", "Tentacles or tendrils", "Translucent", "Visible symbiote"]
    func randomFirstLook() -> String {
        var newList = firstLookList.shuffled()
        return newList.popLast() ?? "Error"
    }
    
    var behaviorList = ["Ambusher", "Hibernator", "Pack hunter", "Apex predator", "Hoarder", "Prey", "Builder", "Hunter", "Protector", "Camouflager", "Lurer", "Scavenger", "Forager", "Migratory", "Tracker", "Grazer", "Mimic", "Trapper", "Herder", "Nester", "Roll twice"]
    func randomBehavior() -> String {
        var newList = behaviorList.shuffled()
        return newList.popLast() ?? "Error"
    }
    
    var aspectList = ["Alternative environment", "Illusionary", "Alternative movement", "Infectious", "Alternative senses", "Infested with parasites", "Burrower", "Intimidating threat display", "Chameleon", "Limited sense", "Clever", "Magnetic", "Consumes energy", "Mental influence or control", "Consumes inorganic matter", "Metamorphic", "Controlled or puppeteered", "Noxious cloud or spores", "Controls lesser creatures", "Paralytic toxin", "Corrosive excretion", "Parasitic", "Crusher or constrictor", "Pheromones", "Egg sac or carried offspring", "Poisonous", "Electric shock", "Powerful bite", "Electromagnetic pulse", "Proboscis or inner jaw", "Energy breath", "Projectile attack", "Energy manipulation", "Radioactive", "Engineered biology", "Regeneration", "Enhanced senses", "Replication", "Enhanced strength", "Sacrificial defense", "Entangling secretion", "Shapechanger", "Extradimensional", "Telekinetic", "Hallucinogen secretion", "Teleportation", "Hidden symbiote", "Territorial", "Hive mind", "Toxic spew"]
    func randomAspect() -> String {
        var newList = aspectList.shuffled()
        return newList.popLast() ?? "Error"
    }
}

