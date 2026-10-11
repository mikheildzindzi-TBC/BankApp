import XCTest

enum WaitHelper {
    /// Returns as soon as the element exists; `timeout` is only the upper limit.
    static func waitForExistence(_ element: XCUIElement,
                                 timeout: TimeInterval = TestConstants.Timeout.element) -> Bool {
        element.waitForExistence(timeout: timeout)
    }

    /// waits until the element is hittable (visible and tappable) or the timeout passes.
    static func waitForHittable(_ element: XCUIElement,
                                timeout: TimeInterval = TestConstants.Timeout.element) -> Bool {
        let predicate = NSPredicate(format: "isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}