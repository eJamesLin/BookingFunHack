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

        let t1 = TaskObject(taskID: 1, title: "Awesome cuisine", content: "Go to the place to buy your breakfast and take a picture.")
        t1.shouldBeDisplayed = true
        t1.isUnlock = true
        let t2 = TaskObject(taskID: 2, title: "On top of 101", content: "Definitely need a selfie with 101 tower.")
        let t3 = TaskObject(taskID: 3, title: "Best BEER in the town!!!", content: "Enjoy your relax moment at the bar, share with your friends")
        t3.isUnlock = true
        let t4 = TaskObject(taskID: 4, title: "Having some tasty Shit for the sweet trip", content: "Have a coolest selfie at Modern Toilet Restaurant, and smell!!!")
        t4.isUnlock = true
        let arr = [first, t1, t2, t3, t4]
        return arr
    }
}
