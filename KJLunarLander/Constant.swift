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
    static let lunarGravity = -1.62519

    /// Apollo lander is 7.04m high and 9.4m wide with gear deployed.
    static let landerSize = CGSize(width: 9.4, height: 7.04)

    /// Scene is 600m wide by 600m high.
    static let sceneSize = CGSize(width: 600, height: 600)

    /// Initial position of lander in scene.
    static let landerInitialPosition = CGPoint(x: sceneSize.width / 2,
                                               y: sceneSize.height * 0.9)
}
