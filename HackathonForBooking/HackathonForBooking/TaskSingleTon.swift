//
//  TaskSingleTon.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class TaskSingleTon: NSObject {
    static let sharedInstance = TaskSingleTon()
    
    //task number
    var maxTaskCount = 0
    
    var taskCategory: String?

    lazy var allTasks: [TaskObject] = []

    func getTasksFromDisk() -> [TaskObject]? {

        guard let category = taskCategory else { return nil }

        guard let data = UserDefaults.standard.value(forKey: keyForCategory(category)) as? Data else { return nil }

        let unarchiveTask = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData) as? [TaskObject]

        return unarchiveTask ?? nil
    }

    func saveTasks() {
        
        if let category = taskCategory {

            let savedData = NSKeyedArchiver.archivedData(withRootObject: allTasks)

            UserDefaults.standard.set(savedData, forKey: keyForCategory(category))
            UserDefaults.standard.synchronize()
        }
    }

    func keyForCategory(_ category: String) -> String {
        return "Task_\(category)"
    }

    func didFinishTask(_ task: TaskObject) {
        if let index = allTasks.index(of: task), (index + 1) < allTasks.count {
            allTasks[index + 1].shouldBeDisplayed = true
        }
    }
}
