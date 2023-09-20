
import Foundation


// MARK: - ChapterDecoder
struct ChapterDecoder: Codable {
    let terms: [Term]
    let questions, tfQuestions: [Question]
    let written: [Written]
}

// MARK: - Question
struct Question: Codable {
    let q: String
    let a: [String]
}

// MARK: - Term
struct Term: Codable {
    let t, d: String
}

// MARK: - Written
struct Written: Codable {
    let q, a: String
}
