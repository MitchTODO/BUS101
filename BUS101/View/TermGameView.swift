//
//  GameView.swift
//  BUS101
//
//  Created by mitchell tucker on 9/11/23.
//

import SwiftUI

struct TermGameView: View {
    
    @EnvironmentObject var gController:TermsController
    var chapter:Chapter

    var body: some View {
        VStack{
            Text(gController.currentDefinition).padding(5)
            Spacer()
            Divider()
            List{
                ForEach(gController.choices,id:\.self) { term in
                    Button(action: {
                        gController.checkAnswer(selected: term)
                    }, label: {
                        Text(term)
                    })
                }
            }
            Spacer()
        }
        .onAppear {
            // load chapter data on appear
            gController.loadData(fileName: "chapter\(chapter.id)")
            // When done loading data
            gController.getNextTerm()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("\(gController.termCounter)/\(gController.totalQuestions)")
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        TermGameView(chapter: Chapter(id: 0))
    }
}
