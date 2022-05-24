//
//  DerelictModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 23.05.2022.
//

import Foundation

struct Derelict: Codable, Hashable, Identifiable {
    var id = UUID()
    var isChild: Bool
    var hiddenLocation = false
    var location = ""
    var hiddenType = false
    var type = ""
    var hiddenCondition = false
    var condition = ""
    var hiddenOuterFirstLook = false
    var outerFirstLook = ""
    var hiddenInnerFirstLook = false
    var innerFirstLook: [StringContainer] = []
    var name = ""
    var hiddenDescription = false
    var description = ""
    var hiddenRank = false
    var rank = Rank.troublesome
    var hiddenTheme = false
    var theme: [StringContainer] = []
    var hiddenRoutes = true
    var routes: [Route] = []
    var subName = ""
    var mode = "Selection"
    
    var locationList = ["Planetside", "Orbital", "Deep Space", "Unknown"]
    func randomLocation() -> String {
        var newList = locationList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var typeList = ["Derelict starship", "Derelict settlement", "Unknown"]
    func randomType(location: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Planetside" :
            dictionary = [
                "Derelict starship" : 1,
                "Derelict settlement" : 3,
            ]
        case "Orbital" :
            dictionary = [
                "Derelict starship" : 4,
                "Derelict settlement" : 6,
            ]
        case "Deep Space" :
            dictionary = [
                "Derelict starship" : 3,
                "Derelict settlement" : 1,
            ]
        default:
            dictionary = [
                "Derelict starship" : 1,
                "Derelict settlement" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var conditionList = ["Functional", "Limited power", "Cold and dark", "Damaged or breached", "Heavily damaged", "Impending destruction", "Unknown"]
    func randomCondition() -> String {
        
        let dictionary = [
            "Functional" : 10,
            "Limited power" : 20,
            "Cold and dark" : 30,
            "Damaged or breached" : 30,
            "Heavily damaged" : 8,
            "Impending destruction" : 2,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var outerFirstLookList = ["Blocked access", "Corpses", "Hazardous readings", "Mutated structure", "Odd orientation", "Overgrown or entangled", "Sending a signal or message", "Signs that others are here", "Stripped exterior", "Time or reality distortions", "Unknown"]
    func randomOuterFirstLook() -> String {
        
        let dictionary = [
            "Blocked access" : 15,
            "Corpses" : 15,
            "Hazardous readings" : 15,
            "Mutated structure" : 5,
            "Odd orientation" : 10,
            "Overgrown or entangled" : 5,
            "Sending a signal or message" : 15,
            "Signs that others are here" : 5,
            "Stripped exterior" : 10,
            "Time or reality distortions" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    var innerFirstLookList = ["Abnormal gravity", "Haunting visions of the dead", "Active bots", "Hazardous temperature", "Archaic equipment", "Heavy steam or moisture", "Automated announcements", "Littered with corpses", "Biological infestation", "Nesting or feeding creatures", "Charred surfaces", "Ornate furnishings", "Claw marks", "Scarred by gunfire", "Cluttered with debris", "Sealed against intruders", "Corroded surfaces", "Signs of looting or scavenging", "Cramped spaces", "Smell of decay", "Creaking hull", "Splattered with blood", "Esoteric writing or symbols", "Temporal distortions", "Evidence of new inhabitants", "Thick haze or smoke", "Exposed wiring or conduits", "Unstable energy surges", "Flashing strobe lights", "Watchful AI", "Fluctuating power", "Descriptor + Focus", "Unknown"]
    func randomInnerFirstLook() -> String {
        
        let dictionary = [
            "Abnormal gravity" : 1,
            "Haunting visions of the dead" : 1,
            "Active bots" : 1,
            "Hazardous temperature" : 1,
            "Archaic equipment" : 1,
            "Heavy steam or moisture" : 1,
            "Automated announcements" : 1,
            "Littered with corpses" : 1,
            "Biological infestation" : 1,
            "Nesting or feeding creatures" : 1,
            "Charred surfaces" : 1,
            "Ornate furnishings" : 1,
            "Claw marks" : 1,
            "Scarred by gunfire" : 1,
            "Cluttered with debris" : 1,
            "Sealed against intruders" : 1,
            "Corroded surfaces" : 1,
            "Signs of looting or scavenging" : 1,
            "Cramped spaces" : 1,
            "Smell of decay" : 1,
            "Creaking hull" : 1,
            "Splattered with blood" : 1,
            "Esoteric writing or symbols" : 1,
            "Temporal distortions" : 1,
            "Evidence of new inhabitants" : 1,
            "Thick haze or smoke" : 1,
            "Exposed wiring or conduits" : 1,
            "Unstable energy surges" : 1,
            "Flashing strobe lights" : 1,
            "Watchful AI" : 1,
            "Fluctuating power" : 1,
            "Descriptor + Focus" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
}
