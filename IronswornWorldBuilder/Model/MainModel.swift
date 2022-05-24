//
//  MainModel.swift
//  IronswornWorldBuilder
//
//  Created by Lindar Olostur on 25.04.2022.
//

import Foundation

enum Rank: String, Codable, Hashable, Equatable, CaseIterable {
    case troublesome
    case dangerous
    case formidable
    case extreme
    case epic
}
enum Theme: String, Codable, Hashable, Equatable, CaseIterable  {
    case Chaotic
    case Fortified
    case Haunted
    case Infested
    case Inhabited
    case Ruined
    case Sacred
    case Ancient
    case Corrupted
    case Hallowed
    case Ravaged
    case Wild
}

enum Domain: String, Codable, Hashable, Equatable, CaseIterable  {
    case barrow
    case cavern
    case frozenCavern
    case icereach
    case mine
    case pass
    case ruin
    case seaCave
    case shadowfen
    case stronghold
    case tanglewood
    case underkeep
    case derilict
    case precursorsVault
    case settlement
    case starship
    case planet
}
