//
//  FaceView.swift
//  FaceIt
//
//  Created by My Nguyen on 8/22/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class FaceView: UIView {

    // these ratios are pre-calculated by the professor
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    private enum Eye {
        case Left
        case Right
    }

    var scale: CGFloat = 0.90
    // can't use rect since it's just an optimization
    // can't use frame since it's the rectangle that contains this FaceView in the superview coordinates
    // must use bounds, but can't access bounds property in the initialization, so must change radius
    // property to a computed property
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    override func drawRect(rect: CGRect) {
        // UIColor.set() set both fill and stroke
        UIColor.blueColor().set()
        let skull = pathForCircle(skullCenter, withRadius: skullRadius)
        skull.stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
    }

    private func pathForCircle(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = 5.0
        return path
    }

    private func pathForEye(eye: Eye) -> UIBezierPath {
        let radius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let centre = getEyeCenter(eye)
        return pathForCircle(centre, withRadius: radius)
    }

    private func getEyeCenter(eye: Eye) -> CGPoint {
        var offset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var center = skullCenter
        center.y -= offset
        switch eye {
        case .Left: center.x -= offset
        case .Right: center.x += offset
        }
        return center
    }
}
