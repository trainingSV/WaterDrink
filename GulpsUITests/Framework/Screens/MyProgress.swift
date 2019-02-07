//
//  MyProgress.swift
//  GulpsUITests
//
//  Created by George Galan on 14/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

class MyProgress: ScreenBase {
  
  lazy var tinyAddButton = app.buttons[AccessabilityLabels.kTinyAdd]
  lazy var shareButton = app.navigationBars[AccessabilityLabels.kMyProgress].buttons.firstMatch
  lazy var calendarView = app.scrollViews.firstMatch
  lazy var percentAmount = app.staticTexts.element(boundBy: 1)
  lazy var goalMetText = app.staticTexts[AccessabilityLabels.kGoalMet]
  lazy var selectGulpSizeMenuHeader = tablesQuery.staticTexts[AccessabilityLabels.kAddANewPortion]
  lazy var cancelButton = app.buttons[AccessabilityLabels.kCancel]
  lazy var bigGulpOption = tablesQuery.staticTexts[AccessabilityLabels.kBigGulp]
  lazy var smallGulpOption = tablesQuery.staticTexts[AccessabilityLabels.kSmallGulp]

  override func validateScreen() {
		XCTAssertTrue(shareButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Share Button does not exist")
  }

  override func goToScreen(_ screen: ScreenBase) {
    switch screen {
    case is Drink:
      drinkTab.tap()
    case is Preferences:
      preferencesTab.tap()
    default:
      break
    }
    screen.validateScreen()
  }

  // Gets the numerical value of the percentage displayed
	func getCurrentPercent() -> Int {
		let initialValue = String(percentAmount.label.dropLast())
		let optionalNumericalInitiaValue = Int(initialValue)
		var validValue: Int = 0
		if let numericalInitiaValue = optionalNumericalInitiaValue{
			validValue = numericalInitiaValue
		}
		else {
			XCTFail("Error: The percentage value is not a numerical value")
		}
		return validValue
	}

  // Taps on the tiny add button and checks user is redirected to the gulp size menu
  func tapTinyAddButton() {
    tinyAddButton.tap()
		validateGulpSizesMenu()
  }

	// Validates the Menu which appears when tapping on the Tiny Add Button
	func validateGulpSizesMenu() {
		XCTAssertTrue(selectGulpSizeMenuHeader.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "User was not redirected to select Gulp menu")
		XCTAssertTrue(cancelButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "There is no Cancel button")
	}

  // Adds a small gulp from the gulp menu andh check percentage correctly updated
  func addLittleGulp() {
    tapTinyAddButton()
    smallGulpOption.tap()
    }

  // Adds a big gulp from the gulp menu andh check percentage correctly updated
  func addBigGulp() {
    tapTinyAddButton()
    bigGulpOption.tap()
  }

  // Keeps adding gulps until percentage displayed goes over the value 99 and checks that the "Goal Met" string is displayed
  func addGulpsTillDailyGoalReached() {
    let initialPercent = self.getCurrentPercent()
    while initialPercent < 100 && !goalMetText.waitForExistence(timeout: FrameworkConstants.defaultTimeout){
      addBigGulp()
    }
  }
	
	// Validates that the Goal Met! text is displayed
	func validateGoalMetDisplayed() {
		XCTAssertTrue(goalMetText.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Goal Met!' text not displayed")
	}

  // Validates the elements in My Progress Screen
  func validateMyProgressScreenElements() {
    XCTAssertTrue(tinyAddButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Tiny Add button not present on screen")
    XCTAssertTrue(shareButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Share Button not present on screen")
    XCTAssertTrue(calendarView.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Calendar View not present on screen")
    XCTAssertTrue(percentAmount.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Percentage amount not present on screen")
		validateNavigationBar()
  }
}
