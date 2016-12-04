//
//  ControlButton.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import UIKit

/// Button that changes background color when highlighted.

class ControlButton: UIButton {

    var highlightBackgroundColor = UIColor.orange
    var normalBackgroundColor = UIColor.lightGray

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightBackgroundColor
            }
            else {
                backgroundColor = normalBackgroundColor
            }
        }
    }
}
