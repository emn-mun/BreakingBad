//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Emanuel Munteanu on 28/08/2021.
//

import XCTest
import RxBlocking
@testable import BreakingBad

final class CharacterListViewModelTests: XCTestCase {
    private var repository: CharacterListRepositoryMock!
    private var viewModel: CharacterListViewModelling!
    private var router: RouterContractMock!
    
    override func setUp() {
        repository = CharacterListRepositoryMock()
        router = RouterContractMock()
        viewModel = CharacterListViewModel(router: router, repository: repository)
    }

    override func tearDown() {
    }

    func test_givenViewModelInitialised_expectNetworkRequestTriggered() {
        XCTAssertTrue(repository.fetchTriggered)
    }

    func test_givenViewSetupNoFilters_expectFullMovieCharactersArray() {
        viewModel.searchTextObserver.onNext(nil)
        viewModel.selectedSeasonIndex.onNext(0)
        
        let result = try! viewModel.filteredCharacters.toBlocking().first()
        XCTAssertEqual(result?.count, 63)
    }
    
    func test_givenFilterForTextInAllSeasons_expectRelatedMovieCharactersArray() {
        viewModel.searchTextObserver.onNext("wa")
        viewModel.selectedSeasonIndex.onNext(0)
        
        let result = try! viewModel.filteredCharacters.toBlocking().first()
        XCTAssertEqual(result?.count, 4)
    }
    
    func test_givenFilterForTextAndSeasonThree_expectRelatedMovieCharactersArray() {
        viewModel.searchTextObserver.onNext("wa")
        viewModel.selectedSeasonIndex.onNext(4)
        
        let result = try! viewModel.filteredCharacters.toBlocking().first()
        XCTAssertEqual(result?.count, 2)
    }

    
    func test_givenSelectedMovieCharacter_routerWillPresentDetailsViewController() {
        viewModel.searchTextObserver.onNext(nil)
        viewModel.selectedSeasonIndex.onNext(0)
        viewModel.itemSelectedIndex.onNext(IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(router.presentedCharacterDetails)
        XCTAssertEqual(router.presentedCharacter?.nickname, "Cap n\' Cook")
    }
}

final class CharacterListRepositoryMock: CharacterListRepositoryProtocol {
    var fetchTriggered = false
    
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        fetchTriggered = true
        completion(.success(MockFactory.getNewMock()))
    }
}

final class RouterContractMock: RouterContract {
    var presentedCharacterDetails = false
    var presentedCharacter: CharacterModel?
    
    func presentCharacterList() {
        
    }
    
    func presentCharacterDetails(character: CharacterModel) {
        presentedCharacterDetails = true
        presentedCharacter = character
    }
}
