//
//  Drink.swift
//  GulpsUITests
//
//  Created by George Galan on 11/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

class Drink: ScreenBase {

  lazy var plusIconButton = app.buttons[AccessabilityLabels.kPlusIcon]
  lazy var smallGulpButton = app.buttons[AccessabilityLabels.kSmallIcon]
  lazy var largeGulpButton = app.buttons[AccessabilityLabels.kLargeIcon]
  lazy var minusIconButton = app.buttons[AccessabilityLabels.kMinusIcon]
  lazy var undoAlert = app.alerts[AccessabilityLabels.kUndo]
  lazy var undoTutorialCoachmark = app.staticTexts[AccessabilityLabels.kUndoCoachMarkDescription]
  lazy var percentAmount = app.staticTexts.element(boundBy: 0)
  lazy var appleHealthCoachMark = app.staticTexts[AccessabilityLabels.kAppleHealthCoachMarkDescription]
  lazy var lastKnownPercentage = [Int]()

  override func validateScreen() {
    validatePlusSymbolDisplayed()
  }

  override func goToScreen(_ screen: ScreenBase) {
    switch screen {
    case is MyProgress:
      myProgressTab.tap()
    case is Preferences:
      preferencesTab.tap()
    default:
      break
    }
    screen.validateScreen()
  }

  // Gets the numerical value of the displayed percentage
  func getInitialPercent() -> Int {
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

  // Taps on the plus button and checks if correct icons displayed
  func tapOnPlusButton() {
    plusIconButton.tap()
		validateGulpIconsDisplayed()
  }
	// Validates Large and small Gulp Button displayed
	func validateGulpIconsDisplayed() {
		XCTAssertTrue(smallGulpButton.isEnabled, "Small Gulp button not displayed")
		XCTAssertTrue(largeGulpButton.isEnabled, "Large Gulp button not displayed")
	}

	// Validate Plus Icon is displayed
	func validatePlusSymbolDisplayed() {
		XCTAssertTrue(plusIconButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Plus button not displayed")
	}

  // Taps on the Small Gulp icon, check Plus Button is displayed again and waits for percentage animation to finish
  func tapOnSmallGulpButton() {
    smallGulpButton.tap()
    sleep(FrameworkConstants.defaultSleepDuration)
  }

  // Taps on the Large Gulp icon, check Plus Button is displayed again and waits for percentage animation to finish
  func tapOnLargeGulpButton() {
    largeGulpButton.tap()
    sleep(FrameworkConstants.defaultSleepDuration)
  }

  // Taps on Undo and checks alert displayed
  func tapUndoButton() {
    minusIconButton.tap()
  }
  
  // Validates undo alert has the proper elements
  func validateUndoAlert(withTitle title:String = AccessabilityLabels.kUndo, andDescription description:String = AccessabilityLabels.KUndoAlertDescription) {
    XCTAssertTrue(undoAlert.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Undo Alert not displayed")
    XCTAssertTrue(undoAlert.buttons[AccessabilityLabels.kYes].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Yes' button missing")
    XCTAssertTrue(undoAlert.buttons[AccessabilityLabels.kNo].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'No' button missing")
    XCTAssertTrue(undoAlert.staticTexts[title].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Title of alert is not as expected")
    XCTAssertTrue(undoAlert.staticTexts[description].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Description of alert is not as expected")
  }

  // Adds a small gulp and checks if percentage value was updated correctly
  func addSmallGulp() {
    let initialPercent = self.getInitialPercent()
    lastKnownPercentage.append(initialPercent)
    tapOnPlusButton()
    tapOnSmallGulpButton()
  }

  // Adds a big gulp and checks if percentage value was updated correctly
  func addBigGulp() {
    let initialPercent = self.getInitialPercent()
    lastKnownPercentage.append(initialPercent)
    tapOnPlusButton()
    tapOnLargeGulpButton()
  }

  // Undoes the last gulp added and check if percentage value was updated correctly
  func undoLastGulpAdded() {
    tapUndoButton()
		validateUndoAlert()
    undoAlert.buttons[AccessabilityLabels.kYes].tap()
    sleep(FrameworkConstants.defaultSleepDuration)
  }
	
	// Validates Undo action has undone the correct amount
	func validateCorrectAmountUndone() {
		let currentPercent = self.getInitialPercent()
		XCTAssertEqual(currentPercent, lastKnownPercentage.removeLast(),"The correct amount was not undone")
	}

  // Attempt to undo last gulp added but cancels and check percentage value remained the same
  func tapUndoButtonAndCancel() {
    tapUndoButton()
    undoAlert.buttons[AccessabilityLabels.kNo].tap()
  }

  // Taps the undo button until Gulps percent is 0
  func undoGulpsUntilZeroPercent() {
    let currentPercent = self.getInitialPercent()
    while currentPercent > 0 && !app.staticTexts[AccessabilityLabels.kZeroPercent].waitForExistence(timeout: FrameworkConstants.defaultTimeout) {
			tapUndoButton()
			undoAlert.buttons[AccessabilityLabels.kYes].tap()
			sleep(FrameworkConstants.defaultSleepDuration)
    }
  }

  // Validates the elements on the Drink Screen
  func validateDrinkScreenElements() {
    let percentSign = String(percentAmount.label)
    XCTAssertTrue(plusIconButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), " My Life main screen missing add button")
    XCTAssertTrue(minusIconButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "My Life main screen missing undo buton")
    XCTAssertTrue(percentSign.contains("%"), " My life main screen missing percentage display")
		validateNavigationBar()
  }
}
