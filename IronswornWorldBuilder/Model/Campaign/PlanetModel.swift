//
//  PlanetModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 12.05.2022.
//

import Foundation

struct Planet: Codable, Hashable, Identifiable {

    var id = UUID()
    var homeSector = ""
    var homeStar = ""
    var name = ""
    var subName = ""
    var hiddenDescription = true
    var description = ""
    var hiddenType = true
    var type = "Unknown World" {
        didSet {
            switch type {
            case "Desert World" :
                description = "A pitiless planet of searing heat, blowing sand, and sunbaked rock."
            case "Furnance World" :
                description = "A planet with relentless volcanic activity, wreathed in fire and ash."
            case "Grave World" :
                description = "A once-thriving world—now a grim monument to a fallen civilization."
            case "Ice World" :
                description = "A rugged, frozen world—locked in an unending winter."
            case "Jovian World" :
                description = "A massive planet with vast layers of dense gases surrounding a small rocky core."
            case "Jungle World" :
                description = "A humid, rain-soaked planet which keeps its secrets under a thick canopy of vegetation."
            case "Ocean World" :
                description = "A planet completely or mostly covered by a boundless ocean."
            case "Rocky World" :
                description = "A rugged planet scarred by eons of destructive asteroid impacts."
            case "Shattered World" :
                description = "A planet sundered by cataclysmic destruction."
            case "Tainted World" :
                description = "A foul planet wracked by a poisonous climate and virulent growths."
            case "Vital World" :
                description = "This diverse, life-bearing planet might provide some small measure of hope."
            default:
                description = ""
            }
        }
    }
    var hiddenAtmosphere = true
    var atmosphere = ""
    var hiddenViewFromSpace = true
    var viewFromSpace: [StringContainer] = []
    var hiddenFeatures = true
    var features: [StringContainer] = []
    var hiddenSettlements = true
    var settlements: [Settlement] = []
    var hiddenLife = true
    var life = ""
    var hiddenBiomes = true
    var biomes: [StringContainer] = []
    var hiddenRoutes = true
    var routes: [Route] = []
    
    var oracle = Oracle.sharedOracle
    var mode = "Input"
    var travelMode = false
    
