//
//  ThrustControl.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import UIKit

/// The thrust control is a vertical rectangle that reacts to touches.
/// When untouched, the control is unhighlighted and its value is 0.0.
/// When touched, the value will be the fraction of the distance from
/// the bottom of the control to the top of the control that the
/// touch point is at, and a highlight will appear to indicate the level.

class ThrustControl: UIControl {

    /// Current thrust level, in the range 0.0-1.0.
    var value: CGFloat = 0.0

    /// Sublayer that displays current thrust level.
    private var highlightLayer: CALayer?

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(touch: touch)
        return super.beginTracking(touch, with: event)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(touch: touch)
        return super.continueTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        resetValueToZero()
        return super.endTracking(touch, with: event)
    }

    override func cancelTracking(with event: UIEvent?) {
        resetValueToZero()
        return super.cancelTracking(with: event)
    }

    /// Update the frame of the highlightLayer to reflect
    /// the current value.
    private func updateHighlightLayer() {
        if highlightLayer == nil {
            let newLayer = CALayer()
            highlightLayer = newLayer
            newLayer.backgroundColor = Color.controlHighlight.cgColor

            // Disable implicit animations.
            let nullAction = NSNull() as CAAction
            newLayer.actions = [
                "bounds": nullAction,
                "position": nullAction,
                "hidden": nullAction,
                "opacity": nullAction
            ]

            self.layer.addSublayer(newLayer)
        }

        if value > 0 {
            let newHeight = value * bounds.height
            let newFrame = CGRect(x: bounds.origin.x,
                                  y: bounds.height - newHeight,
                                  width: bounds.width,
                                  height: newHeight)
            highlightLayer!.frame = newFrame
            highlightLayer!.opacity = Float(value)
            highlightLayer!.isHidden = false
        }
        else {
            highlightLayer!.isHidden = true
        }
    }

    /// Set value from current touch point.
    /// 
    /// - parameter touch: Finger touch
    private func updateValue(touch: UITouch) {
        let point = touch.location(in: self)
        let bounds = self.bounds

        let rawValue = (bounds.maxY - point.y) / bounds.size.height
        let clampedValue = min(1.0, max(0.0, rawValue))

        if clampedValue != value {
            value = clampedValue
            updateHighlightLayer()
            sendActions(for: .valueChanged)
        }
    }

    /// Set the value to zero.
    private func resetValueToZero() {
        value = 0.0
        updateHighlightLayer()
        sendActions(for: .valueChanged)
    }
}
