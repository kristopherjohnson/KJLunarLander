//
//  GameViewController.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import UIKit
import SpriteKit

/// Main view controller.
/// 
/// The view controller does little except initialize a
/// LanderSceneController (which implements the game-playing
/// logic), and provide control inputs.

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var thrustButton: UIButton!

    private var landerSceneController: LanderSceneController!

    override func viewDidLoad() {
        super.viewDidLoad()
        landerSceneController = LanderSceneController(view: skView)
        landerSceneController.controlInput = self
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - ControlInput

// We currently have a simple control scheme based upon 
// three UIButtons.  Eventually the goal is to have more
// sophisticated onscreen controls and also support
// game controllers.

extension GameViewController: ControlInput {

    var rotationInput: CGFloat {
        var result: CGFloat = 0.0

        if leftButton.isTracking {
            result += 1.0
        }

        if rightButton.isTracking {
            result -= 1.0
        }

        return result
    }

    var thrustInput: CGFloat {
        if thrustButton.isTracking {
            return 1.0
        }
        else {
            return 0.0;
        }
    }
}
