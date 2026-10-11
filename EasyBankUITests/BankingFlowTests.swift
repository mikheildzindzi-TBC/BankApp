import XCTest

final class BankingFlowTests: BaseClass {
    private var steps: EasyBankSteps!

    private let invalidEmail = TestConstants.User.invalidEmail
    private let unregisteredEmail = TestData.uniqueEmail()
    private let registeredEmail = TestData.uniqueEmail()
    private let password = TestConstants.User.password

    override func setUp() {
        super.setUp()   // launches the app
        steps = EasyBankSteps(page: EasyBankPage(app: app))
    }

    func testLoginWithInvalidEmailFormat() {
        steps.openLogin()
            .logIn(email: invalidEmail, password: password)
            .verifyLoginError(contains: TestConstants.ErrorFragment.badlyFormattedEmail)
    }

    func testLoginWithUnregisteredCredentials() {
        steps.openLogin()
            .logIn(email: unregisteredEmail, password: password)
            .verifyLoginError(contains: TestConstants.ErrorFragment.invalidCredentials)
    }

    func testRegisterLogoutAndLoginAgain() {
        steps.openRegistration()
            .register(email: registeredEmail, password: password)
            .verifyHomeScreen()
            .logOut()
            .logIn(email: registeredEmail, password: password)
            .verifyHomeScreen()
    }
}
