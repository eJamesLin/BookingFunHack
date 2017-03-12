//
//  TimelineTableViewController.swift
//  TimelineTableViewCell
//
//  Created by CJ Lin on 2017/3/11.
//  Copyright © 2017年 CJ Lin. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    fileprivate let identifier = "TimelineTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let timelineTableViewCellNib = UINib(nibName: TimelineTableViewCell.className(), bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: identifier)

        self.tableView.estimatedRowHeight = 140
        self.tableView.separatorStyle = .none

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get clue", style: .done, target: self, action: #selector(showClueViewController))

        TaskSingleTon.sharedInstance.getTasksFromDisk(complectionHandler: {(success: Bool?, dataAry: [TaskObject]?) in
            DispatchQueue.main.async {
                if success!, let tasks = dataAry, tasks.count > 0 {
                    TaskSingleTon.sharedInstance.allTasks = tasks
                } else {
                    TaskSingleTon.sharedInstance.allTasks = TaskMaker().createTask()
                }

                TaskSingleTon.sharedInstance.saveTasks()
                self.tableView.reloadData()
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func showClueViewController() {
        let sb = UIStoryboard(name: "GetClue", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "QuestionViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func toReward() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RewardVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let task = TaskSingleTon.sharedInstance.allTasks[indexPath.row]
        if task.isFirstDummyTask() {
            return 30
        } else {
            return 180
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskSingleTon.sharedInstance.allTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = TaskSingleTon.sharedInstance.allTasks[indexPath.row]
        if task.isFirstDummyTask() {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TimelineTableViewCell
            cell.timelinePoint = TimelinePoint(diameter: 20, color: UIColor.themeBlue())
            cell.setupAsDummyCell()
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TimelineTableViewCell

        cell.timeline.frontColor = UIColor.themeBlue()

        cell.timelinePoint = TimelinePoint(diameter: 20, color: UIColor.themeBlue())

        if task.shouldBeDisplayed == false {
            cell.setupNotDisplaying()
        } else {
            cell.setupWithTask(task)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = TaskSingleTon.sharedInstance.allTasks[indexPath.row]
        guard task.isFirstDummyTask() == false else { return }
        guard task.shouldBeDisplayed == true else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TaskPhotoVC") as! TaskPhotoVC
        vc.task = task
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let lastTask = TaskSingleTon.sharedInstance.allTasks.last,
            lastTask.taskFinished {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
            
            let rewardBtn = UIButton(frame: CGRect(x: 0, y: 5, width: tableView.frame.size.width, height: 40))
            rewardBtn.addTarget(self, action: #selector(self.toReward), for: .touchUpInside)
            rewardBtn.setTitle("Completion", for: .normal)
            rewardBtn.backgroundColor = UIColor.themeBlue()
            
            footerView.addSubview(rewardBtn)
            
            return footerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let lastTask = TaskSingleTon.sharedInstance.allTasks.last,
            lastTask.taskFinished {
            return 50.0
        }
        return 0
    }
}
