//
//  TimelinePoint.swift
//  TimelineTableViewCell
//
//  Created by CJ Lin on 2017/3/11.
//  Copyright © 2017年 CJ Lin. All rights reserved.
//

import Foundation
import UIKit

public struct TimelinePoint {
    public var diameter: CGFloat = 20.0 {
        didSet {
            if (diameter < 0.0) {
                diameter = 0.0
            } else if (diameter > 100.0) {
                diameter = 100.0
            }
        }
    }
    
    public var lineWidth: CGFloat = 2.0 {
        didSet {
            if (lineWidth < 0.0) {
                lineWidth = 0.0
            } else if(lineWidth > 20.0) {
                lineWidth = 20.0
            }
        }
    }
    
    public var color = UIColor.black
    
    internal var position = CGPoint(x: 0, y: 0)
    
    public init(diameter: CGFloat, lineWidth: CGFloat, color: UIColor) {
        self.diameter = diameter
        self.lineWidth = lineWidth
        self.color = color
    }

    public init(diameter: CGFloat) {
        self.init(diameter: diameter, lineWidth: 2.0, color: UIColor.themeBlue())
    }

    public init(diameter: CGFloat, color: UIColor) {
        self.init(diameter: diameter, lineWidth: 2.0, color: color)
    }
    
    public init(color: UIColor) {
        self.init(diameter: 6.0, lineWidth: 2.0, color: color)
    }
    
    public init() {
        self.init(diameter: 6.0, lineWidth: 2.0, color: UIColor.black)
    }
    
    public func draw(view: UIView) {
        let path = UIBezierPath(ovalIn: CGRect(x: position.x, y: position.y, width: diameter, height: diameter))

        let bigCircle = CAShapeLayer()
        bigCircle.path = path.cgPath
        bigCircle.strokeColor = color.cgColor
        bigCircle.fillColor = UIColor.white.cgColor
        bigCircle.lineWidth = 3

        view.layer.addSublayer(bigCircle)


        let diff: CGFloat = 10
        let path1 = UIBezierPath(ovalIn: CGRect(x: position.x + diff / 2, y: position.y + diff / 2, width: diameter - diff , height: diameter - diff ))

        let smallCircle = CAShapeLayer()
        smallCircle.path = path1.cgPath
        smallCircle.strokeColor = color.cgColor
        smallCircle.fillColor = color.cgColor
        smallCircle.lineWidth = 3

        view.layer.addSublayer(smallCircle)
    }
}
