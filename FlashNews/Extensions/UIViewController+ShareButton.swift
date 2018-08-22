//
//  UIViewController+ShareButton.swift
//  PocketReader
//
//  Created by Jakub Lares on 20.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit

extension UIViewController {

    func addShareButton(action: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shareIcon"), style: .done, target: self, action: action)
    }
}
