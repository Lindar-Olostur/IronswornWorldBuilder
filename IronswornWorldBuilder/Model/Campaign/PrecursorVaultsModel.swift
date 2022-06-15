//
//  PrecursorVaultsModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 30.05.2022.
//

import Foundation

struct PrecursorVaults: Codable, Hashable, Identifiable {
    var id = UUID()
    var name = ""
    var hiddenLocation = false
    var location = "Unknown"
    var hiddenDescription = false
    var description = ""
    var hiddenRank = false
    var rank = Rank.troublesome.rawValue
    var hiddenScale = false
    var scale = ""
    var hiddenForm = false
    var form = ""
    var hiddenShape = false
    var shape = ""
    var hiddenMaterial = false
    var material = ""
    var hiddenOuterFirstLook = false
    var outerFirstLook: [StringContainer] = []
    var hiddenInnerFirstLook = false
    var innerFirstLook: [StringContainer] = []
    var hiddenVaultPurpose = false
    var vaultPurpose = ""
    var hiddenWaypoints = true
    var waypoints: [PrecursorVaults] = []
    var hiddenThemes = false
    var themes: [StringContainer] = []
    var hiddenRoutes = true
    var routes: [Route] = []
    var subName = ""
    var mode = "Generation"
    var travelMode = false
    var oracle = Oracle.sharedOracle
    var currentZone = "Exterior"
    var currentZoneList = ["Exterior", "Interior", "Sanctum"]
    
