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
    static let firstID = -1
    
    func isFirstDummyTask() -> Bool {
        return taskID == TaskObject.firstID
    }

    var taskTitle: String?
    var taskContent: String?
    var taskPhoto: UIImage?
    var taskFinished = false

    var shouldBeDisplayed = false
    
    let userDefault = UserDefaults.standard
    
    //MARK: - NSCoding Delegate
    init(taskID: Int, title: String?, content: String?) {
        super.init()
        self.taskID = taskID
        taskTitle = title
        taskContent = content
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

        self.taskFinished = aDecoder.decodeBool(forKey: "taskFinished")
        self.shouldBeDisplayed = aDecoder.decodeBool(forKey: "shouldBeDisplayed")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: self.taskID), forKey: "id")
        aCoder.encode(self.taskTitle, forKey: "title")
        aCoder.encode(self.taskContent, forKey: "content")
        aCoder.encode(self.taskPhoto, forKey: "photo")
        aCoder.encode(self.taskFinished, forKey: "taskFinished")
        aCoder.encode(self.shouldBeDisplayed, forKey: "shouldBeDisplayed")
    }
}
