//
//  ControlInput.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics

/// Protocol for an object that provides control inputs
/// to LanderSceneController.

protocol ControlInput: NSObjectProtocol {

    /// Amount of rotation specified by the player, in the range -1.0 - 1.0.
    ///
    /// A value of zero means no rotation is being applied.
    ///
    /// A value of 1.0 means full rotation in counterclockwise direction.
    ///
    /// A value of -1.0 means full rotation in clockwise direction.
    var rotationInput: CGFloat { get }

    /// Amount of thrust specified by the player, in the range 0.0 - 1.0.
    ///
    /// A value of zero means no thrust.  A value of 1.0 means full thrust.
    var thrustInput: CGFloat { get }
}
