//
//  CouponViewController.swift
//  HackathonForBooking
//
//  Created by Wei-Ting Weng on 12/03/2017.
//  Copyright © 2017 Andy Yang. All rights reserved.
//

import UIKit

class CouponViewController: UIViewController {
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var getImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getImage.image=UIImage(named: "coupon00");
    }    

    @IBAction func getCoupon(_ sender: Any) {
        getButton.setTitle("Used", for: .normal)
    }
}
