import Foundation

enum TestConstants {
    enum ErrorFragment {
        static let badlyFormattedEmail = "badly formatted"
        static let invalidCredentials = "malformed or has expired"
    }

    enum User {
        static let invalidEmail = "whileEmailIsNotValid"
        static let password = "TestPassword123!"
        static let emailDomain = "example.com"
    }

    enum Timeout {
        static let element: TimeInterval = 10
        static let systemPrompt: TimeInterval = 2
    }
}