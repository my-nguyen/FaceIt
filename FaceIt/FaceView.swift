//
//  FaceView.swift
//  FaceIt
//
//  Created by My Nguyen on 8/22/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class FaceView: UIView {

    override func drawRect(rect: CGRect) {
        // can't use rect since it's just an optimization
        // can't use frame since it's the rectangle that contains this FaceView in the superview coordinates
        // must use bounds
        let radius = min(bounds.size.width, bounds.size.height) / 2
        // var centre = convertPoint(center, fromView: superview)
        let centre = CGPoint(x: bounds.midX, y: bounds.midY)
        let skull = UIBezierPath(arcCenter: centre, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        skull.lineWidth = 5.0
        // UIColor.set() set both fill and stroke
        UIColor.blueColor().set()
        // the actual draw
        skull.stroke()
    }
}
