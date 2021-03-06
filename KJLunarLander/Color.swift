//
//  Color.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Constants for colors used by UI elements in the application.
enum Color {
    /// Color of the lander's lower section.
    static let lander = SKColor.orange

    /// Color of the lander's ascent-stage section.
    static let ascentHull = SKColor.lightGray

    /// Color of onscreen controls when active.
    static let controlHighlight = SKColor.orange

    /// Color of onscreen controls when not active.
    static let controlNormal = SKColor.lightGray
    
    /// Color of HUD text.
    static let hud = SKColor.green

    /// Color of lunar surface.
    static let surface = SKColor(white: 0.125, alpha: 1.0)
}
