//
//  Character.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let imageURLString: String
    let status: String
    let nickname: String
    let appearance: [Int]?
    let portrayed: String
    let category: String
    let betterCallSaulAppearance: [Int]
    
    enum CodingKeys: String, CodingKey {
        case name, birthday, occupation, status, nickname, appearance, portrayed, category
        case id = "char_id"
        case imageURLString = "img"
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
    
    enum Season: String, Codable {
        case all
        case S1
        case S2
        case S3
        case S4
        case S5
    }
}

extension CharacterModel.Season: CaseIterable { }
