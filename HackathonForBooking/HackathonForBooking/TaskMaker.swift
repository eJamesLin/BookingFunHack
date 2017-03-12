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
        let first = TaskObject(taskID: TaskObject.firstID, title: nil, content: nil)

        let t1 = TaskObject(taskID: 1, title: "吃掉倆倆", content: "至倆倆號購買一份餐點並與之合照，完成這一關。")
        t1.shouldBeDisplayed = true
        t1.isUnlock = true
        let t2 = TaskObject(taskID: 2, title: "頂尖 101", content: "至台北101拍攝一張手指頂住101樓頂之合照。")
        let t3 = TaskObject(taskID: 3, title: "任務三", content: "動作。")
        t1.isUnlock = true
        let arr = [first, t1, t2, t3]
        return arr
    }
}
