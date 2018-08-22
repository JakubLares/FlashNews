//
//  Utils.swift
//  PocketReader
//
//  Created by Jakub Lares on 21.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit

class Utils {

    class func getTopController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
