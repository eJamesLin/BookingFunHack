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

        //
        let imageView = UIImageView(image: UIImage(named: "banner"))
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150)
        let titleLabel = UILabel()
        titleLabel.text = "Taipei\nChallenge"
        titleLabel.textAlignment = .right
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 48)
        imageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(0).offset(-20)
            make.trailing.equalTo(0).offset(-20)
        }
        self.tableView.tableHeaderView = imageView

        //
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
}
