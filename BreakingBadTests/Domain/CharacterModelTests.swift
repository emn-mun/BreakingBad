//
//  CharacterModelTests.swift
//  BreakingBadTests
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import XCTest
@testable import BreakingBad

final class CharacterModelTests: XCTestCase {
    func testDecodeCharacterList() {
        let characters: [CharacterModel] = MockFactory.getNewMock()
        XCTAssertEqual(characters.count, 63)
    }
    
    func testDecodeCharacterDetails() {
        let characters: [CharacterModel] = MockFactory.getNewMock()
        let firstCharacter = characters.first!
        
        XCTAssertEqual(firstCharacter.id, 1)
        XCTAssertEqual(firstCharacter.name, "Walter White")
        XCTAssertEqual(firstCharacter.birthday, "09-07-1958")
        XCTAssertEqual(firstCharacter.occupation, ["High School Chemistry Teacher", "Meth King Pin"])
        XCTAssertEqual(firstCharacter.imageURLString, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        XCTAssertEqual(firstCharacter.status, "Presumed dead")
        XCTAssertEqual(firstCharacter.nickname, "Heisenberg")
        XCTAssertEqual(firstCharacter.appearance, [1, 2, 3, 4, 5])
        XCTAssertEqual(firstCharacter.portrayed, "Bryan Cranston")
        XCTAssertEqual(firstCharacter.category, "Breaking Bad")
        XCTAssertEqual(firstCharacter.betterCallSaulAppearance, [1, 2, 3, 4])
    }
}
