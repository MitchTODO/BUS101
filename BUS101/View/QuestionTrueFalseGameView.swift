//
//  QuestionTrueFalseGameView.swift
//  BUS101
//
//  Created by mitchell tucker on 9/12/23.
//

import SwiftUI

struct QuestionTrueFalseGameView: View {
    
    @EnvironmentObject var gController:TermsController
    var chapter:Chapter
    
    var body: some View {
        VStack {
            Text(gController.currentTFQuestion).padding(5)
            Divider()
            if gController.showTFCorrect {
                Text(gController.falseDescription)
            }
            Spacer()
            HStack {
                Button(action: {
                    gController.checkTFAnswer(selected:"true")
                }, label: {
                    Text("True")
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    gController.checkTFAnswer(selected:"false")
                }, label: {
                    Text("False")
                })
                .buttonStyle(.bordered)
            }
            Spacer()
        }.onAppear {
            // load are chapter
            gController.loadData(fileName: "chapter\(chapter.id)")
            gController.getNextTFQuestion()
        }
    }
}

struct QuestionTrueFalseGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTrueFalseGameView(chapter: Chapter(id: 0))
    }
}
