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
    static let lunarGravity: CGFloat = -1.62519

    /// Apollo lander is 7.04m high and 9.4m wide with gear deployed.
    static let landerSize = CGSize(width: 9.4, height: 7.04)

    /// Weight of lander including astronauts, propellents, and expendables.
    static let landerMass: CGFloat = 15065

    /// Force of full thrust.
    ///
    /// Not historically accurate.
    static let landerThrust: CGFloat = 5000000

    /// Torque applied by full rotation.
    ///
    /// Not historically accurate.
    static let landerTorque: CGFloat = 50

    /// Scene is 600m wide by 600m high.
    static let sceneSize = CGSize(width: 320, height: 320)

    /// Initial position of lander in scene.
    static let landerInitialPosition = CGPoint(x: sceneSize.width / 2,
                                               y: sceneSize.height * 0.8)
}
