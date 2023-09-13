//
//  GameController.swift
//  BUS101
//
//  Created by mitchell tucker on 9/11/23.
//

import SwiftUI

class GameController:ObservableObject {
    @Published var chapterObjects:ChapterDecoder? = nil
    private var shuffledTerms:[Term] = []
    
    // Counter for terms
    @Published var termCounter = 0
    @Published var totalQuestions = 0
    
    @Published var currentTerm = ""
    @Published var currentDefinition = ""
    
    @Published var choices:[String] = []
    
    var choiceCount = 3

    func loadData(fileName:String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            print("file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        var chapterData = try? JSONDecoder().decode(ChapterDecoder.self, from: data!)

        // shuffle terms for randomness
        let shuffled = chapterData!.terms.shuffled()
        totalQuestions = shuffled.count
        self.shuffledTerms = shuffled
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
