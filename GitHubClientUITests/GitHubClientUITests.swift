import XCTest

final class GitHubClientUITests: XCTestCase {
    // MARK: - Constants
    let searchedUser = "nunesdennis"
    let search = "Search"
    let navTitle = "Usuários"
    let firstUser = "mojombo"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSearchedUserClicked() throws {
        let app = XCUIApplication()
        app.launch()
        
        let usersNavigationBar = app.navigationBars[navTitle]
        XCTAssertTrue(usersNavigationBar.exists)
        
        let searchButton = usersNavigationBar.buttons[search]
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()
        
        let searchField = usersNavigationBar.staticTexts.matching(identifier: navTitle).otherElements.children(matching: .searchField).element
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText(searchedUser)
        
        let keyboardSearchButton = app.buttons[search]
        XCTAssertTrue(keyboardSearchButton.exists)
        keyboardSearchButton.tap()
        
        let firstCell = app.tables.cells.staticTexts[searchedUser]
        XCTAssertTrue(firstCell.exists)
        
        firstCell.tap()
    }
    
    func testFirstUserClicked() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstCell = app.tables.cells.staticTexts[firstUser]
        XCTAssertTrue(firstCell.exists)
        
        firstCell.tap()
    }
}
