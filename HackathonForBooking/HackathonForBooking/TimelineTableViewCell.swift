//
//  TimelineTableViewCell.swift
//  TimelineTableViewCell
//
//  Created by CJ Lin on 2017/3/11.
//  Copyright © 2017年 CJ Lin. All rights reserved.
//

import UIKit


class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusLeftSeperator: UIView!
    @IBOutlet weak var statusRightSeperator: UIView!

    @IBOutlet weak var getClueButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var timelinePoint = TimelinePoint() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var timeline = Timeline() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var statusFinished: Bool = false {
        didSet {
            if statusFinished {
                statusLabel.text = "Done"
                statusLabel.textColor = UIColor.themeBlue()
                statusLeftSeperator.backgroundColor = UIColor.themeBlue()
                statusRightSeperator.backgroundColor = UIColor.themeBlue()
                timeline.lineDash = false
            } else {
                statusLabel.text = "Open"
                statusLabel.textColor = UIColor.themeGray()
                statusLeftSeperator.backgroundColor = UIColor.themeGray()
                statusRightSeperator.backgroundColor = UIColor.themeGray()
                timeline.lineDash = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        getClueButton.isHidden = true
        getClueButton.layer.cornerRadius = 7
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        taskNameLabel.text = nil
        descriptionLabel.text = nil
        thumbnailImageView.image = nil
        statusView.isHidden = false
        getClueButton.isHidden = true
    }

    var bubbleRadius: CGFloat = 2.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
            
            self.setNeedsDisplay()
        }
    }
    
    var bubbleColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)

    override func draw(_ rect: CGRect) {
        if let sublayers = self.contentView.layer.sublayers {
            for layer in sublayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        timelinePoint.position = CGPoint(x: timeline.leftMargin + timeline.width / 2,
                                         y: rect.size.height - timelinePoint.diameter - 5)

        timeline.start = CGPoint(x: timelinePoint.position.x + timelinePoint.diameter / 2, y: 0)
        timeline.middle = CGPoint(x: timeline.start.x, y: timelinePoint.position.y)
        timeline.end = CGPoint(x: timeline.start.x, y: self.bounds.size.height)
        timeline.draw(view: self.contentView)
        
        timelinePoint.draw(view: self.contentView)
    }
}

// MARK: -

extension TimelineTableViewCell {

    func setupAsDummyCell() {
        statusView.isHidden = true
        titleLabel.text = nil
        taskNameLabel.text = nil
        descriptionLabel.text = nil
        thumbnailImageView.image = nil

        timeline.frontColor = timelinePoint.color
        timeline.backColor = timelinePoint.color
    }

    func setupNotDisplaying() {
        titleLabel.text = nil
        taskNameLabel.text = nil
        descriptionLabel.text = nil
        thumbnailImageView.image = nil

        timeline.frontColor = UIColor.themeGray()
        timeline.backColor = UIColor.themeGray()
        timelinePoint.color = UIColor.themeGray()

        statusFinished = false
    }

    func setupWithTask(_ task: TaskObject) {
        titleLabel.text = "Task \(task.taskID)"
        taskNameLabel.text = task.taskTitle
        descriptionLabel.text = task.taskContent
        thumbnailImageView.image = task.taskPhoto

        let color = task.taskFinished ?UIColor.themeBlue() :UIColor.themeGray()
        timeline.frontColor = color
        timeline.backColor = color
        timelinePoint.color = color

        statusFinished = task.taskFinished
    }

    func setupWaitForClue() {
        setupNotDisplaying()
        getClueButton.isHidden = false
    }
}
