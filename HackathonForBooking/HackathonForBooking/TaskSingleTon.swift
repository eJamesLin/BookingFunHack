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
}
