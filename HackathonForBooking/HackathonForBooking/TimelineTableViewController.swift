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
                self.animateTableView(self.tableView)
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView(tableView)
    }

    func showClueViewController() {
        let sb = UIStoryboard(name: "GetClue", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "QuestionViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func didGotClue() {
        // temp set all unlock
        for task in TaskSingleTon.sharedInstance.allTasks {
            task.isUnlock = true
        }

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
        } else if task.isUnlock == false {
            cell.setupWaitForClue()
            cell.getClueButton.addTarget(self, action: #selector(showClueViewController), for: .touchUpInside)
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

    func animateTableView(_ tableView: UITableView) {
        tableView.reloadData()

        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }

        var index = 0

        for c in cells {
            let cell: UITableViewCell = c
            UIView.animate(withDuration: 1, delay: 0.1 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)

            index += 1
        }
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
