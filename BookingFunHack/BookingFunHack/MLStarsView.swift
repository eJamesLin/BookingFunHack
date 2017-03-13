//
//  StarsView.swift
//  HackathonForBooking
//
//  Created by CJ Lin on 2017/3/12.
//

import UIKit

class StarsView: UIView {
    fileprivate let totalStarCount = 5
    fileprivate var starImageViewsArray = [UIImageView]()
    var score: Float = 5.0 {
        willSet {
            guard starImageViewsArray.count > 1 else { return }
            DispatchQueue.main.async {
                for i in 1...self.starImageViewsArray.count {
                    var star: UIImage?

                    switch i {
                    case _ where Float(i) <= newValue:
                        star = MLStar.gold.image()
                    case _ where ceil(newValue) == Float(i):
                        star = MLStar.half.image()
                    default:
                        star = MLStar.grey.image()
                    }

                    self.starImageViewsArray[i-1].image = star
                }
            }
        }
    }

    fileprivate let starSize = CGFloat(12)
    fileprivate let starSpace = CGFloat(4)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStars()
    }

    func setupStars() {
        for i in 1...totalStarCount {
            let x = CGFloat(i-1) * (starSize + starSpace)
            let starImageView = UIImageView(frame: CGRect(x: x, y: 0, width: starSize, height: starSize))
            starImageView.image = MLStar.gold.image()
            starImageView.backgroundColor = UIColor.white
            addSubview(starImageView)
            starImageViewsArray.append(starImageView)
        }
    }

    enum MLStar {
        case gold
        case grey
        case half

        func image() -> UIImage? {
            switch self {
            case .gold: return UIImage(named: "star")
            case .grey: return UIImage(named: "starGrey")
            case .half: return UIImage(named: "starHalf")
            }
        }
    }
}
