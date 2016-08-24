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

            // add swipe up for happiness and down for sadness
            let happySwipe = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            happySwipe.direction = .Up
            faceView.addGestureRecognizer(happySwipe)
            let sadSwipe = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            sadSwipe.direction = .Down
            faceView.addGestureRecognizer(sadSwipe)

            updateUI()
        }
    }
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk:-0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]

    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }

    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }

    // method that opens or closes the eyes upon a tap
    @IBAction func toggleEyes(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }

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