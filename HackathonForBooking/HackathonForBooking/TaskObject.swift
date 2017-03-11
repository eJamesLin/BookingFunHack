//
//  TaskObject.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class TaskObject: NSObject, NSCoding {
    
    //Properties
    var taskCategory = TaskSingleTon.sharedInstance.taskCategory
    var taskID = 0
    var taskTitle: String?
    var taskContent: String?
    var taskPhoto: UIImage?
    var taskFinished = false
    
    let userDefault = UserDefaults.standard
    
    //MARK: - NSCoding Delegate
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? NSNumber {
            self.taskID = Int(id)
        }
        
        if let title = aDecoder.decodeObject(forKey: "title") as? String {
            self.taskTitle = title
        }
        
        if let content = aDecoder.decodeObject(forKey: "content") as? String {
            self.taskContent = content
        }
        
        if let photo = aDecoder.decodeObject(forKey: "photo") as? UIImage {
            self.taskPhoto = photo
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: self.taskID), forKey: "id")
        aCoder.encode(self.taskTitle, forKey: "title")
        aCoder.encode(self.taskContent, forKey: "content")
        aCoder.encode(self.taskPhoto, forKey: "photo")
    }
    
    //MARK: - Private Methods
    func saveTask(task: TaskObject) {
        
        //check if the user finished the task
        if (task.taskPhoto != nil) {
            self.taskFinished = true
        }
        
        var aryTask = [Data]()

        if let category = self.taskCategory {

            if self.userDefault.array(forKey: TaskObject.keyForCategory(category))?.count != nil {
                aryTask = self.userDefault.array(forKey: TaskObject.keyForCategory(category)) as! [Data]
            }

            let savedData = NSKeyedArchiver.archivedData(withRootObject: task)
            aryTask.append(savedData)
        

            self.userDefault.set(aryTask, forKey: TaskObject.keyForCategory(category))
            self.userDefault.synchronize()
        }
    }
    
    class func getTasks(category: String) -> [TaskObject] {
        var aryTasks = [TaskObject]()

        guard let arr = UserDefaults.standard.array(forKey: TaskObject.keyForCategory(category)) else {
            return []
        }

        for task in arr {
            let unarchiveTask = NSKeyedUnarchiver.unarchiveObject(with: task as! Data)
            aryTasks.append(unarchiveTask as! TaskObject)
        }
        
        return aryTasks
    }
    
    func getTaskID() -> Int {

        guard let category = self.taskCategory else { return 0 }

        var id = self.userDefault.array(forKey: TaskObject.keyForCategory(category))?.count
        
        if id == nil {
            id = 0
        }
        
        return id! + 1
    }

    class func keyForCategory(_ category: String) -> String {
        return "Task_\(category)"
    }
}
