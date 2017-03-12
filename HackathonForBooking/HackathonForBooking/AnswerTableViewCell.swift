//
//  AnswerTableViewCell.swift
//  HackathonForBooking
//
//  Created by Zack on 2017/3/12.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var answerLabel: UILabel!
    
    
    
    func updateUI(_ answers: ANSWERS){
        answerLabel.text =  answers.answerDescription
    
        
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
