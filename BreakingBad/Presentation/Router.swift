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
        let presenter = CharacterListViewModel(router: self, repository: CharacterListRepository())
        let viewController = CharacterListViewController(presenter: presenter)
        rootViewController.pushViewController(viewController, animated: false)
    }

    func presentCharacterDetails(character: CharacterModel) {
        let viewController = CharacterDetailsViewController(presenter: CharacterDetailsViewModel(model: character))
        rootViewController.pushViewController(viewController, animated: true)
    }
}
