//
//  TaskMaker.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class TaskMaker: NSObject {
    func createTask() -> TaskObject {
        let task = TaskObject()
        task.taskID = task.getTaskID()
        task.taskTitle = "Task\(task.taskID)"
        task.taskContent = "TaskContent\(task.taskID)"
        
        return task
    }
}
