//
//  ChapterSubView.swift
//  BUS101
//
//  Created by mitchell tucker on 9/11/23.
//

import SwiftUI

struct ChapterSubView: View {
    var chapter:Chapter
    // set game controller for passive changes
    @StateObject var gController = GameController()
    
   
    var body: some View {
            
            List {
                NavigationLink {
                    TermGameView(chapter:chapter ).environmentObject(gController)
                } label: {
                    Text("Terms")
                }
                NavigationLink {
                    QuestionGameView()
                } label: {
                    Text("Basic Questions")
                }
                NavigationLink {
                    QuestionTrueFalseGameView()
                } label: {
                    Text("True & False Questions")
                }
                NavigationLink {
                    QuestionGameView()
                } label: {
                    Text("Written Questions")
                }
            }
            .navigationTitle(Text("Chapter \(chapter.id)"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                         NavigationLink{
                             TermGameView(chapter:chapter ).environmentObject(gController)
                         }label: {
                           Text("Start")
                         }
                     }
                 }
    }
}

struct ChapterSubView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSubView(chapter: Chapter(id: 1))
    }
}
