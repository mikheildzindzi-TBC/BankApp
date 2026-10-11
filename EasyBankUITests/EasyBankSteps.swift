import XCTest

/// Actions, waits, assertions and reusable flows. Locators come from `EasyBankPage`.
final class EasyBankSteps {
    private let page: EasyBankPage

    init(page: EasyBankPage) {
        self.page = page
    }

    // MARK: Helpers
    private func waitAndTap(_ element: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(WaitHelper.waitForExistence(element),
                      "Element not found: \(element)", file: file, line: line)
        element.tap()
    }

    private func type(_ text: String, into field: XCUIElement, file: StaticString = #filePath, line: UInt = #line) {
        waitAndTap(field, file: file, line: line)
        field.typeText(text)
    }

    private func dismissStrongPasswordPromptIfShown() {
        let close = page.strongPasswordCloseButton()
        if WaitHelper.waitForExistence(close, timeout: TestConstants.Timeout.systemPrompt) {
            close.tap()
        }
    }

    // MARK: Navigation
    @discardableResult
    func openLogin() -> Self {
        waitAndTap(page.onboardingLoginButton())
        return self
    }

    @discardableResult
    func openRegistration() -> Self {
        waitAndTap(page.onboardingRegisterButton())
        return self
    }

    // MARK: Login
    @discardableResult
    func logIn(email: String, password: String) -> Self {
        type(email, into: page.loginEmailField())
        type(password, into: page.loginPasswordField())
        waitAndTap(page.loginSubmitButton())
        return self
    }

    @discardableResult
    func verifyLoginError(contains fragment: String,
                          file: StaticString = #filePath, line: UInt = #line) -> Self {
        let error = page.loginErrorLabel()
        XCTAssertTrue(WaitHelper.waitForExistence(error),
                      "Login error was not displayed", file: file, line: line)
        XCTAssertTrue(error.label.contains(fragment),
                      "Expected error to contain '\(fragment)' but was '\(error.label)'",
                      file: file, line: line)
        return self
    }

    private func typeVisiblePassword(_ password: String,
                                 secureField: XCUIElement,
                                 toggle: XCUIElement,
                                 visibleField: XCUIElement,
                                 file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertTrue(WaitHelper.waitForExistence(secureField), "Password field not found", file: file, line: line)
    waitAndTap(toggle, file: file, line: line)          // reveal BEFORE the field gets focus
    waitAndTap(visibleField, file: file, line: line)    // now it is a normal text field
    visibleField.typeText(password)
    XCTAssertEqual(visibleField.value as? String, password,
                   "Password was not typed correctly", file: file, line: line)
}

    // MARK: Registration
    @discardableResult
func register(email: String, password: String) -> Self {
    type(email, into: page.registrationEmailField())
    typeVisiblePassword(password,
                        secureField: page.registrationPasswordField(),
                        toggle: page.registrationPasswordToggle(),
                        visibleField: page.registrationPasswordVisibleField())
    typeVisiblePassword(password,
                        secureField: page.registrationRepeatPasswordField(),
                        toggle: page.registrationRepeatPasswordToggle(),
                        visibleField: page.registrationRepeatPasswordVisibleField())
    waitAndTap(page.registrationSubmitButton())
    return self
}

    // MARK: Home / logout
    @discardableResult
    func verifyHomeScreen(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTAssertTrue(WaitHelper.waitForExistence(page.sendMoneyButton()),
                      "Send Money button not visible – Home was not opened", file: file, line: line)
        XCTAssertTrue(page.homeTab().exists, "Home tab not visible", file: file, line: line)
        return self
    }

    @discardableResult
    func logOut() -> Self {
        waitAndTap(page.logoutButton())
        XCTAssertTrue(WaitHelper.waitForExistence(page.logoutAlert()), "Logout dialog not shown")
        page.logoutConfirmButton().tap()
        XCTAssertTrue(WaitHelper.waitForExistence(page.loginSubmitButton()),
                      "Login form not shown after logout")
        return self
    }
}