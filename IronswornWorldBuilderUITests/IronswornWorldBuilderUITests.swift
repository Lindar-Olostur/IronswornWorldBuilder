//
//  IronswornWorldBuilderUITests.swift
//  IronswornWorldBuilderUITests
//
//  Created by Lindar Olostur on 01.12.2022.
//

import XCTest

final class IronswornWorldBuilderUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        XCUIApplication().terminate()
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
//            app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Terminus"]/*[[".cells.buttons[\"Terminus\"]",".buttons[\"Terminus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//            app.navigationBars["Terminus"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//            
//            let collectionViewsQuery = app.collectionViews
//            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Terminus"]/*[[".cells.buttons[\"Terminus\"]",".buttons[\"Terminus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["New Clock 0/4"]/*[[".cells.buttons[\"New Clock 0\/4\"]",".buttons[\"New Clock 0\/4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//                    
//            app.buttons["+"].tap()
//            app.buttons["+"].tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
