//
//  GlobalUtilities.swift
//  GulpsUITests
//
//  Created by George Galan on 06/02/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

struct GlobalUtilities {

	let app = XCUIApplication()

	func validateCorrectPercentageAmountAdded(from initialValue: Int, adding percentageAmount: Int) {
		XCTAssertTrue(app.staticTexts["\(initialValue + percentageAmount)%"].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Correct gulp percentage was not added")
	}

	func comparePercentageAmounts(compare firstValue: Int, with secondValue: Int) {
		XCTAssertEqual(firstValue, secondValue, "Percentages are not Equal")
	}

	func validateACorrectPercentageIsDisplayed(percentage: Int) {
		XCTAssertTrue(app.staticTexts[("\(percentage)%")].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Incorrect percentage displayed on screen")
	}
}
