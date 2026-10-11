import Foundation

enum TestData {
    /// Fresh valid-format email for every call.
    static func uniqueEmail() -> String {
        "user.\(UUID().uuidString.prefix(8).lowercased())@\(TestConstants.User.emailDomain)"
    }
}