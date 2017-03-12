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
        
    var taskCategory: String?

    lazy var allTasks: [TaskObject] = []
    
    func getTasksFromDisk(complectionHandler: @escaping (_ success: Bool, _ dataAry: [TaskObject]) -> Void) {

        guard let category = taskCategory else {
            complectionHandler(false, [])
            return
        }

        guard let data = UserDefaults.standard.value(forKey: keyForCategory(category)) as? Data else {
            complectionHandler(false, [])
            return
        }

        guard let unarchiveTask = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData) as? [TaskObject] else {
            complectionHandler(false, [])
            return
        }

        complectionHandler(true, unarchiveTask!)
        return
    }

    func saveTasks() {
        
        DispatchQueue.global(qos: .userInitiated).async {
        
            if let category = self.taskCategory {
                let savedData = NSKeyedArchiver.archivedData(withRootObject: self.allTasks)
                
                UserDefaults.standard.set(savedData, forKey: self.keyForCategory(category))
                UserDefaults.standard.synchronize()
            }
            
            DispatchQueue.main.async {
                //if needed
            }
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
