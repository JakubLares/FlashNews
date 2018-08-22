//
//  UIViewController+AddSubview.swift
//  PocketReader
//
//  Created by Jakub Lares on 22.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviewForAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
