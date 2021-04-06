//
//  MockFactory.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation

enum MockFactory {
    static func getNewMock<T: Codable>() -> T {
        guard let pathString = Bundle.main.path(forResource: "mock_character_list", ofType: "json") else {
            fatalError("mock_character_list.json not found")
        }
        
        do {
            let fileURL = URL(fileURLWithPath: pathString)
            let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            fatalError("mock_character_list.json could no be decoded")
        }
    }
}
