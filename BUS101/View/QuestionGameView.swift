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
            Text(gController.currentQuestion).padding(5)
            Divider()
            Spacer()
            
            ForEach($gController.userTextFeilds) { $answerField in
                TextField(answerField.label, text: $answerField.label).textFieldStyle(.roundedBorder)
                    .frame(height: 100.0)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(5)
            }
            
            Button(action: {
                print("Correct answer \(gController.currentAnswer)")
                for t in gController.userTextFeilds {
                    print(t)
                }
            }, label: {
                Text("Submit")
                
            })
            .buttonStyle(.bordered)
            Spacer()
 
        }
        .onAppear {
            // load are chapter
            gController.loadData(fileName: "chapter\(chapter.id)")
            gController.getNextQuestion()
        }
    }
}

struct QuestionGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionGameView(chapter: Chapter(id: 0))
    }
}
