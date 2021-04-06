//
//  CharacterDetailsViewModelTests.swift
//  BreakingBadTests
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import XCTest
@testable import BreakingBad

final class CharacterDetailsViewModelTests: XCTestCase {

    func testOrderDetailsViewModel() {
        let characters: [CharacterModel] = MockFactory.getNewMock()
        let firstCharacter = characters.first!
        let viewModel = CharacterDetailsViewModel(model: firstCharacter)
        
        XCTAssertEqual(viewModel.imageURLString, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        XCTAssertEqual(viewModel.name, "Name: Walter White")
        XCTAssertEqual(viewModel.nickname, "Nickname: Heisenberg")
        XCTAssertEqual(viewModel.occupation, "Occupation: High School Chemistry Teacher, Meth King Pin")
        XCTAssertEqual(viewModel.seasonAppearance, "Season appearance: 1, 2, 3, 4, 5")
        XCTAssertEqual(viewModel.status, "Status: Presumed dead")
    }
}
