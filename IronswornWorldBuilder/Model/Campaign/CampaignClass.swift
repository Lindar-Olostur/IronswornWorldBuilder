//
//  CampaignClass.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 04.05.2022.
//

import Foundation

class Campaign: ObservableObject {
    @Published var world = World()
    
    func getData(file: String) {
        world = load(file)
        UserDefaults.standard.set(world.name, forKey: "lastCampaign")
    }

    func getStarforged() {
        world = newStarforged()
        UserDefaults.standard.set(world.name, forKey: "lastCampaign")
    }
    
    func getIronsworn() {
        world = newIronsworn()
        UserDefaults.standard.set(world.name, forKey: "lastCampaign")
    }
    func newIronsworn<T: Decodable>() -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: "IronswornTemplate", withExtension: "json")
        else {
            fatalError("Couldn't find IronswornTemplate.json in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load IronswornTemplate.json from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse IronswornTemplate.json as \(T.self):\n\(error)")
        }
    }
    func newStarforged<T: Decodable>() -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: "StarforgedTemplate", withExtension: "json")
        else {
            fatalError("Couldn't find StarforgedTemplate.json in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load StarforgedTemplate.json from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse StarforgedTemplate.json as \(T.self):\n\(error)")
        }
    }
    
    func getStarSystem() {
        world = newStarSystem()
        UserDefaults.standard.set(world.name, forKey: "lastCampaign")
    }
    func newStarSystem<T: Decodable>() -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: "StarsTemplate", withExtension: "json")
        else {
            fatalError("Couldn't find StarsTemplate.json in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load StarsTemplate.json from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse StarsTemplate.json as \(T.self):\n\(error)")
        }
    }
    
    func getWorld() {
        world = newWorld()
        UserDefaults.standard.set(world.name, forKey: "lastCampaign")
    }
    func newWorld<T: Decodable>() -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: "WorldTemplate", withExtension: "json")
        else {
            fatalError("Couldn't find WorldTemplate.json in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load WorldTemplate.json from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse WorldTemplate.json as \(T.self):\n\(error)")
        }
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        let documentDirectoryPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileUrl = URL(fileURLWithPath: documentDirectoryPath)
        let file = fileUrl.absoluteURL.appendingPathComponent(filename)
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func writeToFile() {
        let documentDirectoryPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileUrl = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent("\(String(describing: world.name)).json")
            do{
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let JsonData = try encoder.encode(world)
                try JsonData.write(to: fileUrl)
                print("???????????????? ???????? \(world.name).json")
                print(fileUrl)
            } catch {
                print("???? ???????????????????? ????????????????")
        }
    }
}
