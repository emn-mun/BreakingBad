//
//  CharacterDetailsPresenter.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation

protocol CharacterDetailsPresentable {
    var viewModel: CharacterDetailsViewModel { get }
}

final class CharacterDetailsPresenter: CharacterDetailsPresentable {
    let viewModel: CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }
}
