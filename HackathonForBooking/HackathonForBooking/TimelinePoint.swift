//
//  TimelinePoint.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
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
    
    public var isFilled = false
    
    internal var position = CGPoint(x: 0, y: 0)
    
    public init(diameter: CGFloat, lineWidth: CGFloat, color: UIColor, filled: Bool) {
        self.diameter = diameter
        self.lineWidth = lineWidth
        self.color = color
        self.isFilled = filled
    }
    
    public init(diameter: CGFloat, color: UIColor, filled: Bool) {
        self.init(diameter: diameter, lineWidth: 2.0, color: color, filled: filled)
    }
    
    public init(color: UIColor, filled: Bool) {
        self.init(diameter: 6.0, lineWidth: 2.0, color: color, filled: filled)
    }
    
    public init() {
        self.init(diameter: 6.0, lineWidth: 2.0, color: UIColor.black, filled: false)
    }
    
    public func draw(view: UIView) {
        let path = UIBezierPath(ovalIn: CGRect(x: position.x, y: position.y, width: diameter, height: diameter))


//        let path = UIBezierPath(arcCenter: position, radius: diameter, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)

        let bigCircle = CAShapeLayer()
        bigCircle.path = path.cgPath
        bigCircle.strokeColor = color.cgColor
        bigCircle.fillColor = UIColor.white.cgColor
        bigCircle.lineWidth = 3

        view.layer.addSublayer(bigCircle)


        let diff: CGFloat = 10
        let path1 = UIBezierPath(ovalIn: CGRect(x: position.x + diff / 2, y: position.y + diff / 2, width: diameter - diff , height: diameter - diff ))


//        let path1 = UIBezierPath(arcCenter: position, radius: diameter - 4, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)

        let smallCircle = CAShapeLayer()
        smallCircle.path = path1.cgPath
        smallCircle.strokeColor = color.cgColor
        smallCircle.fillColor = color.cgColor
        smallCircle.lineWidth = 3

        view.layer.addSublayer(smallCircle)
    }

//    public func draw(view: UIView) {
//        let path = UIBezierPath(ovalIn: CGRect(x: position.x, y: position.y, width: diameter, height: diameter))
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.fillColor = isFilled ? color.cgColor : UIColor.white.cgColor
//        shapeLayer.lineWidth = lineWidth
//
//        view.layer.addSublayer(shapeLayer)
//    }
}
