//
//  ControlButton.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import UIKit

/// Button that changes background color when highlighted.

class ControlButton: UIButton {

    var highlightBackgroundColor = Color.controlHighlight
    var normalBackgroundColor = Color.controlNormal

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
