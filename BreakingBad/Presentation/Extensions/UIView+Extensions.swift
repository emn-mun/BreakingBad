//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation
import UIKit

public extension Collection where Element: UIView {
  func removeAutoresizingMaskConstraints() {
    forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
  }
}

public extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
}
