//
//  StartViewController.swift
//  HackathonForBooking
//
//  Created by CJ Lin on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startSolvingTask(_ sender: Any) {
        let vc = TimelineTableViewController()
        TaskSingleTon.sharedInstance.maxTaskCount = 5
        
        TaskSingleTon.sharedInstance.taskCategory = "Taipei"
        TaskMaker().createTask()
        navigationController?.pushViewController(vc, animated: true)
    }
}
