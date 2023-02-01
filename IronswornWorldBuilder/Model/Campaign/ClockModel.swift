//
//  ClockModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 22.07.2022.
//

import Foundation

struct Clock: Codable, Hashable, Identifiable {

    var id = UUID()
    var name = ""
    var description = ""
    var maxClock = 4
    var currentClock = 0 {
        didSet {
            if currentClock > maxClock {
                currentClock = maxClock
            }
        }
    }
    var maxList = [4, 6, 8, 10]
}

