//
//  GetClueQuestion.swift
//  HackathonForBooking
//
//  Created by Zack on 2017/3/12.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import Foundation



enum AnswerOption:String{
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
}


class QuestionBuild{
    fileprivate var _questionName:String!
    fileprivate var _questionDescription:String!
    fileprivate var _answerA:String!
    fileprivate var _answerB:String!
    fileprivate var _answerC:String!
    fileprivate var _answerD:String!
    fileprivate var _correctAnswer: AnswerOption?
    
    fileprivate var _questionKey: String!
    
    var questionName:String{
        get{
            return _questionName
        }set{
            _questionName = newValue
        }
    }
    
    
    var questionDescription:String{
        get{
            return _questionDescription
        }set{
            _questionDescription = newValue
        }
    }
    var answerA:String{
        get{
            return _answerA
        }set{
            _answerA = newValue
        }}
    var answerB:String{
        get{
            return _answerB
        }set{
            _answerC = newValue
        }}
    
    var answerC:String{get{
        return _answerC
        }set{
            _answerC = newValue
        }}
    
    var answerD:String{get{
        return _answerD
        }set{
            _answerD = newValue
        }}
    
    var correctAnswer: AnswerOption {get{
        
        return _correctAnswer!
        }set{
            _correctAnswer = newValue
        }}
    
    
    var questionKey:String{
        return _questionKey
    }
    
    
    
    
    
    init(questionName:String , questionDescription:String ,answerA:String, answerB:String, answerC:String, answerD:String, correctAnswer: AnswerOption?) {
        _questionName = questionName
        _questionDescription = questionDescription
        _answerA = answerA
        _answerB = answerB
        _answerC = answerC
        _answerD = answerD
        _correctAnswer = correctAnswer
    }
}



class ANSWERS{
    
    
    fileprivate var _answerDescription:String!
    fileprivate var _answerOption:AnswerOption!
    
    var answerDescription:String{
        return _answerDescription
    }
    var answerOption:AnswerOption{
        return _answerOption
    }
    
    init(answerDescription:String , answerOption: AnswerOption){
        _answerDescription = answerDescription
        _answerOption = answerOption
    }
    
    
    
    
    
    
    
}
