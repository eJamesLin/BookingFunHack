//
//  CongratsViewController.swift
//  HackathonForBooking
//
//  Created by Zack on 2017/3/12.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {

    @IBAction func buttonAction(_ sender: Any) {
        guard let arr = navigationController?.viewControllers else { return }

        for vc in arr {
            if vc is TimelineTableViewController {
                _ = navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
}
