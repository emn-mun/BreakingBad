//
//  CharacterDetailsViewController.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    struct Constants {
        static let imageHeight: CGFloat = 300
        static let horizontalMargin: CGFloat = 20
        static let verticalMargin: CGFloat = 20
    }
    
    private let presenter: CharacterDetailsPresentable
    
    private let characterImageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let occupationLabel = UILabel(frame: .zero)
    private let statusLabel = UILabel(frame: .zero)
    private let nicknameLabel = UILabel(frame: .zero)
    private let seasonAppearanceLabel = UILabel(frame: .zero)
    
    init(presenter: CharacterDetailsPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        setupLayout()
        setupViews(with: presenter.viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CharacterDetailsViewController {
    func setupLayout() {
        view.backgroundColor = .white
        let stack = UIStackView(arrangedSubviews: [characterImageView, nameLabel, occupationLabel, statusLabel, nicknameLabel, seasonAppearanceLabel])
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .equalSpacing
        
        characterImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalMargin),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalMargin),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalMargin),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.verticalMargin)
        ])
    }
    
    func setupViews(with viewModel: CharacterDetailsViewModel) {
        characterImageView.sd_setImage(with: URL(string: viewModel.imageURLString))
        [nameLabel, occupationLabel, statusLabel, nicknameLabel, seasonAppearanceLabel].forEach { $0.numberOfLines = 0 }
        
        nameLabel.text = viewModel.name
        occupationLabel.text = viewModel.occupation
        statusLabel.text = viewModel.status
        nicknameLabel.text = viewModel.nickname
        seasonAppearanceLabel.text = viewModel.seasonAppearance
    }
}
