//
//  CharacterListPresenter.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation

protocol CharacterListPresentable {
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void)
    func showCharacterDetails(character: CharacterModel)
}

final class CharacterListPresenter: CharacterListPresentable {
    private let router: RouterContract
    private let repository: CharacterListRepositoryProtocol
    
    init(router: RouterContract, repository: CharacterListRepositoryProtocol) {
        self.router = router
        self.repository = repository
    }
    
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        repository.fetchCharacters(completion: completion)
    }
    
    func showCharacterDetails(character: CharacterModel) {
        router.presentCharacterDetails(character: character)
    }
}