    var locationList = ["Planetside", "Orbital", "Deep Space"]
    func randomLocation() -> String {
        var newList = locationList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var scaleList = ["Minor, confined site", "Typical site of limited scope", "Large, elaborate site", "Vast site of unfathomable complexity", "World-spanning site or megastructure"]
    func randomScale() -> String {
        
        let dictionary = [
            "Minor, confined site" : 30,
            "Typical site of limited scope" : 35,
            "Large, elaborate site" : 25,
            "Vast site of unfathomable complexity" : 9,
            "World-spanning site or megastructure" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var formList = ["Structure", "Vessel", "Monument", "Machine", "Incomprehensible"]
    func randomForm() -> String {
        
        let dictionary = [
            "Structure" : 35,
            "Vessel" : 25,
            "Monument" : 20,
            "Machine" : 15,
            "Incomprehensible" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var shapeList = ["Practical or functional", "Platform or disc", "Geometric (complex shape)", "Spires or towers", "Geometric (cube)", "Domed", "Geometric (obelisk)", "Spiky", "Geometric (pyramid)", "Sculptural or effigy", "Geometric (ring or torus)", "Amorphous", "Geometric (sphere)", "Transforming", "Organic or curved"]
    func randomShape() -> String {
        
        let dictionary = [
            "Practical or functional" : 15,
            "Platform or disc" : 5,
            "Geometric (complex shape)" : 5,
            "Spires or towers" : 5,
            "Geometric (cube)" : 5,
            "Domed" : 3,
            "Geometric (obelisk)" : 5,
            "Spiky" : 5,
            "Geometric (pyramid)" : 5,
            "Sculptural or effigy" : 3,
            "Geometric (ring or torus)" : 5,
            "Amorphous" : 3,
            "Geometric (sphere)" : 5,
            "Transforming" : 6,
            "Organic or curved" : 5,
            "Roll twice" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var materialList = ["Metallic (industrial)", "Metallic (smooth)", "Rocky or stone-like", "Crystalline or glass-like", "Bone-like", "Flesh-like", "Plant-like", "Energy", "Liquid"]
    func randomMaterial() -> String {
        
        let dictionary = [
            "Metallic (industrial)" : 30,
            "Fleshlike" : 4,
            "Metallic (smooth)" : 30,
            "Plantlike" : 4,
            "Rocky or stonelike" : 10,
            "Energy" : 2,
            "Crystalline or glasslike" : 4,
            "Liquid" : 2,
            "Bonelike" : 4,
            "Roll twice" : 10,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var outerFirstLookList = ["Corrupting its environment", "Levitating or in motion", "Automated defenses", "Lighted or illuminated", "Breached exterior", "No obvious point of entry", "Broken or fragmented", "Overgrown or entangled", "Camouflaged or hidden", "Perfectly preserved", "Cavernous opening", "Phasing in and out of reality", "Dispersed structures", "Physical barrier", "Dreadful premonitions", "Pitted or scarred", "Electromagnetic field", "Scaled for outsized beings", "Embedded within terrain", "Shrouded in mist or haze", "Encased in an energy field", "Signs of invaders", "Energy core or conduit", "Sound or signal", "Fractal patterns", "Strong gravity well", "Glyphs or symbols", "Surrounded by destruction", "Hazardous readings"]
    func randomOuterFirstLook() -> String {
        
        let dictionary = [
            "Corrupting its environment" : 3,
            "Levitating or in motion" : 3,
            "Automated defenses" : 4,
            "Lighted or illuminated" : 4,
            "Breached exterior" : 3,
            "No obvious point of entry" : 3,
            "Broken or fragmented" : 4,
            "Overgrown or entangled" : 3,
            "Camouflaged or hidden" : 3,
            "Perfectly preserved" : 3,
            "Cavernous opening" : 3,
            "Phasing in and out of reality" : 3,
            "Dispersed structures" : 3,
            "Physical barrier" : 3,
            "Dreadful premonitions" : 3,
            "Pitted or scarred" : 3,
            "Electromagnetic field" : 4,
            "Scaled for outsized beings" : 3,
            "Embedded within terrain" : 3,
            "Shrouded in mist or haze" : 3,
            "Encased in an energy field" : 3,
            "Signs of invaders" : 3,
            "Energy core or conduit" : 4,
            "Sound or signal" : 4,
            "Fractal patterns" : 3,
            "Strong gravity well" : 3,
            "Glyphs or symbols" : 4,
            "Surrounded by destruction" : 3,
            "Hazardous readings" : 4,
            "\(oracle.description()) + \(oracle.focus())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var innerFirstLookList = ["Abnormal gravity", "Automated defenses", "Biological infestation", "Carried tech is disrupted", "Complex textures or patterns", "Corpses of intruders", "Damage and debris", "Deteriorating spaces", "Dissonant tones or music", "Energy surges", "Environment reacts to your presence", "Evidence of looting or scavenging", "Excessive cold", "Excessive heat", "Faint ambient lighting", "Impenetrable darkness", "Intense smell", "Magnetic surfaces", "Material does not match exterior", "Ornate markings or symbols", "Reactive lighting responds to your presence", "Scale does not match exterior", "Signs of invasive lifeforms", "Surfaces respond to touch", "Thick haze or smoke", "Thick or fluid atmosphere", "Thrumming or droning sound", "Toxic atmosphere", "Toxic residue", "Wellpreserved", "Wet or humid"]
    func randomInnerFirstLook() -> String {
        
        let dictionary = [
            "Abnormal gravity" : 3,
            "Automated defenses" : 3,
            "Biological infestation" : 3,
            "Carried tech is disrupted" : 3,
            "Complex textures or patterns" : 3,
            "Corpses of intruders" : 3,
            "Damage and debris" : 3,
            "Deteriorating spaces" : 3,
            "Dissonant tones or music" : 3,
            "Energy surges" : 3,
            "Environment reacts to your presence" : 3,
            "Evidence of looting or scavenging" : 3,
            "Excessive cold" : 3,
            "Excessive heat" : 3,
            "Faint ambient lighting" : 3,
            "Impenetrable darkness" : 3,
            "Intense smell" : 3,
            "Magnetic surfaces" : 3,
            "Material does not match exterior" : 3,
            "Ornate markings or symbols" : 3,
            "Reactive lighting responds to your presence" : 3,
            "Scale does not match exterior" : 3,
            "Signs of invasive lifeforms" : 3,
            "Surfaces respond to touch" : 3,
            "Thick haze or smoke" : 3,
            "Thick or fluid atmosphere" : 3,
            "Thrumming or droning sound" : 3,
            "Toxic atmosphere" : 3,
            "Toxic residue" : 3,
            "Wellpreserved" : 3,
            "Wet or humid" : 3,
            "\(oracle.description()) + \(oracle.focus())" : 7,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var purposeList = ["Capture or control of other beings", "Command or communication relay", "Commemoration of an event", "Conduit to mystical powers", "Conservation of living specimens", "Containment of a powerful being", "Containment of dangerous creatures", "Containment of weapons", "Control of a destructive weapon", "Generation of defenses or barriers", "Generation or transformation of energy", "Harvesting of resources", "Interment of the dead", "Manipulation of spacetime", "Manufacturing of lifeforms", "Manufacturing of machines or devices", "Passage to another location", "Preservation of an ancient intelligence", "Preservation of maps or navigational data", "Protection of a sacred artifact", "Researching science or technology", "Safekeeping of cultural records or memories", "Shelter for inhabitants", "Stockpiling of resources", "Surveying or monitoring of a location", "Transformation of terrain or environments", "Worship of a god or being"]
    func randomPurpose() -> String {
        
        let dictionary = [
            "Capture or control of other beings" : 3,
            "Command or communication relay" : 3,
            "Commemoration of an event" : 3,
            "Conduit to mystical powers" : 3,
            "Conservation of living specimens" : 4,
            "Containment of a powerful being" : 4,
            "Containment of dangerous creatures" : 4,
            "Containment of weapons" : 3,
            "Control of a destructive weapon" : 4,
            "Generation of defenses or barriers" : 3,
            "Generation or transformation of energy" : 4,
            "Harvesting of resources" : 3,
            "Interment of the dead" : 3,
            "Manipulation of spacetime" : 3,
            "Manufacturing of lifeforms" : 3,
            "Manufacturing of machines or devices" : 3,
            "Passage to another location" : 3,
            "Preservation of an ancient intelligence" : 3,
            "Preservation of maps or navigational data" : 3,
            "Protection of a sacred artifact" : 4,
            "Researching science or technology" : 3,
            "Safekeeping of cultural records or memories" : 4,
            "Shelter for inhabitants" : 4,
            "Stockpiling of resources" : 3,
            "Surveying or monitoring of a location" : 3,
            "Transformation of terrain or environments" : 4,
            "Worship of a god or being" : 3,
            "Roll twice" : 5,
            "\(oracle.action()) + \(oracle.theme())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func randomInteriorFeature() -> String {
        
        let dictionary = [
            "Ascending or descending path" : 3,
            "Biological growths" : 3,
            "Blood trail" : 2,
            "Breached or ruptured area" : 2,
            "Broken or inactive machinery" : 3,
            "Clinging mist" : 2,
            "Damage or debris" : 3,
            "Echoing noises" : 2,
            "Elevated path over chasm or shaft" : 2,
            "Energy discharges" : 3,
            "Enigmatic controls or terminal" : 3,
            "Garden or invasive plant life" : 2,
            "Inscrutable object lies dark and silent" : 2,
            "Intersection or hub" : 3,
            "Intricate symbols or pictographs" : 3,
            "Looted or dismantled technology" : 3,
            "Looted or empty containers" : 3,
            "Mazelike passages" : 3,
            "Moving platform or lift" : 2,
            "Mummified or decayed corpses" : 3,
            "Narrowing or widening path" : 3,
            "Pooled liquid" : 3,
            "Remains of intruders" : 3,
            "Scattered bones" : 2,
            "Scrawled markings" : 3,
            "Signs of an attack or battle" : 2,
            "Signs of invasive creatures" : 3,
            "Surfaces honeycombed with openings" : 2,
            "Unintelligible recorded message" : 3,
            "Unintelligible whispers" : 3,
            "Vaulted chamber" : 3,
            "Vertical shaft" : 3,
            "Transition into the Sanctum" : 5,
            "Roll twice" : 5,
            "\(oracle.description()) + \(oracle.focus())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomInteriorPeril() -> String {
        
        let dictionary = [
            "Broken path" : 5,
            "Change in atmosphere or environment" : 5,
            "Corrosive environment" : 5,
            "Dire warning left by other explorers" : 5,
            "Foes close in" : 5,
            "Fragile structural integrity" : 5,
            "Hazardous path designed for traversal by other beings" : 5,
            "Important gear malfunctions" : 5,
            "Isolation or fear presses in" : 5,
            "Mechanical trap" : 5,
            "Mist or darkness conceals dangers" : 5,
            "Puzzling mystery blocks the way" : 5,
            "Radioactive hot spot" : 5,
            "Rivals seek what lay within" : 5,
            "Signs of a contagion" : 5,
            "Signs of a lurking foe" : 5,
            "Tempting location or object holds hidden dangers" : 5,
            "Toxic atmosphere" : 5,
            "Unnerving sound or sensation" : 5,
            "Roll twice" : 1,
            "\(oracle.action()) + \(oracle.theme())" : 4,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomInteriorOpportunity() -> String {
        
        let dictionary = [
            "Clue points the way to your destination or target" : 1,
            "Clue to a lifeform’s nature or vulnerabilities" : 1,
            "Helpful gear left by another explorer" : 1,
            "Insight into the nature or history of this site" : 1,
            "Intriguing device or artifact" : 1,
            "Opening to get the drop on a foe" : 1,
            "Opening to outmaneuver or escape a threat or foe" : 1,
            "Salvageable resource" : 1,
            "Secure area offers a moment of peace" : 1,
            "Shortcut or less perilous path speeds your way" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomSanctumFeature() -> String {
        
        let dictionary = [
            "Abyssal pit or chasm" : 2,
            "Altered gravity" : 3,
            "Area filled with strange liquid" : 2,
            "Area humming with aberrant energy" : 3,
            "Blasted or wrecked area" : 3,
            "Central chamber of immense proportions or grandeur" : 3,
            "Colossal machine" : 3,
            "Corrupted plant life" : 2,
            "Enigmatic mechanisms come to life" : 3,
            "Haze of spores or nanomachines" : 2,
            "Incomprehensible architecture or geometry" : 3,
            "Incongruent space contradicts the nature of this site" : 3,
            "Inscrutable object emits sound and energy" : 3,
            "Machinery fused with organic growths" : 3,
            "Moving chamber or passage" : 3,
            "Mutated remains of the dead" : 3,
            "Nest of invasive creatures" : 3,
            "Pockets or layers of altered atmosphere" : 3,
            "Pods or chambers with preserved corpses" : 2,
            "Pools of strange liquid" : 3,
            "Pulsating surfaces" : 3,
            "Rampant biological infestation" : 3,
            "Repository of biological specimens" : 3,
            "Sealed chamber" : 3,
            "Sealed containers of inscrutable purpose" : 3,
            "Simulated or illusionary environment" : 3,
            "Surfaces covered in slime or fungus" : 2,
            "Temporal distortions" : 2,
            "Transforming spaces" : 3,
            "Visions of this place in another time" : 3,
            "Visions or reflections of another reality" : 3,
            "Warped or misshapen spaces" : 3,
            "Whispering voices speak to you" : 2,
            "Roll twice" : 5,
            "\(oracle.description()) + \(oracle.focus())" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomSanctumPeril() -> String {
        
        let dictionary = [
            "Camouflaged or transforming foe reveals itself" : 5,
            "Confounding distortions of the timestream" : 5,
            "Destructive environmental disturbance" : 5,
            "Horrifying fate for a previous intruder" : 5,
            "Important equipment rendered useless" : 5,
            "Led astray or lured into danger by a manifestation or illusion" : 5,
            "Lost the way or separated from others" : 5,
            "Manifestations prey upon your weaknesses or worries" : 5,
            "Other intruders have been corrupted or mutated by this place" : 5,
            "Paranoia or suspicion takes hold" : 5,
            "Path behind you is sealed" : 5,
            "Powerful foe strikes without warning" : 5,
            "Restless dead awaken" : 5,
            "Scene of hideous violence or death" : 5,
            "Snared in an unnatural trap" : 5,
            "Spawning or swarming foes surround you" : 5,
            "Sudden structural collapse or failure" : 5,
            "Temptations to linger or remain in this site" : 5,
            "You are marked by physical corruption or mutation" : 5,
            "Roll twice" : 1,
            "\(oracle.action()) + \(oracle.theme())" : 4,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomSanctumOpportunity() -> String {
        
        let dictionary = [
            "Access to a secret or protected area" : 1,
            "Clue points the way to your destination or target" : 1,
            "Comforting illusion or vision" : 1,
            "Control or terminal adjusts to accept your input" : 1,
            "Deeper insight into the history or nature of this site" : 1,
            "Device or artifact reveals its purpose" : 1,
            "Environment adjusts to better suit you" : 1,
            "Foes stand down or give way" : 1,
            "Key offers control of a function or aspect of this site" : 1,
            "Shortcut or less perilous path speeds your way" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
}
