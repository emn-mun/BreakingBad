//
//  SceneDelegate.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private let window = UIWindow(frame: UIScreen.main.bounds)
    private var router: RouterContract!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootViewController = UINavigationController()
        router = Router(rootViewController: rootViewController)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        window.windowScene = windowScene
        router.presentCharacterList()
    }
}
