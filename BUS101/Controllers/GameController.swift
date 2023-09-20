//
//  GameController.swift
//  BUS101
//
//  Created by mitchell tucker on 9/11/23.
//

import SwiftUI

struct TextFieldItem : Identifiable {
    let id = UUID()
    var label : String = ""
}

enum QuestionType {
    case terms
    case questions
    case tfQuestions
    case written
}

class TermsController:ObservableObject {
    
    private var shuffledTerms:[Term] = []
    private var shuffledQuestions:[Question] = []
    private var shuffledTFQuestions:[Question] = []
    private var shuffledWritten:[Written] = []
    
    // Counters
    @Published var termCounter = 0
    @Published var questionCount = 0
    
    // If all where selected combine terms & questions
    @Published var totalTerms = 0
    @Published var totalQuestions = 0
    @Published var totalTFQuestions = 0
    @Published var totalWritten = 0
    
    // Current term
    @Published var currentTerm = ""
    @Published var currentDefinition = ""
    @Published var choices:[String] = []
    
    // Current Questions
    @Published var currentQuestion = ""
    @Published var currentAnswer:[String] = []
    @Published var userTextFeilds:[TextFieldItem] = []
    
    // True and false questions
    @Published var currentTFQuestion = ""
    // First position is answer
    // Second position is descitpion for false answers
    @Published var currentTFAnswer:[String] = []
    @Published var showTFCorrect = false // toggle if correct answer
    @Published var falseDescription:String = ""
    @Published var animateCorrectly:Bool? = nil
    
    
    private var choiceCount = 3 // TODO make settable
    //@Published var type:QuestionType = .terms
    
    func loadData(fileName:String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            print("file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        let chapterObjects = try? JSONDecoder().decode(ChapterDecoder.self, from: data!)
        
        // shuffle terms for randomness
        shuffledTerms = chapterObjects!.terms.shuffled()
        totalTerms = shuffledTerms.count
        
        shuffledQuestions = chapterObjects!.questions.shuffled()
        totalQuestions = shuffledQuestions.count
        
        shuffledTFQuestions = chapterObjects!.tfQuestions.shuffled()
        totalTFQuestions = shuffledTFQuestions.count
        
        shuffledWritten = chapterObjects!.written.shuffled()
        totalWritten = shuffledWritten.count
    }
    
    
    // MARK: getNextTerm
    func getNextTerm() {
        choices.removeAll()
        // TODO check if chapter object is nill
        let newTerm = shuffledTerms[termCounter]
        
        // Add are term
        currentDefinition = newTerm.d
        currentTerm = newTerm.t
        // get new choices
        getRandomTerm(newTerm.t)
        termCounter += 1
    }
    
    // MARK: getNextQuestion
    func getNextQuestion() {
        userTextFeilds.removeAll()
        
        let newQuestion = shuffledQuestions[questionCount]
        currentQuestion = newQuestion.q
        for _ in newQuestion.a {
            userTextFeilds.append(TextFieldItem()) // add placeholder for input
        }
        currentAnswer = newQuestion.a
        questionCount += 1
    }
    
    
    func getNextTFQuestion() {
        showTFCorrect = false
        
        let nextTFQuestion = shuffledTFQuestions[questionCount]
        
        currentTFQuestion = nextTFQuestion.q
        currentTFAnswer = nextTFQuestion.a
        
        questionCount += 1
    }
    
    // MARK: getRandomTerm
    func getRandomTerm(_ correctTerm:String) {
        var tempChoices:[String] = []
        tempChoices.append(correctTerm)
        // loop through choice count // should be a while loop prevent dup
        while(choices.count < choiceCount) {
            // get random term from term list
            let randomTerm = shuffledTerms.randomElement()
            // prevent duplicate choices
            if randomTerm!.t != currentTerm || !tempChoices.contains(randomTerm!.t) {
                // append term to choices
                choices.append(randomTerm!.t)
            }
        }
        choices.append(contentsOf: tempChoices.shuffled())
    }
    
    func checkTFAnswer(selected:String) {
        let anwser = currentTFAnswer[0]
        if anwser == selected{
            getNextTFQuestion()
        }else{
           print(currentTFAnswer.count)
            //if currentTFAnswer.count > 0{
            //    print(currentTFAnswer[1])
                // show correct answer
            //    falseDescription = currentTFAnswer[1]
            //    showTFCorrect = true
            //}

            
        }
    }
    
    // MARK: checkAnswer
    func checkAnswer(selected:String) {
        if selected == currentTerm {
            print("Correct")
            // todo show green
            getNextTerm()
        }else {
            // todo show red
            print("Incorrect")
        }
    }
}
