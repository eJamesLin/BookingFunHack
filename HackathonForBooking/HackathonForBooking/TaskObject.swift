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
    var taskID = 0
    var taskTitle: String?
    var taskContent: String?
    var taskPhoto: UIImage?
    
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
        
        var aryTask = [Data]()
        
        if self.userDefault.array(forKey: "Task")?.count != nil {
            aryTask = self.userDefault.array(forKey: "Tasks") as! [Data]
        }
        
        let savedData = NSKeyedArchiver.archivedData(withRootObject: task)
        aryTask.append(savedData)
        
        self.userDefault.set(aryTask, forKey: "Tasks")
        self.userDefault.synchronize()
    }
    
    func getTaskID() -> Int {
        
        var id = self.userDefault.array(forKey: "Tasks")?.count
        
        if id == nil {
            id = 0
        }
        
        return id! + 1
    }
}
