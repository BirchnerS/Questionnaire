//
//  ContentView.swift
//  Questionnaire
//
//  Created by Sebastian-Falk Birchner on 15.08.22.
//

import SwiftUI

struct ContentView: View {
    @State var content: [QuestionEntry]
    private var calculator: Calculator {
        return Calculator(questionEntries: content)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ForEach(content, id: \.self) { entry in
                    VStack {
                        Text(entry.question)
                        HStack {
                            RadioButtonGroup(items: entry.answers) { selected in
                                buttonTapped(selected, entry: entry)
                            }
                            
                        }
                    }
                }
                NavigationLink(destination: ResultView(calculator: calculator)) {
                    Text("Show my score...")
                }
                .navigationTitle("Questionnaire")
                
            }
        }
    }
    
    func buttonTapped(_ tappedAnswer: String, entry selectionEntry: QuestionEntry) {
        for (index, entry) in content.enumerated() {
            if entry == selectionEntry {
                content[index] = selectContent(answer: tappedAnswer, fromEntry: entry)
            }
        }
    }
    
    func selectContent(answer newAnswer: String, fromEntry entry: QuestionEntry) -> QuestionEntry {
        var entryWithSelection = entry
        
        for (index, answer) in entry.answers.enumerated() {
            if answer == newAnswer {
                entryWithSelection.selectedAnswer = index
            }
        }
        return entryWithSelection
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}