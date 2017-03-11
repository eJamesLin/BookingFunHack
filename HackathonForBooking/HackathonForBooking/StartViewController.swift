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

        // temp data, will get from user actions
        TaskSingleTon.sharedInstance.taskCategory = "Taipei"

        //
        if let tasks = TaskSingleTon.sharedInstance.getTasksFromDisk() {
            TaskSingleTon.sharedInstance.allTasks = tasks
        } else {
            TaskSingleTon.sharedInstance.maxTaskCount = 5
            TaskSingleTon.sharedInstance.allTasks = TaskMaker().createTask()
        }

        TaskSingleTon.sharedInstance.saveTasks()

        navigationController?.pushViewController(vc, animated: true)
    }
}
