//
//  TaskMaker.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class TaskMaker: NSObject {
    func createTask() {
        for _ in 1...TaskSingleTon.sharedInstance.maxTaskCount {
            let task = TaskObject()
            task.taskCategory = TaskSingleTon.sharedInstance.taskCategory
            task.taskID = task.getTaskID()
            task.taskTitle = "Task\(task.taskID)"
            task.taskContent = "TaskContent\(task.taskID)"
            task.saveTask(task: task)
        }
    }
}
