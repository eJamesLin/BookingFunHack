//
//  CorrectAnswerViewController.swift
//  HackathonForBooking
//
//  Created by Zack on 2017/3/12.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class CorrectAnswerViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var CorrectAnswerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.layer.cornerRadius = 7
    }
}
