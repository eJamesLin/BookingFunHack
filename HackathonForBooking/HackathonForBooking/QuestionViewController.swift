//
//  QuestionViewController.swift
//  NihongoLearning
//
//  Created by Zack on 2016/12/13.
//  Copyright © 2016年 DaGin. All rights reserved.
//

import UIKit




class QuestionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var answerTableView: UITableView!
    
    
    @IBOutlet weak var questionNameLabel: UILabel!
    
    @IBOutlet weak var questionDescriptionLabel: UILabel!
 
    let q1 = QuestionBuild(questionName: "Question", questionDescription: "Which one is the tallest Building in Taipei city?", answerA: "Taipei 101", answerB: "SHINKONG\nMITSUKOSHI", answerC: "Taipei 505", answerD: "", correctAnswer: .A)
    
    
    func makeQuestion(_ questionNumber: QuestionBuild){
        
        questionDescriptionLabel.text = questionNumber.questionDescription
        
        let ansA = ANSWERS(answerDescription: questionNumber.answerA, answerOption: .A)
        let ansB = ANSWERS(answerDescription: questionNumber.answerB, answerOption: .B)
        let ansC = ANSWERS(answerDescription: questionNumber.answerC, answerOption: .C)
        let ansD = ANSWERS(answerDescription: questionNumber.answerD, answerOption: .D)
        
        
        answers.insert(ansA , at: 0)
        answers.insert(ansB , at: 1)
        answers.insert(ansC , at: 2)
        answers.insert(ansD , at: 3)
        
    }
    
    
    
    
    
    
    var answers = [ANSWERS]()
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersCellID", for: indexPath) as? AnswerTableViewCell{
            let answer = answers[indexPath.section]
            cell.updateUI(answer)
            
            answerTableView.backgroundColor = UIColor.clear
            
            
            
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            
            
            
            
            
            
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var blankOptions: Int
        blankOptions = 0
        for answer in answers{
            if answer.answerDescription == ""{
                blankOptions += 1
            }
            
        }
        
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = answers[indexPath.section]
        
        if answer.answerOption == q1.correctAnswer{
            performSegue(withIdentifier: "QuestionViewController", sender: nil)
            
        }else{
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerTableViewCellNib = UINib(nibName: AnswerTableViewCell.className(), bundle: Bundle(for: AnswerTableViewCell.self))
        self.answerTableView.register(answerTableViewCellNib, forCellReuseIdentifier: "AnswersCellID")
        
        
        self.answerTableView.separatorStyle = .none
        
        
        self.makeQuestion(q1)
        
        self.questionDescriptionLabel.text = q1.questionDescription
      
        self.answerTableView.delegate = self
        self.answerTableView.dataSource = self
        print("load of ringGGGGGGGGG")
        self.animateTable()
        
    }
    
    
    
    
    
    
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let destination = segue.destination as? ResultVC{
//            if let sendResult = sender as? Array<Result> {
//                destination.finalResults = sendResult
//            }
//        }
//    }
    func animateTable() {
        answerTableView.reloadData()
        
        let cells = answerTableView.visibleCells
        let tableHeight: CGFloat = answerTableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for c in cells {
            let cell: UITableViewCell = c as UITableViewCell
            UIView.animate(withDuration: 1, delay: 0.1 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    
    
    
}





