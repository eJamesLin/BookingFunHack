//
//  TaskMaker.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class TaskMaker: NSObject {
    func createTask() -> [TaskObject] {
        var arr: [TaskObject] = []

        for num in stride(from: 1, through: TaskSingleTon.sharedInstance.maxTaskCount, by: 1) {
            let task = TaskObject()
            task.taskCategory = TaskSingleTon.sharedInstance.taskCategory
            task.taskID = num
            task.taskTitle = "Task\(task.taskID)"
            task.taskContent = "TaskContent\(task.taskID)"

            arr.append(task)
        }
        
        return arr
    }
}
