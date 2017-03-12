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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Give up", style: .done, target: self, action: #selector(giveUpTasks))
    }

    @IBAction func startSolvingTask(_ sender: Any) {
        let vc = TimelineTableViewController()

        // temp data, will get from user actions
        TaskSingleTon.sharedInstance.taskCategory = "Taipei"

        //
        TaskSingleTon.sharedInstance.getTasksFromDisk(complectionHandler: {(success: Bool?, dataAry: [TaskObject]?) in
            if success!, let tasks = dataAry, tasks.count > 0 {
                TaskSingleTon.sharedInstance.allTasks = tasks
            } else {
                TaskSingleTon.sharedInstance.allTasks = TaskMaker().createTask()
            }
            
            TaskSingleTon.sharedInstance.saveTasks()
            _ = self.navigationController?.pushViewController(vc, animated: true)
        })
    }

    func giveUpTasks() {
        TaskSingleTon.sharedInstance.allTasks = []
        TaskSingleTon.sharedInstance.saveTasks()
    }
}
