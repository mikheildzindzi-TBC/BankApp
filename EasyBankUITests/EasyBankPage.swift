import XCTest

/// Locators only – no actions, no waits, no assertions.
final class EasyBankPage {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // MARK: Onboarding
    func onboardingLoginButton() -> XCUIElement { app.buttons["onboarding.login"] }
    func onboardingRegisterButton() -> XCUIElement { app.buttons["onboarding.register"] }

    // MARK: Login
    func loginEmailField() -> XCUIElement { app.textFields["login.email"] }
    func loginPasswordField() -> XCUIElement { app.secureTextFields["login.password"] }
    func loginSubmitButton() -> XCUIElement { app.buttons["login.submit"] }
    func loginErrorLabel() -> XCUIElement { app.staticTexts["login.error"] }

    // MARK: Registration
    func registrationEmailField() -> XCUIElement { app.textFields["registration.email"] }
    func registrationPasswordField() -> XCUIElement { app.secureTextFields["registration.password"] }
    func registrationRepeatPasswordField() -> XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    func registrationSubmitButton() -> XCUIElement { app.buttons["registration.submit"] }

    // MARK: Home
    func homeTab() -> XCUIElement { app.tabBars.buttons["Home"] }
    func sendMoneyButton() -> XCUIElement { app.buttons["home.sendMoney"] }
    func logoutButton() -> XCUIElement { app.buttons["home.logout"] }

    // MARK: Logout dialog
    func logoutAlert() -> XCUIElement { app.alerts["Logging Out"] }
    func logoutConfirmButton() -> XCUIElement { logoutAlert().buttons["Yes"] }

    // MARK: System prompt ("Use Strong Password?")
    func strongPasswordCloseButton() -> XCUIElement { app.buttons["Close"] }
}