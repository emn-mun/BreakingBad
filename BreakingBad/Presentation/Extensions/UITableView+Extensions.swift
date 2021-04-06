//
//  UITableView+Extensions.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation
import UIKit

protocol ReusableIdentifierProvidable {
    static var reusableIdentifier: String { get }
}

extension ReusableIdentifierProvidable {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableIdentifierProvidable { }
