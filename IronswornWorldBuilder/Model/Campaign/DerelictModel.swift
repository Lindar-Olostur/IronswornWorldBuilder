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
    var hiddenWaypoints = true
    var waypoints: [Derelict] = []
    var name = "Unknown"
    var hiddenDescription = false
    var description = ""
    var hiddenRank = false
    var rank = Rank.troublesome.rawValue
    var hiddenThemes = false
    var themes: [StringContainer] = []
    var hiddenRoutes = true
    var routes: [Route] = []
    var subName = "Derelict"
    var clocks: [Clock] = []
    var hiddenClock = true
    var mode = "Generation"
    var travelMode = true
    var oracle = Oracle.sharedOracle
    var currentZone = "Access"
    var currentArea = Derelict.randomAccessArea() {
        didSet {
            setAreaList()
        }
    }
    mutating func setAreaList() {
        areaList = []
        switch currentZone {
        case "Access" :
            areaList = accessAreaList
        case "Community" :
            areaList = communityAreaList
        case "Engineering" :
            areaList = engineeringAreaList
        case "Living" :
            areaList = livingAreaList
        case "Medical" :
            areaList = medicalAreaList
        case "Operations" :
            areaList = operationsAreaList
        case "Production" :
            areaList = productionAreaList
        case "Research" :
            areaList = researchAreaList
        default:
            areaList = ["ERROR"]
        }
    }
    var areaList: [String] = ["Corridor", "Stairs", "Lift or elevator", "Catwalk or bridge", "Vertical shaft or ladder", "Hub or intersection", "Crawl space or duct", "Airlock or external"]
    
    
    var locationList = ["Planetside", "Orbital", "Deep Space"]
    func randomLocation() -> String {
        var newList = locationList.shuffled()
        return newList.popLast() ?? "Error"
    }
    var typeList = ["Derelict starship", "Derelict settlement"]
    func randomType(location: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch location {
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
    var conditionList = ["Functional", "Limited power", "Cold and dark", "Damaged or breached", "Heavily damaged", "Impending destruction"]
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
    var outerFirstLookList = ["Blocked access", "Corpses", "Hazardous readings", "Mutated structure", "Odd orientation", "Overgrown or entangled", "Sending a signal or message", "Signs that others are here", "Stripped exterior", "Time or reality distortions"]
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
    var innerFirstLookList = ["Abnormal gravity", "Haunting visions of the dead", "Active bots", "Hazardous temperature", "Archaic equipment", "Heavy steam or moisture", "Automated announcements", "Littered with corpses", "Biological infestation", "Nesting or feeding creatures", "Charred surfaces", "Ornate furnishings", "Claw marks", "Scarred by gunfire", "Cluttered with debris", "Sealed against intruders", "Corroded surfaces", "Signs of looting or scavenging", "Cramped spaces", "Smell of decay", "Creaking hull", "Splattered with blood", "Esoteric writing or symbols", "Temporal distortions", "Evidence of new inhabitants", "Thick haze or smoke", "Exposed wiring or conduits", "Unstable energy surges", "Flashing strobe lights", "Watchful AI", "Fluctuating power"]
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
            "\(oracle.description()) + \(oracle.focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var currentZoneList = ["Access", "Community", "Engineering", "Living", "Medical", "Operations", "Production", "Research"]
    func randomZone(type: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Derelict Settlement" :
            dictionary = [
                "Community" : 20,
                "Engineering" : 10,
                "Living" : 25,
                "Medical" : 10,
                "Operations" : 10,
                "Production" : 15,
                "Research" : 10,
            ]
        case "Derelict starship" :
            dictionary = [
                "Community" : 5,
                "Engineering" : 25,
                "Living" : 25,
                "Medical" : 10,
                "Operations" : 20,
                "Production" : 5,
                "Research" : 10,
            ]
        default:
            dictionary = [
                "Community" : 1,
                "Engineering" : 1,
                "Living" : 1,
                "Medical" : 1,
                "Operations" : 1,
                "Production" : 1,
                "Research" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //ACCESS
    var accessAreaList = ["Corridor", "Stairs", "Lift or elevator", "Catwalk or bridge", "Vertical shaft or ladder", "Hub or intersection", "Crawl space or duct", "Airlock or external"]
    static func randomAccessArea() -> String {
        
        let dictionary = [
            "Corridor" : 50,
            "Stairs" : 10,
            "Lift or elevator" : 10,
            "Catwalk or bridge" : 10,
            "Vertical shaft or ladder" : 5,
            "Hub or intersection" : 5,
            "Crawl space or duct" : 5,
            "Airlock or external" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomAccessFeature() -> String {
        
        let dictionary = [
            "Abandoned gear" : 1,
            "Organic growths" : 1,
            "Blood trail" : 1,
            "Ruined bot" : 1,
            "Breached door or hatch" : 1,
            "Scrawled warning" : 1,
            "Control or terminal station" : 1,
            "Sealed breach" : 1,
            "Corpse" : 1,
            "Sounds of movement" : 1,
            "Dismantled equipment" : 1,
            "Steam or smoke" : 1,
            "Flashing strobes" : 1,
            "Wandering bot" : 1,
            "Leaking pipes" : 1,
            "Windows or viewports" : 1,
            "Makeshift barricade" : 1,
            "Wrecked passage or debris" : 1,
            "Opened or missing panels" : 1,
            "\(oracle.description()) + \(oracle.focus())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomAccessPeril() -> String {
        
        let dictionary = [
            "Alarm or failsafe is triggered" : 1,
            "Automated defenses" : 1,
            "Blocked or sealed path" : 1,
            "Dreadful scene of death or violence" : 1,
            "Foe closes in" : 1,
            "Gear is failing or broken" : 1,
            "Hazardous environmental change" : 1,
            "Path is trapped" : 1,
            "Unsettling sound or disturbance" : 1,
            "\(oracle.action()) + \(oracle.theme())" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomAccessOpportunity() -> String {
        
        let dictionary = [
            "Directions, shortcut, or alternate path" : 1,
            "Encounter with a friendly survivor, explorer, or denizen" : 1,
            "Hopeful signs of life" : 1,
            "Opening to outmaneuver or escape a threat or foe" : 1,
            "Useful equipment" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //COMMUNITY
    var communityAreaList = ["Bar or club", "Gym or fitness", "Temple or chapel", "Market or trade", "Classroom or education", "Promenade or overlook", "Concourse or hub", "Restaurant or dining", "Entertainment", "New zone", "Park or garden", "New zone via Access"]
    func randomCommunityArea() -> String {
        
        let dictionary = [
            "Bar or club" : 8,
            "Gym or fitness" : 8,
            "Temple or chapel" : 8,
            "Market or trade" : 8,
            "Classroom or education" : 8,
            "Promenade or overlook" : 8,
            "Concourse or hub" : 8,
            "Restaurant or dining" : 8,
            "Entertainment" : 8,
            "New zone" : 5,
            "Park or garden" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomCommunityFeature() -> String {
        
        let dictionary = [
            "Adhoc memorials" : 8,
            "Graffiti or vandalization" : 8,
            "Art depicting historic event" : 8,
            "Guard post or surveillance" : 8,
            "Artificial environment" : 8,
            "Mass grave or corpses" : 8,
            "Automated announcements" : 8,
            "Panoramic viewport" : 8,
            "Barricaded area" : 8,
            "Rubble or debris" : 8,
            "Gaming devices or interfaces" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomCommunityPeril() -> String {
        
        let dictionary = [
            "Biological infestation" : 10,
            "Breached or broken structure" : 10,
            "Distressing signs of mass violence or death" : 10,
            "Flooded environment" : 10,
            "Foe lurks within concealment" : 10,
            "Fragile structural integrity" : 10,
            "Haunting vision of life here before the fall" : 10,
            "Hazardous environmental change" : 10,
            "Heartbreaking memento of lost lives" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomCommunityOpportunity() -> String {
        
        let dictionary = [
            "Culturally significant object or artifact" : 1,
            "Salvageable goods or resources" : 1,
            "Secure area offers a moment of peace" : 1,
            "Terminal with access to site details" : 1,
            "Valuable item" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //ENGINEERING
    var engineeringAreaList = ["Control room", "Maintenance tube", "Engine room or power core", "Vehicle bay or garage", "Engineering offices", "Water processing", "Equipment storage", "Workshop", "Fuel or coolant tanks", "New zone", "Life support", "New zone via Access"]
    func randomEngineeringArea() -> String {
        
        let dictionary = [
            "Control room" : 8,
            "Maintenance tube" : 8,
            "Engine room or power core" : 8,
            "Vehicle bay or garage" : 8,
            "Engineering offices" : 8,
            "Water processing" : 8,
            "Equipment storage" : 8,
            "Workshop" : 8,
            "Fuel or coolant tanks" : 8,
            "New zone" : 5,
            "Life support" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomEngineeringFeature() -> String {
        
        let dictionary = [
            "Cluttered workbench" : 8,
            "Multilevel layout" : 8,
            "Control terminal" : 8,
            "Pipes and valves" : 8,
            "Crane or lift" : 8,
            "Sharp ozone smell" : 8,
            "Disassembled equipment" : 8,
            "Unfinished project" : 8,
            "Flickering status monitors" : 8,
            "Utility bots" : 8,
            "Juryrigged equipment" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomEngineeringPeril() -> String {
        
        let dictionary = [
            "Corrosive leak" : 10,
            "Erratic utility bots" : 10,
            "Failing equipment requires a specific part or skill" : 10,
            "Fire or energy surge" : 10,
            "Precarious or broken path" : 10,
            "Radioactive hotspot" : 10,
            "Sabotaged equipment" : 10,
            "Shrouded atmosphere conceals a lurking foe" : 10,
            "Unstable or failing power core" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomEngineeringOpportunity() -> String {
        
        let dictionary = [
            "Advanced or experimental equipment" : 1,
            "Chance to restore power or function" : 1,
            "Helpful plans or schematics" : 1,
            "Helpful utility bot" : 1,
            "Useful tool or device" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //LIVING
    var livingAreaList = ["Food storage","Quarters (individual)","Galley or kitchen","Quarters (communal)","Laundry","Restroom or showers","Locker room or storage","Sleeping pods","Mess hall or dining","New zone","Observation lounge","New zone via Access"]
    func randomLivingArea() -> String {
        
        let dictionary = [
            "Food storage" : 8,
            "Quarters (individual)" : 8,
            "Galley or kitchen" : 8,
            "Quarters (communal)" : 8,
            "Laundry" : 8,
            "Restroom or showers" : 8,
            "Locker room or storage" : 8,
            "Sleeping pods" : 8,
            "Mess hall or dining" : 8,
            "New zone" : 5,
            "Observation lounge" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomLivingFeature() -> String {
        
        let dictionary = [
            "Abandoned pet" : 8,
            "Ransacked belongings" : 8,
            "Audible music" : 8,
            "Remains of the dead" : 8,
            "Cherished personal item" : 8,
            "Scuttling vermin" : 8,
            "Failed barricade" : 8,
            "Shrine or altar" : 8,
            "Halfeaten food" : 8,
            "Unusual art" : 8,
            "Messages from loved ones" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomLivingPeril() -> String {
        
        let dictionary = [
            "Booby trap" : 10,
            "Distressing written message" : 10,
            "Disturbing evidence of exploitive living conditions" : 10,
            "Dreadful scene of death or violence" : 10,
            "Lured into danger by signs of life" : 10,
            "Recorded message reveals a threat or complication" : 10,
            "Sealed door or hatch blocks access" : 10,
            "Signs of unwelcome invaders" : 10,
            "Unsettling sound or disturbance" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomLivingOpportunity() -> String {
        
        let dictionary = [
            "Culturally significant object or artifact" : 1,
            "Hidden stash of valuable contraband" : 1,
            "Intact barricade or protected area" : 1,
            "Recorded message reveals helpful aspects of this site" : 1,
            "Useful personal gear" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //MEDICAL
    var medicalAreaList = ["Crematorium", "Operating room", "Emergency or triage", "Pharmacy or drug locker", "Isolation or containment", "Prosthetics workshop", "Medical lab", "Ward or clinic", "Medical offices", "New zone", "Morgue", "New zone via Access"]
    func randomMedicalArea() -> String {
        
        let dictionary = [
            "Crematorium" : 8,
            "Operating room" : 8,
            "Emergency or triage" : 8,
            "Pharmacy or drug locker" : 8,
            "Isolation or containment" : 8,
            "Prosthetics workshop" : 8,
            "Medical lab" : 8,
            "Ward or clinic" : 8,
            "Medical offices" : 8,
            "New zone" : 5,
            "Morgue" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomMedicalFeature() -> String {
        
        let dictionary = [
            "Autopsied corpse" : 8,
            "Dissected specimen" : 8,
            "Biological specimens" : 8,
            "Improvised overflow beds" : 8,
            "Blood spatter or pools" : 8,
            "Medical monitors" : 8,
            "Bloody medical supplies" : 8,
            "Medical records or scans" : 8,
            "Broken prosthetics" : 8,
            "Stacks of body bags" : 8,
            "Corpse of a healer" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomMedicalPeril() -> String {
        
        let dictionary = [
            "Disgusting sight / smell" : 10,
            "Disturbing evidence of medical misconduct" : 10,
            "Erratic medical bots" : 10,
            "Evidence of a virulent disease" : 10,
            "Malfunctioning medical equipment" : 10,
            "Repercussions of a medical experiment" : 10,
            "Restless dead" : 10,
            "Signs of a horrific death" : 10,
            "Signs of broken quarantine" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomMedicalOpportunity() -> String {
        
        let dictionary = [
            "Cache of medicine" : 1,
            "Clues to a medical mystery" : 1,
            "Helpful medical bot" : 1,
            "Unusual or rare specimen" : 1,
            "Useful medical equipment" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //OPERATIONS
    var operationsAreaList = ["Admin or command offices", "Conference or briefing room", "Armory", "Landing bay or hangar", "Bridge or command center", "Lounge", "Brig or cells", "Security", "Comms center", "New zone", "Computer core", "New zone via Access"]
    func randomOperationsArea() -> String {
        
        let dictionary = [
            "Admin or command offices" : 8,
            "Conference or briefing room" : 8,
            "Armory" : 8,
            "Landing bay or hangar" : 8,
            "Bridge or command center" : 8,
            "Lounge" : 8,
            "Brig or cells" : 8,
            "Security" : 8,
            "Comms center" : 8,
            "New zone" : 5,
            "Computer core" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomOperationsFeature() -> String {
        
        let dictionary = [
            "Automated warning" : 8,
            "Intricate control panels" : 8,
            "Buckled blast doors" : 8,
            "Map of the site" : 8,
            "Control terminal" : 8,
            "Recorded message" : 8,
            "Emergency lighting" : 8,
            "Video surveillance monitors" : 8,
            "EV suit storage" : 8,
            "Written logs" : 8,
            "Hissing comms channel" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomOperationsPeril() -> String {
        
        let dictionary = [
            "Automated defenses target you" : 10,
            "Broken equipment limits control" : 10,
            "Coded message or puzzling security device" : 10,
            "Discouraging evidence of failed plans or defenses" : 10,
            "Displays reveal a new threat elsewhere in this site" : 10,
            "Failing power" : 10,
            "Hostile AI" : 10,
            "Sealed blast doors block access" : 10,
            "Sensors indicate the arrival of an external threat" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomOperationsOpportunity() -> String {
        
        let dictionary = [
            "Cache of weapons or ammo" : 1,
            "Helpful AI" : 1,
            "Keycard or access code" : 1,
            "Log offers insight into this site’s downfall" : 1,
            "Secure area offers a moment of peace" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //PRODUCTION
    var productionAreaList = ["Airlock or staging area", "Monitoring or control room", "Assembly or processing", "Processed goods storage", "Cargo bay", "Raw materials storage", "Equipment storage", "Scrapyard", "Exosuit bay", "New zone", "Harvesting or mining platform", "New zone via Access"]
    func randomProductionArea() -> String {
        
        let dictionary = [
            "Airlock or staging area" : 8,
            "Monitoring or control room" : 8,
            "Assembly or processing" : 8,
            "Processed goods storage" : 8,
            "Cargo bay" : 8,
            "Raw materials storage" : 8,
            "Equipment storage" : 8,
            "Scrapyard" : 8,
            "Exosuit bay" : 8,
            "New zone" : 5,
            "Harvesting or mining platform" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomProductionFeature() -> String {
        
        let dictionary = [
            "Cargo lifts" : 8,
            "Immense machinery" : 8,
            "Control panels" : 8,
            "Sealed or locked containers" : 8,
            "Disassembled machinery" : 8,
            "Tools" : 8,
            "Elevated walkways" : 8,
            "Vats of chemicals or gas" : 8,
            "Environment suits" : 8,
            "Written manifest" : 8,
            "Illfated workers" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomProductionPeril() -> String {
        
        let dictionary = [
            "Claustrophobic spaces" : 10,
            "Dangerous machinery" : 10,
            "Disturbing evidence of exploited labor" : 10,
            "Extreme temperatures" : 10,
            "Hazardous materials" : 10,
            "Impending industrial disaster" : 10,
            "Malfunctioning automation" : 10,
            "Rivals seek to secure these resources" : 10,
            "Signs of an unearthed or manufactured threat" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomProductionOpportunity() -> String {
        
        let dictionary = [
            "Helpful vehicle or transport" : 1,
            "Rare or valuable resource" : 1,
            "Salvageable materials" : 1,
            "Useful equipment" : 1,
            "Valuable cargo" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    //RESEARCH
    var researchAreaList = ["Clean room", "Isolation or containment", "Cold storage", "Lab", "Creature or animal pens", "Library or records", "Decontamination room", "Secure vault", "Hazardous material storage", "New zone", "Hydroponics or agriculture", "New zone via Access"]
    func randomResearchArea() -> String {
        
        let dictionary = [
            "Clean room" : 8,
            "Isolation or containment" : 8,
            "Cold storage" : 8,
            "Lab" : 8,
            "Creature or animal pens" : 8,
            "Library or records" : 8,
            "Decontamination room" : 8,
            "Secure vault" : 8,
            "Hazardous material storage" : 8,
            "New zone" : 5,
            "Hydroponics or agriculture" : 8,
            "New zone via Access" : 15,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomResearchFeature() -> String {
        
        let dictionary = [
            "Aquarium or tank" : 8,
            "Hazmat suits" : 8,
            "Biological specimens" : 8,
            "Inscrutable artifact" : 8,
            "Bones or fossils" : 8,
            "Invasive plant growth" : 8,
            "Broken equipment" : 8,
            "Recorded research log" : 8,
            "Cryptic research notes" : 8,
            "Spilled chemicals" : 8,
            "Hastily destroyed data" : 8,
            "\(oracle.description()) + \(oracle.focus())" : 12,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomResearchPeril() -> String {
        
        let dictionary = [
            "Automated containment protocols are activated" : 10,
            "Biological infestation" : 10,
            "Dangerous specimen" : 10,
            "Disturbing outcome of a failed experiment" : 10,
            "Evidence of sinister experiments" : 10,
            "Fragile vault holds a dire threat" : 10,
            "Signs of broken containment" : 10,
            "Toxic environment" : 10,
            "Unstable technology" : 10,
            "Roll twice" : 2,
            "\(oracle.action()) + \(oracle.theme())" : 8,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    func randomResearchOpportunity() -> String {
        
        let dictionary = [
            "Helpful research data" : 1,
            "Records of a notable discovery" : 1,
            "Specialized research tools" : 1,
            "Unique prototype" : 1,
            "Useful navigational data" : 1,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
}
