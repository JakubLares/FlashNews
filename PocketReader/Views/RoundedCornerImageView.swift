//
//  RoundedCornerImageView.swift
//  PocketReader
//
//  Created by Jakub Lares on 18.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import UIKit

class RoundedCornerImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 4
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

}
