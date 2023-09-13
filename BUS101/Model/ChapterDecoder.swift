
import Foundation

// MARK: - Welcome
struct ChapterDecoder: Codable {
    let terms: [Term]
    let questions: [Question]
    let tfQuestions: [TfQuestion]
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

// MARK: - TfQuestion
struct TfQuestion: Codable {
    let q: String
    let a: [A]
}

enum A: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(A.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for A"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Written
struct Written: Codable {
    let q, a: String
}
