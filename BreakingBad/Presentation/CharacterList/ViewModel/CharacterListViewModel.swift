//
//  CharacterListPresenter.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol CharacterListViewModelling {
    var allSeasonNames: [String] { get }
    var filteredCharacters: Driver<[CharacterModel]> { get }
    
    var searchTextObserver: PublishSubject<String?> { get }
    var selectedSeasonIndex: PublishSubject<Int> { get }
    var itemSelectedIndex: PublishSubject<IndexPath> { get }

    func showCharacterDetails(character: CharacterModel)
}

final class CharacterListViewModel: CharacterListViewModelling {
    var allSeasonNames: [String]
    
    let searchTextObserver = PublishSubject<String?>()
    let selectedSeasonIndex = PublishSubject<Int>()
    let itemSelectedIndex = PublishSubject<IndexPath>()
    let filteredCharacters: Driver<[CharacterModel]>
    
    private let disposeBag = DisposeBag()
    private let characters: Observable<[CharacterModel]>
    private let router: RouterContract
    private let repository: CharacterListRepositoryProtocol
    
    init(router: RouterContract, repository: CharacterListRepositoryProtocol) {
        self.router = router
        self.repository = repository
        let allSeasonNames = CharacterModel.Season.allCases.map { $0.rawValue }
        self.allSeasonNames = allSeasonNames
        
        characters = Observable.create { observer in
            repository.fetchCharacters { result in
                switch result {
                case .success(let characters):
                    observer.onNext(characters)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
        .observe(on: MainScheduler.instance)
        
        self.filteredCharacters = Observable.combineLatest(characters, searchTextObserver, selectedSeasonIndex) { (characters, text, scopeIndex) -> [CharacterModel] in
            guard let text = text else { return characters }
            
            let season = CharacterModel.Season(rawValue: allSeasonNames[scopeIndex])
            let filtered = characters.filter { (character: CharacterModel) -> Bool in
                guard let seasons = character.appearance else { return false }
                let formattedSeason = seasons.map { "S\($0)" }
                
                let doesCategoryMatch = season == .all || formattedSeason.contains(season?.rawValue ?? "")
                
                if text.isEmpty {
                    return doesCategoryMatch
                } else {
                    return doesCategoryMatch && character.name.lowercased().contains(text.lowercased())
                }
            }
            return filtered
        }.asDriver(onErrorJustReturn: [])
        
        itemSelectedIndex.withLatestFrom(filteredCharacters.asObservable()) { (indexPath, characters) in
            return characters[indexPath.row]
        }.subscribe(onNext: { [weak self] model in
            self?.showCharacterDetails(character: model)
        }).disposed(by: disposeBag)
    }
    
    func showCharacterDetails(character: CharacterModel) {
        router.presentCharacterDetails(character: character)
    }
}
