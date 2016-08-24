//
//  ViewController.swift
//  FaceIt
//
//  Created by My Nguyen on 8/22/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    // this is the expression upon initialization of FaceView
    var expression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk) {
        didSet {
            updateUI()
        }
    }
    // this is the post-initialization UI for any change in the facial expression (eyes, eyebrows, or mouth)
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            // add pinch gesture recognizer
            let pinch = UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:)))
            faceView.addGestureRecognizer(pinch)
            updateUI()
        }
    }
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk:-0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]

    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}