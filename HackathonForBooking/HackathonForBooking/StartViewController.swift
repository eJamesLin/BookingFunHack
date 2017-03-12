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

        let titleView = UINib(nibName: "NavigationTitleView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
        navigationItem.titleView = titleView

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Give up", style: .done, target: self, action: #selector(giveUpTasks))
    }

    @IBAction func startSolvingTask(_ sender: Any) {
        let vc = TimelineTableViewController()

        // temp data, will get from user actions
        TaskSingleTon.sharedInstance.taskCategory = "Taipei"

        //
        if let tasks = TaskSingleTon.sharedInstance.getTasksFromDisk(), tasks.count > 0 {
            TaskSingleTon.sharedInstance.allTasks = tasks
        } else {
            TaskSingleTon.sharedInstance.allTasks = TaskMaker().createTask()
        }

        TaskSingleTon.sharedInstance.saveTasks()

        navigationController?.pushViewController(vc, animated: true)
    }

    func giveUpTasks() {
        TaskSingleTon.sharedInstance.allTasks = []
        TaskSingleTon.sharedInstance.saveTasks()
    }
}