    var typeList = ["Desert World", "Furnance World", "Grave World", "Ice World", "Jovian World", "Jungle World", "Ocean World", "Rocky World", "Shattered World", "Tainted World", "Vital World", "Unknown World"]
    func randomPlanetType() -> String {
        let dictionary = [
            "Desert World" : 15,
            "Furnance World" : 15,
            "Grave World" : 5,
            "Ice World" : 15,
            "Jovian World" : 15,
            "Jungle World" : 5,
            "Ocean World" : 5,
            "Rocky World" : 15,
            "Shattered World" : 2,
            "Tainted World" : 6,
            "Vital World" : 2,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func randomName(type: String) -> String {
        

        var nameList: [String] = []
        
        switch type {
        case "Desert World" :
            nameList = ["Abalos", "Audun", "Bishop", "Desolation", "Dykuma", "Fallow", "Helios", "Mirage", "Morricone", "Nux", "Ordos", "Petra", "Pyla", "Sabulo", "Saffron", "Sirocco", "Sulis", "Torrid", "Umber", "Vermillion"]
        case "Furnance World" :
            nameList = ["Ash", "Azula", "Cinder", "Cyrus", "Draconus", "Effigy", "Vesuvius", "Ember", "Flint", "Hades", "Hera", "Ignis", "Inferno", "Ishum", "Kresnik", "Nemesis", "Obsidian", "Scorch", "Tana", "Vesta"]
        case "Grave World" :
            nameList = ["Anubis", "Banshee", "Barrow", "Cairn", "Cerberus", "Charon", "Elysia", "Keen", "Kur", "Lament", "Mantus", "Morrigan", "Mourn", "Necropolis", "Orcus", "Osiris", "Requim", "Stygia", "Tartarus", "Thrace"]
        case "Ice World" :
            nameList = ["Beira", "Boreas", "Caradhras", "Cicero", "Demetria", "Enten", "Fissure", "Frost", "Gelida", "Jotunn", "Kanna", "Karn", "Kheimon", "Moroz", "Nix", "Olwen", "Osolok", "Taiga", "Thule", "Varnholme"]
        case "Jovian World" :
            nameList = ["Aether", "Arrokoth", "Esen", "Hanish", "Magnus", "Magonia", "Mistral", "Nephele", "Nimbus", "Nuada", "Nubium", "Serein", "Stratus", "Taranis", "Tempest", "Tenzin", "Tyr", "Veil", "Velum", "Zephyr"]
        case "Jungle World" :
            nameList = ["Acacia", "Aster", "Beryl", "Celadon", "Ceres", "Damu", "Dryad", "Flora", "Iridum", "Iris", "Kishar", "Penumbra", "Roris", "Sylva", "Tangle", "Thorn", "Venom", "Verdure", "Veris", "Viridian"]
        case "Ocean World" :
            nameList = ["Aegir", "Alon", "Clarion", "Darya", "Eldoris", "Horizon", "Hydra", "Kai", "Larimar", "Lotan", "Mira", "Navini", "Nerida", "Oceanus", "Pelagic", "Proteus", "Russalka", "Siren", "Thalassa", "Triton"]
        case "Rocky World" :
            nameList = ["Aphelion", "Artemis", "Capella", "Cobalt", "Crag", "Dusk", "Eos", "Hecate", "Imbrium", "Latona", "Losna", "Orpheus", "Ory", "Quietus", "Selene", "Silas", "Silex", "Slate", "Themis", "Umbra"]
        case "Shattered World" :
            nameList = ["Cavus", "Chrysalis", "Fragment", "Havoc", "Keres", "Lux", "Nemain", "Praxis", "Riven", "Schism", "Shell", "Slag", "Sliver", "Sunder", "Torment", "Vestige", "Vigrid", "Vortex", "Wrath", "Zix"]
        case "Tainted World" :
            nameList = ["Achlys", "Animus", "Bane", "Blight", "Carrion", "Chitin", "Datura", "Dreck", "Erra", "Febris", "Malacia", "Miasma", "Morbus", "Pathosis", "Pestis", "Scourge", "Telium", "Timoris", "Verus", "Xanthous"]
        case "Vital World" :
            nameList = ["Chiron", "Demeter", "Erebos", "Erembour", "Feronia", "Fortuna", "Gaia", "Harbinger", "Haven", "Hope", "Morpheus", "Nemus", "Sapphire", "Serenity", "Sif", "Silva", "Sirona", "Solstice", "Vale", "Valinor"]
        default:
            nameList = ["Achlys", "Animus", "Bane", "Blight", "Carrion", "Chitin", "Datura", "Dreck", "Erra", "Febris", "Malacia", "Miasma", "Morbus", "Pathosis", "Pestis", "Scourge", "Telium", "Timoris", "Verus", "Xanthous", "Cavus", "Chrysalis", "Fragment", "Havoc", "Keres", "Lux", "Nemain", "Praxis", "Riven", "Schism", "Shell", "Slag", "Sliver", "Sunder", "Torment", "Vestige", "Vigrid", "Vortex", "Wrath", "Zix", "Aphelion", "Artemis", "Capella", "Cobalt", "Crag", "Dusk", "Eos", "Hecate", "Imbrium", "Latona", "Losna", "Orpheus", "Ory", "Quietus", "Selene", "Silas", "Silex", "Slate", "Themis", "Umbra", "Aegir", "Alon", "Clarion", "Darya", "Eldoris", "Horizon", "Hydra", "Kai", "Larimar", "Lotan", "Mira", "Navini", "Nerida", "Oceanus", "Pelagic", "Proteus", "Russalka", "Siren", "Thalassa", "Triton", "Acacia", "Aster", "Beryl", "Celadon", "Ceres", "Damu", "Dryad", "Flora", "Iridum", "Iris", "Kishar", "Penumbra", "Roris", "Sylva", "Tangle", "Thorn", "Venom", "Verdure", "Veris", "Viridian", "Aether", "Arrokoth", "Esen", "Hanish", "Magnus", "Magonia", "Mistral", "Nephele", "Nimbus", "Nuada", "Nubium", "Serein", "Stratus", "Taranis", "Tempest", "Tenzin", "Tyr", "Veil", "Velum", "Zephyr", "Beira", "Boreas", "Caradhras", "Cicero", "Demetria", "Enten", "Fissure", "Frost", "Gelida", "Jotunn", "Kanna", "Karn", "Kheimon", "Moroz", "Nix", "Olwen", "Osolok", "Taiga", "Thule", "Varnholme", "Anubis", "Banshee", "Barrow", "Cairn", "Cerberus", "Charon", "Elysia", "Keen", "Kur", "Lament", "Mantus", "Morrigan", "Mourn", "Necropolis", "Orcus", "Osiris", "Requim", "Stygia", "Tartarus", "Thrace", "Ash", "Azula", "Cinder", "Cyrus", "Draconus", "Effigy", "Vesuvius", "Ember", "Flint", "Hades", "Hera", "Ignis", "Inferno", "Ishum", "Kresnik", "Nemesis", "Obsidian", "Scorch", "Tana", "Vesta", "Abalos", "Audun", "Bishop", "Desolation", "Dykuma", "Fallow", "Helios", "Mirage", "Morricone", "Nux", "Ordos", "Petra", "Pyla", "Sabulo", "Saffron", "Sirocco", "Sulis", "Torrid", "Umber", "Vermillion", "Chiron", "Demeter", "Erebos", "Erembour", "Feronia", "Fortuna", "Gaia", "Harbinger", "Haven", "Hope", "Morpheus", "Nemus", "Sapphire", "Serenity", "Sif", "Silva", "Sirona", "Solstice", "Vale", "Valinor"]
        }
        
//        var pool: [String] = []
//
//        for (value, ratio) in dictionary {
//            pool.append(contentsOf: repeatElement(value, count: ratio))
//        }
        
        var answer = nameList.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var atmosphereList = ["None/Thin", "Toxic", "Corrosive", "Marginal", "Breathable", "Ideal", "Unknown"]
    func randomPlanetAtmosphere(type: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Desert World" :
            dictionary = [
                "None/Thin" : 10,
                "Toxic" : 15,
                "Corrosive" : 15,
                "Marginal" : 30,
                "Breathable" : 25,
                "Ideal" : 5,
            ]
        case "Furnance World" :
            dictionary = [
                "None/Thin" : 10,
                "Toxic" : 40,
                "Corrosive" : 15,
                "Marginal" : 25,
                "Breathable" : 10,
                "Ideal" : 0,
            ]
        case "Grave World" :
            dictionary = [
                "None/Thin" : 10,
                "Toxic" : 35,
                "Corrosive" : 25,
                "Marginal" : 20,
                "Breathable" : 10,
                "Ideal" : 0,
            ]
        case "Ice World" :
            dictionary = [
                "None/Thin" : 15,
                "Toxic" : 20,
                "Corrosive" : 5,
                "Marginal" : 30,
                "Breathable" : 25,
                "Ideal" : 5,
            ]
        case "Jovian World" :
            dictionary = [
                "None/Thin" : 0,
                "Toxic" : 50,
                "Corrosive" : 15,
                "Marginal" : 20,
                "Breathable" : 15,
                "Ideal" : 0,
            ]
        case "Jungle World" :
            dictionary = [
                "None/Thin" : 0,
                "Toxic" : 25,
                "Corrosive" : 5,
                "Marginal" : 30,
                "Breathable" : 30,
                "Ideal" : 10,
            ]
        case "Ocean World" :
            dictionary = [
                "None/Thin" : 5,
                "Toxic" : 15,
                "Corrosive" : 5,
                "Marginal" : 35,
                "Breathable" : 30,
                "Ideal" : 10,
            ]
        case "Rocky World" :
            dictionary = [
                "None/Thin" : 65,
                "Toxic" : 20,
                "Corrosive" : 5,
                "Marginal" : 10,
                "Breathable" : 0,
                "Ideal" : 0,
            ]
        case "Shattered World" :
            dictionary = [
                "None/Thin" : 93,
                "Toxic" : 2,
                "Corrosive" : 2,
                "Marginal" : 2,
                "Breathable" : 1,
                "Ideal" : 0,
            ]
        case "Tainted World" :
            dictionary = [
                "None/Thin" : 0,
                "Toxic" : 65,
                "Corrosive" : 20,
                "Marginal" : 10,
                "Breathable" : 5,
                "Ideal" : 0,
            ]
        case "Vital World" :
            dictionary = [
                "None/Thin" : 0,
                "Toxic" : 0,
                "Corrosive" : 0,
                "Marginal" : 20,
                "Breathable" : 30,
                "Ideal" : 50,
            ]
        default:
            dictionary = [
                "None/Thin" : 1,
                "Toxic" : 1,
                "Corrosive" : 1,
                "Marginal" : 1,
                "Breathable" : 1,
                "Ideal" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func viewFromSpaceList(type: String) -> [String] {
        
        switch type {
        case "Desert World" :
            return ["Dry seabeds", "Expansive dune seas", "Massive canyons", "Perpetual daylight", "Rugged mountains", "Sprawling salt flats", "Vast plateaus", "Vibrant terrain colors", "Location", "Unknown"]
        case "Furnance World" :
            return ["Fiery world-spanning chasms", "Glowing rivers of lava", "Lightning-wracked ash clouds", "Magma seas", "Massive supervolcano", "Once verdant terrain", "Towering mountain ranges", "World-spanning fissures", "Location", "Unknown"]
        case "Grave World" :
            return ["Broken moon", "Cratered surface", "Dry seabeds", "Irradiated atmosphere", "Orbiting ship graveyard", "Perpetual overcast", "Sky-breaching ruins", "Vast wastelands", "Location", "Unknown"]
        case "Ice World" :
            return ["Feeble sunlight", "Frozen oceans", "Rocky glacial islands", "Snowbound mountains", "Sky-breaching geysers", "Supersized ice volcano", "Vibrantly colored ice", "World-spanning ice canyon", "Location", "Unknown"]
        case "Jovian World" :
            return ["Complex ring system", "Intense gravity well", "Numerous moons", "Perpetual superstorm", "Powerful magnetic field", "Severe electrical storms", "Superheated atmosphere", "Unusual atmospheric colors", "Location", "Unknown"]
        case "Jungle World" :
            return ["Cloud-breaching trees", "Expansive rivers or wetlands", "Inland seas", "Massive canyons", "Persistent cloud cover", "Towering mountains", "Unbroken canopy", "Unusual vegetation color", "Location", "Unknown"]
        case "Ocean World" :
            return ["Complex reef systems", "Emerging volcanoes", "Floating forests", "Global hurricanes", "Large moon and strong tides", "Scattered islands", "Semi-frozen oceans", "Unusual water color", "Location", "Unknown"]
        case "Rocky World" :
            return ["Barren plains", "Constant asteroid strikes", "Dense ring system", "Jagged mountains", "Massive impact crater", "Misshapen form (low gravity)", "Perpetual night", "Towering plateaus", "Location", "Unknown"]
        case "Shattered World" :
            return ["Demolished space fleet", "Dense ring system", "Fiery planetary core", "Geomagnetic storms", "Intense solar radiation", "Preserved planetary fragment", "Swirling debris field", "Unbroken moon", "Location", "Unknown"]
        case "Tainted World" :
            return ["Expansive fungal plains", "Fungal forests", "Scabrous, infected terrain", "Sky-breaching fungus", "Sludge-filled river networks", "Stagnant cloud cover", "Thick, murky atmosphere", "Toxic seas", "Location", "Unknown"]
        case "Vital World" :
            return ["Complex ring system", "Dramatic seasonal variation", "High gravity", "Large moon", "Narrow livable band", "Numerous small moons", "Unusual day or night cycle", "Vibrantly colored landscapes", "Location", "Unknown"]
        default:
            return ["Unknown"]
        }
    }
    func randomViewFromSpace(type: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Desert World" :
            dictionary = [
                "Dry seabeds" : 11,
                "Expansive dune seas" : 11,
                "Massive canyons" : 11,
                "Perpetual daylight" : 11,
                "Rugged mountains" : 11,
                "Sprawling salt flats" : 11,
                "Vast plateaus" : 11,
                "Vibrant terrain colors" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Furnance World" :
            dictionary = [
                "Fiery world-spanning chasms" : 11,
                "Glowing rivers of lava" : 11,
                "Lightning-wracked ash clouds" : 11,
                "Magma seas" : 11,
                "Massive supervolcano" : 11,
                "Once verdant terrain" : 11,
                "Towering mountain ranges" : 11,
                "World-spanning fissures" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Grave World" :
            dictionary = [
                "Broken moon" : 11,
                "Cratered surface" : 11,
                "Dry seabeds" : 11,
                "Irradiated atmosphere" : 11,
                "Orbiting ship graveyard" : 11,
                "Perpetual overcast" : 11,
                "Sky-breaching ruins" : 11,
                "Vast wastelands" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Ice World" :
            dictionary = [
                "Feeble sunlight" : 11,
                "Frozen oceans" : 11,
                "Rocky glacial islands" : 11,
                "Snowbound mountains" : 11,
                "Sky-breaching geysers" : 11,
                "Supersized ice volcano" : 11,
                "Vibrantly colored ice" : 11,
                "World-spanning ice canyon" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Jovian World" :
            dictionary = [
                "Complex ring system" : 11,
                "Intense gravity well" : 11,
                "Numerous moons" : 11,
                "Perpetual superstorm" : 11,
                "Powerful magnetic field" : 11,
                "Severe electrical storms" : 11,
                "Superheated atmosphere" : 11,
                "Unusual atmospheric colors" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Jungle World" :
            dictionary = [
                "Cloud-breaching trees" : 11,
                "Expansive rivers or wetlands" : 11,
                "Inland seas" : 11,
                "Massive canyons" : 11,
                "Persistent cloud cover" : 11,
                "Towering mountains" : 11,
                "Unbroken canopy" : 11,
                "Unusual vegetation color" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Ocean World" :
            dictionary = [
                "Complex reef systems" : 11,
                "Emerging volcanoes" : 11,
                "Floating forests" : 11,
                "Global hurricanes" : 11,
                "Large moon and strong tides" : 11,
                "Scattered islands" : 11,
                "Semi-frozen oceans" : 11,
                "Unusual water color" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Rocky World" :
            dictionary = [
                "Barren plains" : 11,
                "Constant asteroid strikes" : 11,
                "Dense ring system" : 11,
                "Jagged mountains" : 11,
                "Massive impact crater" : 11,
                "Misshapen form (low gravity)" : 11,
                "Perpetual night" : 11,
                "Towering plateaus" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Shattered World" :
            dictionary = [
                "Demolished space fleet" : 11,
                "Dense ring system" : 11,
                "Fiery planetary core" : 11,
                "Geomagnetic storms" : 11,
                "Intense solar radiation" : 11,
                "Preserved planetary fragment" : 11,
                "Swirling debris field" : 11,
                "Unbroken moon" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Tainted World" :
            dictionary = [
                "Expansive fungal plains" : 11,
                "Fungal forests" : 11,
                "Scabrous, infected terrain" : 11,
                "Sky-breaching fungus" : 11,
                "Sludge-filled river networks" : 11,
                "Stagnant cloud cover" : 11,
                "Thick, murky atmosphere" : 11,
                "Toxic seas" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        case "Vital World" :
            dictionary = [
                "Complex ring system" : 11,
                "Dramatic seasonal variation" : 11,
                "High gravity" : 11,
                "Large moon" : 11,
                "Narrow livable band" : 11,
                "Numerous small moons" : 11,
                "Unusual day or night cycle" : 11,
                "Vibrantly colored landscapes" : 11,
                "\(oracle.description()) + \(oracle.focus())" : 10,
                "Precursor Vault (orbital)" : 2,
            ]
        default:
            dictionary = [
                "Unknown" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func featureList(type: String) -> [String] {
        
        switch type {
        case "Desert World" :
            return ["Cavernous sinkholes", "Engulfing sandstorms", "Fleeting rainstorms and flash floods", "Flooded grottos", "Petrified forest", "Rampaging whirlwinds", "Scorched glass plains", "Severe temperature fluctuations", "Sunbaked bones of titanic creatures", "Timeworn cliffside caves", "Towering rock formations", "Violent electrical storms", "Windborne metallic sand", "Location", "Unknown"]
        case "Furnance World" :
            return ["Blinding ash storms", "Catastrophic earthquakes", "Colorful geothermal springs", "Intricate volcanic rock formations", "Lava tube tunnel networks", "Masses of scorched bones", "Plains of volcanic glass", "Pools of liquid metal", "Rocky islands adrift on magma", "Roiling clouds of superheated gas", "Scalding geysers", "Silica or metal storms", "Steaming mudflats", "Location", "Unknown"]
        case "Grave World" :
            return ["Acid pools", "Ash dunes", "Corrosive rains", "Dead forests", "Fetid mudflats", "Mass graves", "Moldering bones", "Noxious fog", "Radioactive hotspots", "Ravaged cities", "Scarred battlefields", "Ship graveyards", "Whispers of the dead", "Location", "Unknown"]
        case "Ice World" :
            return ["Abyssal ice fissures", "Blinding snow storms", "Clusters of ice spikes", "Colossal ice caves", "Glistening ice spires", "Massive snow drifts", "Preserved carcasses", "Rocky islands amid icy wastes", "Shattered plains of pack ice", "Steaming hot springs", "Subsurface liquid oceans", "Vibrant auroras", "Wind-carved ice formations", "Location", "Unknown"]
        case "Jovian World" :
            return ["Clouds of metal particles", "Crystalline rains", "Floating glaciers", "Floating islands", "Layer of suspended liquid", "Pockets of explosive gases", "Powerful vortexes", "Radiation fields", "Storm-swept rocky debris", "Torrential rain", "Towering thunderheads", "Violent turbulence", "Zones of localized atmosphere", "Location", "Unknown"]
        case "Jungle World" :
            return ["Bioluminescent flora", "Deep river gorges", "Extensive exposed root systems", "Immense tiered waterfalls", "Languid rivers", "Low-lying fog", "Plunging sinkholes", "Scarred clearings", "Sinking quagmires", "Surging rivers", "Torrential rainstorms", "Violent electrical storms", "Waterlogged caves", "Location", "Unknown"]
        case "Ocean World" :
            return ["Abyssal trenches", "Living islands", "Luminescent seas", "Roaming icebergs", "Shallow-water plains", "Subsurface volcanoes", "Titanic waves", "Undersea air pockets", "Undersea caves", "Undersea forests", "Unrelenting rainfall", "Violent currents", "Windborne waterspouts", "Location", "Unknown"]
        case "Rocky World" :
            return ["Crystalline formations", "Crystalline caves", "Exposed mineral deposits", "Geometric terrain features", "Geothermal vents", "Glassy impact craters", "Massive dust dunes", "Powerful magnetic fields", "Rubble-strewn lava fields", "Steam-heated caves", "Subsurface magma flows", "Swirling low-lying gases", "Towering rocky spires", "Location", "Unknown"]
        case "Shattered World" :
            return ["Broken cities", "Colliding fragments", "Energy storms", "Exposed caverns", "Fluctuating gravity", "Magnetic disturbances", "Molten fissures", "Phantom visions of the past", "Pocket atmosphere", "Residual energy storms", "Swirling corrosive gases", "Unstable and fracturing terrain", "Venting magma", "Location", "Unknown"]
        case "Tainted World" :
            return ["Caustic gas storms", "Corrosive, low-lying fog", "Fungus-encrusted caves", "Gelatinous ponds", "Hallucinogenic toxins", "Layers of fast-growing lichen", "Moldering bones", "Mutated flora", "Poisonous gas vents", "Spore clouds", "Terrain marred by fleshy pustules", "Toxic rain", "Virulent fungal infestations", "Location", "Unknown"]
        case "Vital World" :
            return ["Background radiation", "Chaotically juxtaposed biomes", "Creature boneyards", "Creature lairs or watering holes", "Crystalline formations", "Fierce electrical storms", "Floating terrain", "Frequent seismic activity", "Magnetic disturbances", "Scarred or excavated terrain", "Signs of an engineered biosphere", "Sudden weather fluctuations", "Towering geological formations", "Location", "Unknown"]
        default:
            return ["Unknown"]
        }
    }
    func randomFeature(type: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Desert World" :
            dictionary = [
                "Cavernous sinkholes" : 7,
                "Engulfing sandstorms" : 7,
                "Fleeting rainstorms and flash floods" : 7,
                "Flooded grottos" : 7,
                "Petrified forest" : 7,
                "Rampaging whirlwinds" : 7,
                "Scorched glass plains" : 7,
                "Severe temperature fluctuations" : 7,
                "Sunbaked bones of titanic creatures" : 7,
                "Timeworn cliffside caves" : 7,
                "Towering rock formations" : 7,
                "Violent electrical storms" : 7,
                "Windborne metallic sand" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Furnance World" :
            dictionary = [
                "Blinding ash storms" : 7,
                "Catastrophic earthquakes" : 7,
                "Colorful geothermal springs" : 7,
                "Intricate volcanic rock formations" : 7,
                "Lava tube tunnel networks" : 7,
                "Masses of scorched bones" : 7,
                "Plains of volcanic glass" : 7,
                "Pools of liquid metal" : 7,
                "Rocky islands adrift on magma" : 7,
                "Roiling clouds of superheated gas" : 7,
                "Scalding geysers" : 7,
                "Silica or metal storms" : 7,
                "Steaming mudflats" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Grave World" :
            dictionary = [
                "Acid pools" : 7,
                "Ash dunes" : 7,
                "Corrosive rains" : 7,
                "Dead forests" : 7,
                "Fetid mudflats" : 7,
                "Mass graves" : 7,
                "Moldering bones" : 7,
                "Noxious fog" : 7,
                "Radioactive hotspots" : 7,
                "Ravaged cities" : 7,
                "Scarred battlefields" : 7,
                "Ship graveyards" : 7,
                "Whispers of the dead" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Ice World" :
            dictionary = [
                "Abyssal ice fissures" : 7,
                "Blinding snow storms" : 7,
                "Clusters of ice spikes" : 7,
                "Colossal ice caves" : 7,
                "Glistening ice spires" : 7,
                "Massive snow drifts" : 7,
                "Preserved carcasses" : 7,
                "Rocky islands amid icy wastes" : 7,
                "Shattered plains of pack ice" : 7,
                "Steaming hot springs" : 7,
                "Subsurface liquid oceans" : 7,
                "Vibrant auroras" : 7,
                "Wind-carved ice formations" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Jovian World" :
            dictionary = [
                "Clouds of metal particles" : 7,
                "Crystalline rains" : 7,
                "Floating glaciers" : 7,
                "Floating islands" : 7,
                "Layer of suspended liquid" : 7,
                "Pockets of explosive gases" : 7,
                "Powerful vortexes" : 7,
                "Radiation fields" : 7,
                "Storm-swept rocky debris" : 7,
                "Torrential rain" : 7,
                "Towering thunderheads" : 7,
                "Violent turbulence" : 7,
                "Zones of localized atmosphere" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Jungle World" :
            dictionary = [
                "Bioluminescent flora" : 7,
                "Deep river gorges" : 7,
                "Extensive exposed root systems" : 7,
                "Immense tiered waterfalls" : 7,
                "Languid rivers" : 7,
                "Low-lying fog" : 7,
                "Plunging sinkholes" : 7,
                "Scarred clearings" : 7,
                "Sinking quagmires" : 7,
                "Surging rivers" : 7,
                "Torrential rainstorms" : 7,
                "Violent electrical storms" : 7,
                "Waterlogged caves" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Ocean World" :
            dictionary = [
                "Abyssal trenches" : 7,
                "Living islands" : 7,
                "Luminescent seas" : 7,
                "Roaming icebergs" : 7,
                "Shallow-water plains" : 7,
                "Subsurface volcanoes" : 7,
                "Titanic waves" : 7,
                "Undersea air pockets" : 7,
                "Undersea caves" : 7,
                "Undersea forests" : 7,
                "Unrelenting rainfall" : 7,
                "Violent currents" : 7,
                "Windborne waterspouts" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Rocky World" :
            dictionary = [
                "Crystalline formations" : 7,
                "Crystalline caves" : 7,
                "Exposed mineral deposits" : 7,
                "Geometric terrain features" : 7,
                "Geothermal vents" : 7,
                "Glassy impact craters" : 7,
                "Massive dust dunes" : 7,
                "Powerful magnetic fields" : 7,
                "Rubble-strewn lava fields" : 7,
                "Steam-heated caves" : 7,
                "Subsurface magma flows" : 7,
                "Swirling low-lying gases" : 7,
                "Towering rocky spires" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Shattered World" :
            dictionary = [
                "Broken cities" : 7,
                "Colliding fragments" : 7,
                "Energy storms" : 7,
                "Exposed caverns" : 7,
                "Fluctuating gravity" : 7,
                "Magnetic disturbances" : 7,
                "Molten fissures" : 7,
                "Phantom visions of the past" : 7,
                "Pocket atmosphere" : 7,
                "Residual energy storms" : 7,
                "Swirling corrosive gases" : 7,
                "Unstable and fracturing terrain" : 7,
                "Venting magma" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Tainted World" :
            dictionary = [
                "Caustic gas storms" : 7,
                "Corrosive, low-lying fog" : 7,
                "Fungus-encrusted caves" : 7,
                "Gelatinous ponds" : 7,
                "Hallucinogenic toxins" : 7,
                "Layers of fast-growing lichen" : 7,
                "Moldering bones" : 7,
                "Mutated flora" : 7,
                "Poisonous gas vents" : 7,
                "Spore clouds" : 7,
                "Terrain marred by fleshy pustules" : 7,
                "Toxic rain" : 7,
                "Virulent fungal infestations" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        case "Vital World" :
            dictionary = [
                "Background radiation" : 7,
                "Chaotically juxtaposed biomes" : 7,
                "Creature boneyards" : 7,
                "Creature lairs or watering holes" : 7,
                "Crystalline formations" : 7,
                "Fierce electrical storms" : 7,
                "Floating terrain" : 7,
                "Frequent seismic activity" : 7,
                "Magnetic disturbances" : 7,
                "Scarred or excavated terrain" : 7,
                "Signs of an engineered biosphere" : 7,
                "Sudden weather fluctuations" : 7,
                "Towering geological formations" : 7,
                "\(oracle.description()) + \(oracle.focus())" : 7,
                "Precursor Vault (planetside)" : 2,
            ]
        default:
            dictionary = [
                "Unknown" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func randomSettlement(homeRegion: String, planetType: String) -> String {

        var dictionary: [String: Int] = [:]
        
        switch planetType {
        case "Desert World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 50,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 20,
                    "Multiple settlements" : 12,
                    "Settlements in conflict" : 8,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 75,
                    "Orbital settlement" : 8,
                    "Planetside settlement" : 12,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Furnance World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 60,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 12,
                    "Multiple settlements" : 9,
                    "Settlements in conflict" : 4,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 7,
                    "Planetside settlement" : 5,
                    "Multiple settlements" : 2,
                    "Settlements in conflict" : 1,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Grave World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 80,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 5,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 7,
                    "Planetside settlement" : 3,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Ice World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 50,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 20,
                    "Multiple settlements" : 12,
                    "Settlements in conflict" : 8,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 75,
                    "Orbital settlement" : 8,
                    "Planetside settlement" : 12,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Jovian World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 50,
                    "Orbital settlement" : 20,
                    "Planetside settlement" : 15,
                    "Multiple settlements" : 10,
                    "Settlements in conflict" : 5,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 75,
                    "Orbital settlement" : 12,
                    "Planetside settlement" : 8,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Jungle World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 40,
                    "Orbital settlement" : 15,
                    "Planetside settlement" : 25,
                    "Multiple settlements" : 12,
                    "Settlements in conflict" : 8,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 65,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 17,
                    "Multiple settlements" : 5,
                    "Settlements in conflict" : 3,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 7,
                    "Multiple settlements" : 2,
                    "Settlements in conflict" : 1,
                ]
            default:
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 7,
                    "Multiple settlements" : 2,
                    "Settlements in conflict" : 1,
                ]
            }
        case "Ocean World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 40,
                    "Orbital settlement" : 15,
                    "Planetside settlement" : 25,
                    "Multiple settlements" : 12,
                    "Settlements in conflict" : 8,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 65,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 17,
                    "Multiple settlements" : 5,
                    "Settlements in conflict" : 3,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 7,
                    "Multiple settlements" : 2,
                    "Settlements in conflict" : 1,
                ]
            default:
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 7,
                    "Multiple settlements" : 2,
                    "Settlements in conflict" : 1,
                ]
            }
        case "Rocky World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 50,
                    "Orbital settlement" : 20,
                    "Planetside settlement" : 15,
                    "Multiple settlements" : 10,
                    "Settlements in conflict" : 5,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 75,
                    "Orbital settlement" : 12,
                    "Planetside settlement" : 8,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 6,
                    "Planetside settlement" : 4,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Shattered World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 70,
                    "Orbital settlement" : 20,
                    "Planetside settlement" : 5,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 85,
                    "Orbital settlement" : 11,
                    "Planetside settlement" : 3,
                    "Multiple settlements" : 1,
                    "Settlements in conflict" : 0,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 4,
                    "Planetside settlement" : 1,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 4,
                    "Planetside settlement" : 1,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Tainted World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 80,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 5,
                    "Multiple settlements" : 3,
                    "Settlements in conflict" : 2,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 90,
                    "Orbital settlement" : 7,
                    "Planetside settlement" : 3,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            default:
                dictionary = [
                    "None" : 95,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 2,
                    "Multiple settlements" : 0,
                    "Settlements in conflict" : 0,
                ]
            }
        case "Vital World" :
            switch homeRegion {
            case "Terminus" :
                dictionary = [
                    "None" : 20,
                    "Orbital settlement" : 10,
                    "Planetside settlement" : 40,
                    "Multiple settlements" : 20,
                    "Settlements in conflict" : 10,
                ]
            case "Outlands" :
                dictionary = [
                    "None" : 50,
                    "Orbital settlement" : 5,
                    "Planetside settlement" : 30,
                    "Multiple settlements" : 10,
                    "Settlements in conflict" : 5,
                ]
            case "Expanse" :
                dictionary = [
                    "None" : 80,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 10,
                    "Multiple settlements" : 5,
                    "Settlements in conflict" : 2,
                ]
            default:
                dictionary = [
                    "None" : 80,
                    "Orbital settlement" : 3,
                    "Planetside settlement" : 10,
                    "Multiple settlements" : 5,
                    "Settlements in conflict" : 2,
                ]
            }
        default:
            dictionary = [
                "Unknown" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var lifeList = ["None", "Extinct", "Simple", "Sparse", "Diverse", "Bountiful", "Overrun", "Unknown"]
    func randomLife(type: String) -> String {
        

        var dictionary: [String: Int] = [:]
        
        switch type {
        case "Desert World" :
            dictionary = [
                "None" : 25,
                "Extinct" : 20,
                "Simple" : 15,
                "Sparse" : 20,
                "Diverse" : 10,
                "Bountiful" : 7,
                "Overrun" : 3,
            ]
        case "Furnance World" :
            dictionary = [
                "None" : 30,
                "Extinct" : 20,
                "Simple" : 20,
                "Sparse" : 15,
                "Diverse" : 10,
                "Bountiful" : 3,
                "Overrun" : 2,
            ]
        case "Grave World" :
            dictionary = [
                "None" : 25,
                "Extinct" : 60,
                "Simple" : 10,
                "Sparse" : 5,
                "Diverse" : 0,
                "Bountiful" : 0,
                "Overrun" : 0,
            ]
        case "Ice World" :
            dictionary = [
                "None" : 25,
                "Extinct" : 20,
                "Simple" : 15,
                "Sparse" : 15,
                "Diverse" : 15,
                "Bountiful" : 7,
                "Overrun" : 3,
            ]
        case "Jovian World" :
            dictionary = [
                "None" : 50,
                "Extinct" : 5,
                "Simple" : 15,
                "Sparse" : 12,
                "Diverse" : 10,
                "Bountiful" : 5,
                "Overrun" : 3,
            ]
        case "Jungle World" :
            dictionary = [
                "None" : 0,
                "Extinct" : 0,
                "Simple" : 5,
                "Sparse" : 15,
                "Diverse" : 20,
                "Bountiful" : 35,
                "Overrun" : 20,
            ]
        case "Ocean World" :
            dictionary = [
                "None" : 5,
                "Extinct" : 10,
                "Simple" : 10,
                "Sparse" : 20,
                "Diverse" : 25,
                "Bountiful" : 20,
                "Overrun" : 10,
            ]
        case "Rocky World" :
            dictionary = [
                "None" : 55,
                "Extinct" : 10,
                "Simple" : 15,
                "Sparse" : 10,
                "Diverse" : 5,
                "Bountiful" : 3,
                "Overrun" : 2,
            ]
        case "Shattered World" :
            dictionary = [
                "None" : 30,
                "Extinct" : 50,
                "Simple" : 10,
                "Sparse" : 6,
                "Diverse" : 4,
                "Bountiful" : 0,
                "Overrun" : 0,
            ]
        case "Tainted World" :
            dictionary = [
                "None" : 0,
                "Extinct" : 0,
                "Simple" : 5,
                "Sparse" : 10,
                "Diverse" : 15,
                "Bountiful" : 25,
                "Overrun" : 45,
            ]
        case "Vital World" :
            dictionary = [
                "None" : 0,
                "Extinct" : 0,
                "Simple" : 0,
                "Sparse" : 10,
                "Diverse" : 35,
                "Bountiful" : 40,
                "Overrun" : 15,
            ]
        default:
            dictionary = [
                "None" : 1,
                "Extinct" : 1,
                "Simple" : 1,
                "Sparse" : 1,
                "Diverse" : 1,
                "Bountiful" : 1,
                "Overrun" : 1,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    var biomeList = ["Caves", "Cold forest", "Fungal", "Glacial or snow", "Grassland", "Islands", "Jungle", "Mountainous", "Ocean", "Rocky desert", "Sandy desert", "Savanna", "Shallow seas", "Shrubland", "Temperate rainforest", "Temperate forest", "Tundra", "Volcanic", "Waterways", "Wetland", "Unknown"]
    func randomBiome() -> String {
        let dictionary = [
            "Caves" : 5,
            "Cold forest" : 5,
            "Fungal" : 5,
            "Glacial or snow" : 5,
            "Grassland" : 5,
            "Islands" : 5,
            "Jungle" : 5,
            "Mountainous" : 5,
            "Ocean" : 5,
            "Rocky desert" : 5,
            "Sandy desert" : 5,
            "Savanna" : 5,
            "Shallow seas" : 5,
            "Shrubland" : 5,
            "Temperate rainforest" : 5,
            "Temperate forest" : 5,
            "Tundra" : 5,
            "Volcanic" : 5,
            "Waterways" : 5,
            "Wetland" : 5,
        ]
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }
    
    func randomPeril() -> String {
        
        var dictionary: [String: Int] = [:]
        
        if life == "None" || life == "Extinct" || life == "Simple" || life == "" {
            dictionary = [
                "Life is revealed or takes an unexpected form" : 3,
                "Blocked or impassible path" : 4,
                "Corrosive substance or environment" : 4,
                "Disturbing remains or evidence of death" : 4,
                "Drastic environmental change" : 4,
                "Enemy holds this area" : 4,
                "Entangling or engulfing hazard" : 4,
                "Equipment fails or malfunctions" : 4,
                "Guarded or patrolled path" : 4,
                "Led astray" : 4,
                "Lost the path" : 4,
                "Meteorites fall from the sky" : 4,
                "Radiated area or object" : 4,
                "Realization that something was left behind" : 4,
                "Seismic or volcanic upheaval" : 4,
                "Signs of a lurking or trailing foe" : 4,
                "Storm or atmospheric disruption" : 4,
                "Toxic or sickening environment" : 4,
                "Trap or alarm" : 4,
                "Treacherous or arduous path" : 4,
                "Troubling visions or apparitions" : 4,
                "Visibility hindered by atmospheric effects" : 4,
                "Worrying arrival of a ship or vehicle" : 4,
                "Wreckage or ruins portend a new threat" : 4,
                "\(oracle.action()) + \(oracle.theme())" : 4,
                "Roll twice" : 1,
            ]
        } else {
            dictionary = [
                "Corrupted or mutated lifeform" : 3,
                "Signs of a lifeform's power or cunning" : 3,
                "Hazardous plant life or malignant spores" : 3,
                "Lifeform hunts for prey" : 3,
                "Lifeform lairs here" : 3,
                "Lifeforms guided by a greater threat" : 3,
                "Lifeforms spooked or stampeding" : 3,
                "Threatening lifeform draws near" : 3,
                "Life is revealed or takes an unexpected form" : 3,
                "Blocked or impassible path" : 3,
                "Corrosive substance or environment" : 3,
                "Disturbing remains or evidence of death" : 3,
                "Drastic environmental change" : 3,
                "Enemy holds this area" : 3,
                "Entangling or engulfing hazard" : 3,
                "Equipment fails or malfunctions" : 3,
                "Guarded or patrolled path" : 3,
                "Led astray" : 3,
                "Lost the path" : 3,
                "Meteorites fall from the sky" : 3,
                "Radiated area or object" : 3,
                "Realization that something was left behind" : 3,
                "Seismic or volcanic upheaval" : 3,
                "Signs of a lurking or trailing foe" : 3,
                "Storm or atmospheric disruption" : 3,
                "Toxic or sickening environment" : 3,
                "Trap or alarm" : 3,
                "Treacherous or arduous path" : 3,
                "Troubling visions or apparitions" : 3,
                "Visibility hindered by atmospheric effects" : 3,
                "Worrying arrival of a ship or vehicle" : 3,
                "Wreckage or ruins portend a new threat" : 3,
                "\(oracle.action()) + \(oracle.theme())" : 3,
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
    func randomOpportunity() -> String {
        
        var dictionary: [String: Int] = [:]
        
        if life == "None" || life == "Extinct" || life == "Simple" || life == "" {
            dictionary = [
                "Encounter reveals unexpected benign lifeforms" : 5,
                "Abandoned camp or vehicle" : 5,
                "Advance warning of an environmental threat" : 5,
                "Clear path through otherwise perilous terrain" : 5,
                "Clue offers insight into a current quest or mystery" : 5,
                "Clue to the history or nature of this place" : 5,
                "Evidence that others have passed this way" : 5,
                "Foe reveals themselves or tips their hand" : 5,
                "Fortuitous change in the weather or atmosphere" : 5,
                "Friendly traveler crosses your path" : 5,
                "Helpful resource is in ample supply" : 5,
                "Impressive vista offers comfort or inspiration" : 5,
                "Interesting artifact or device" : 5,
                "Interesting site offers opportunities for exploration" : 5,
                "Moment of fellowship or inner peace" : 5,
                "Opening to distract, escape, or avoid foes" : 5,
                "Opening to get the drop on a foe" : 5,
                "Plea for help from a potential benefactor" : 5,
                "Refuge offers a place to hide, plan, or recover" : 5,
                "Vantage point reveals the lay of the land" : 5,
            ]
        } else {
            dictionary = [
                "Clue to a lifeform's nature or vulnerabilities" : 4,
                "Friendly interaction with a benign lifeform" : 4,
                "Hunting or foraging opportunities are plentiful" : 4,
                "Interesting or helpful aspect of benign creatures" : 4,
                "Interesting or helpful aspect of local plant life" : 4,
                "Encounter reveals unexpected benign lifeforms" : 4,
                "Abandoned camp or vehicle" : 4,
                "Advance warning of an environmental threat" : 4,
                "Clear path through otherwise perilous terrain" : 4,
                "Clue offers insight into a current quest or mystery" : 4,
                "Clue to the history or nature of this place" : 4,
                "Evidence that others have passed this way" : 4,
                "Foe reveals themselves or tips their hand" : 4,
                "Fortuitous change in the weather or atmosphere" : 4,
                "Friendly traveler crosses your path" : 4,
                "Helpful resource is in ample supply" : 4,
                "Impressive vista offers comfort or inspiration" : 4,
                "Interesting artifact or device" : 4,
                "Interesting site offers opportunities for exploration" : 4,
                "Moment of fellowship or inner peace" : 4,
                "Opening to distract, escape, or avoid foes" : 4,
                "Opening to get the drop on a foe" : 4,
                "Plea for help from a potential benefactor" : 4,
                "Refuge offers a place to hide, plan, or recover" : 4,
                "Vantage point reveals the lay of the land" : 4,
            ]
        }
        
        var pool: [String] = []
        
        for (value, ratio) in dictionary {
            pool.append(contentsOf: repeatElement(value, count: ratio))
        }
        
        var answer = pool.shuffled()
        
        return answer.popLast() ?? "error"
    }

}



