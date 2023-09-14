//
//  QuestionGameView.swift
//  BUS101
//
//  Created by mitchell tucker on 9/12/23.
//

import SwiftUI

struct QuestionGameView: View {
    
    @EnvironmentObject var gController:TermsController
    var chapter:Chapter
    
    var body: some View {
        VStack {
            Text(gController.currentDefinition).padding(5)
            Spacer()
            Divider()
            ForEach($gController.userTextFeilds) { $answerField in
                TextField(answerField.label, text: $answerField.label)
            }
        }
        .onAppear {
            // load are chapter
            
            gController.getNextQuestion()
        }
    }
}

struct QuestionGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionGameView(chapter: Chapter(id: 0))
    }
}
