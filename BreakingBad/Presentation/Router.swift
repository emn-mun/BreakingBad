//
//  Router.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit

protocol RouterContract {
    func presentCharacterList()
    func presentCharacterDetails(character: CharacterModel)
}

class Router: RouterContract {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func presentCharacterList() {
        let presenter = CharacterListPresenter(router: self, repository: CharacterListRepository())
        let viewController = CharacterListViewController(presenter: presenter)
        rootViewController.pushViewController(viewController, animated: false)
    }

    func presentCharacterDetails(character: CharacterModel) {
        let presenter = CharacterDetailsPresenter(viewModel: CharacterDetailsViewModel(model: character))
        let viewController = CharacterDetailsViewController(presenter: presenter)
        rootViewController.pushViewController(viewController, animated: true)
    }
}
