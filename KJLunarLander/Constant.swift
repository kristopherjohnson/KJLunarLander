//
//  Constant.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics

/// Definitions of physical constants.
///
/// All lengths are in meters.  All masses are in kilograms.
/// All times are in seconds.

enum Constant {

    /// Acceleration due to lunar gravity (m/s/s).
    static let lunarGravity: CGFloat = -1.625

    /// Apollo lander is 7.04m high and 9.4m wide with gear deployed.
    static let landerSize = CGSize(width: 9.4, height: 7.04)

    static let landerHullSize = CGSize(width: 8.0, height: 2.1)

    static let ascentHullRadius: CGFloat = 3.5

    static let legHeight: CGFloat = 1.4

    static let footSize = CGSize(width: 1.0, height: 0.5)

    /// Weight of lander including astronauts, propellents, and expendables.
    static let landerMass: CGFloat = 15065

    /// Force of full thrust.
    ///
    /// Not historically accurate.
    static let landerThrust: CGFloat = 5000000

    /// Torque applied by full rotation.
    ///
    /// Not historically accurate.
    static let landerTorque: CGFloat = 35

    /// Scene is 640m wide by 640m high.
    static let sceneSize = CGSize(width: 640, height: 640)

    /// Initial position of lander in scene.
    static let landerInitialPosition = CGPoint(x: sceneSize.width / 8,
                                               y: sceneSize.height * 0.8)

    /// Initial velocity of lander in scene.
    static let landerInitialVelocity = CGVector(dx: 50, dy: 0)
    
    /// Roughness of the lunar surface.
    /// 
    /// Set to a high value, so lander will tend to flip rather than slide
    /// if it touches down with high lateral speed.
    static let surfaceFriction: CGFloat = 3.0
}
