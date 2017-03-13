//
//  QuestionTableViewCell.swift
//  NihongoLearning
//
//  Created by Zack on 2016/12/13.
//  Copyright © 2016年 DaGin. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    
    @IBOutlet var correctView: UIView!
   

    @IBOutlet weak var answerLabel: UILabel!
    
    
    
    func updateUI(_ answers: ANSWERS){
        answerLabel.text = "(\(answers.answerOption)). " + answers.answerDescription
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        correctView.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        correctView.backgroundColor = UIColor.red

        // Configure the view for the selected state
    }

}
