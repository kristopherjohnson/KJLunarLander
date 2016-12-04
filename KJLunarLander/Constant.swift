//
//  Constant.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics

/// Definitions of physical constants.
///
/// All lengths are in meters.  All times are in seconds.

struct Constant {

    /// Acceleration due to lunar gravity (m/s/s).
    static let lunarGravity = -0.62519

    /// Scene is 1000m wide by 1000m high
    static let sceneSize = CGSize(width: 1000, height: 1000)

    /// Apollo lander is 7.04m high and 9.4m wide with gear deployed.
    static let landerSize = CGSize(width: 9.4, height: 7.04)

    /// Initial position of lander in scene.
    static let landerInitialPosition = CGPoint(x: 200, y: 900)
}
