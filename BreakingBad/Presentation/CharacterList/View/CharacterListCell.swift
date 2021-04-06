//
//  CharacterListCell.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit
import SDWebImage

final class CharacterListCell: UITableViewCell {
    
    struct Constants {
        static let imageSize: CGFloat = 150
        static let margin: CGFloat = 20
    }
    
    private let characterImageView = UIImageView(frame: .zero)
    private let characterNameLabel = UILabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: String, characterName: String) {
        characterImageView.sd_setImage(with: URL(string: image))
        characterNameLabel.text = characterName
    }
}

private extension CharacterListCell {
    func setupViews() {
        
        characterImageView.contentMode = .scaleAspectFit
        characterNameLabel.numberOfLines = 2
        
        contentView.addSubviews([characterImageView, characterNameLabel])
        [characterImageView, characterNameLabel].removeAutoresizingMaskConstraints()
        
        let imageHeightConstraint = characterImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        imageHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margin),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.margin),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.margin),
            
            imageHeightConstraint,
            characterImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: Constants.margin),
            characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
