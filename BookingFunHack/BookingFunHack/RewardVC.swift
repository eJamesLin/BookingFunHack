//
//  RewardVC.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/12.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class RewardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareReward(_ sender: Any) {
        let firstActivityItem = "Your Coupon"
        let secondActivityItem = "lillllillllliiiiiillllll"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
