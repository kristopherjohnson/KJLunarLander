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
/// LanderSceneController (which implements the gameplay
/// simulation), and route control inputs to that scene.

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    @IBOutlet weak var thrustControl: ThrustControl!

    private var landerSceneController: LanderSceneController?

    override func viewDidLoad() {
        super.viewDidLoad()
        landerSceneController = LanderSceneController(view: skView)
        landerSceneController!.controlInput = self
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func resetWasTapped(_ sender: UIButton) {
        landerSceneController = LanderSceneController(view: skView)
        landerSceneController!.controlInput = self
    }
}

// MARK: - ControlInput

// We currently have a simple control scheme based upon 
// two UIButtons and a thrust control.  Eventually we
// want to also support game controllers.

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
        return thrustControl.value
    }
}
