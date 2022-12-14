//
//  Calculator.swift
//  Questionnaire
//
//  Created by Sebastian-Falk Birchner on 15.08.22.
//

class Calculator {
    private let questionEntries: [QuestionEntry]
    
    init(questionEntries: [QuestionEntry]) {
        self.questionEntries = questionEntries
    }
    
    var report: Report {
        let numberOfCorrectAnswers = calculateScore()
        let correctPercentages = calculatePercentages(correctAnswers: Double(numberOfCorrectAnswers), maxAnswers: Double(numberOfQuestions))
        var reports = [ResultText]()
        
        for entry in questionEntries {
            reports.append(calculateResult(entry: entry))
        }
        
        return Report(numberOfCorrectAnswers: numberOfCorrectAnswers, numberOfQuestions: numberOfQuestions, correctPercentages: correctPercentages, resultText: reports)
    }
    
    func calculatePercentages(correctAnswers: Double, maxAnswers: Double) -> Double {
        return (correctAnswers / maxAnswers) * 100
        
    }
    
    func calculateResult(entry: QuestionEntry) -> ResultText {
        let question = entry.question
        let isCorrect = isCorrectAnswer(entry: entry)
        let correctAnswer = entry.answers[entry.correctAnswer]
        let selectedAnswer = getSelectedAnswer(entry)
        
        return ResultText(question: question!, selectedAnswer: selectedAnswer, correctAnswer: correctAnswer, isCorrect: isCorrect)
    }
    
    var numberOfQuestions: Int {
        return questionEntries.count
    }
    
    func calculateScore() -> Int {
        var score = 0
        
        for questionEntry in questionEntries {
            if isCorrectAnswer(entry: questionEntry) {
                score += 1
            }
        }
        return score
    }
    
    func isCorrectAnswer(entry: QuestionEntry) -> Bool {
        return entry.correctAnswer == entry.selectedAnswer
    }
    
    private func getSelectedAnswer(_ entry: QuestionEntry) -> String {
        if let answer = entry.selectedAnswer {
            return entry.answers[answer]
        } else {
            return ""
        }
    }
}
