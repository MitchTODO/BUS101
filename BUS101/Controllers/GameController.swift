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

class TermsController:ObservableObject {
    private var shuffledTerms:[Term] = []
    private var shuffledQuestions:[Question] = []
    private var shuffledTFQuestions:[TfQuestion] = []
    private var shuffledWritten:[Written] = []
    
    // Counters
    @Published var termCounter = 0
    @Published var questionCount = 0
    
    // If all where selected combine terms & questions
    @Published var totalTerms = 0
    @Published var totalQuestions = 0
    @Published var totalTFQuestions = 0
    @Published var totalWritten = 0
    
    //
    @Published var currentTerm = ""
    @Published var currentDefinition = ""
    
    // Questions
    @Published var currentQuestion = ""
    @Published var currentAnswer:[String] = []
    @Published var userTextFeilds:[TextFieldItem] = []
    
    @Published var choices:[String] = []
    
    var choiceCount = 3

    func loadData(fileName:String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            print("file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        let chapterObjects = try? JSONDecoder().decode(ChapterDecoder.self, from: data!)
        //print(chapterObjects)
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
    //
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
    //
    func getNextQuestion() {
        userTextFeilds.removeAll()
        print(shuffledQuestions)
        //let newQuestion = shuffledQuestions[questionCount]
        //currentQuestion = newQuestion.q
        //for _ in newQuestion.a {
        //    userTextFeilds.append(TextFieldItem()) // add placeholder for input
        //}
        //currentAnswer = newQuestion.a
        //questionCount += 1
    }
    
    // TODO check for duplicates
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
