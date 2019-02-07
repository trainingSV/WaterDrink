//
//  GulpsUITests.swift
//  GulpsUITests
//
//  Created by George Galan on 10/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import XCTest

class TestBase: XCTestCase {

  let app = XCUIApplication()
  let screens = Screens()
  let springBoardApp = XCUIApplication(bundleIdentifier:"com.apple.springboard")
	let utiliy = GlobalUtilities()

  override func setUp() {
		deleteApp()
    continueAfterFailure = false
    app.launch()
  }

  func setUpWithOnBoarding(_ onboarding:Bool) {
    if onboarding == true {
			deleteApp()
      app.launchArguments = ["-ONBOARDING_SHOWN", "NO"]
      continueAfterFailure = false
      app.launch()
    }
    else {
			deleteApp()
      app.launchArguments = ["-ONBOARDING_SHOWN", "YES"]
      continueAfterFailure = false
      app.launch()
    }
  }

  override func tearDown() {
      app.terminate()
  }

  // Deletes app if present on Springboard
  func deleteApp() {
    let icon = springBoardApp.icons[AccessabilityLabels.kGulps]
    let iconDeleteButton = springBoardApp.alerts.buttons[AccessabilityLabels.kDelete]
    if icon.waitForExistence(timeout: FrameworkConstants.defaultTimeout) {
			icon.press(forDuration: FrameworkConstants.defaultPressDuration)
      icon.buttons.firstMatch.tap()
      iconDeleteButton.tapW()
    }
  }
  // Performs onboarding with default values if the first screen it sees is the Welcome Screen and checks landing screen in both cases
  func onboardUserIfFreshLaunch() {
    if app.staticTexts[AccessabilityLabels.kHiThere].waitForExistence(timeout: FrameworkConstants.defaultTimeout) == true {
    	performOnboardingWithDefaultValues()
    }
    else {
    	screens.drink.validateScreen()
    }
  }
  // Performs onboarding with default values, handles notification and checks landing screen
  func performOnboardingWithDefaultValues() {
    let nextButton = app.buttons[AccessabilityLabels.kNextIcon]
    let previousButton = app.buttons[AccessabilityLabels.kPrevIcon]
    let doneButton = app.buttons[AccessabilityLabels.kBlueCheckIcon]
    let welcomeTitle = app.staticTexts[AccessabilityLabels.kHiThere]
    let welcomeDescription = app.staticTexts[AccessabilityLabels.kWelcomeScreenDescription]
    let unitOfMeasureStepDescription = app.staticTexts[AccessabilityLabels.kUnitOfMeasureStepDescription]
    let chooseGulpSizeStepDescription = app.staticTexts.element(matching: AccessabilityLabels.kChooseGulpSizeStepDescription)
    let litersOption = app.staticTexts[AccessabilityLabels.kLiters]
    let ouncesOption = app.staticTexts[AccessabilityLabels.kOunces]
    let smallGulpOption = app.staticTexts[AccessabilityLabels.kSmallLowerCaseGulp]
    let bigGulpOption = app.staticTexts[AccessabilityLabels.kBigLowerCaseGulp]
    let dailyGoalStepDescription = app.staticTexts[AccessabilityLabels.kDailyGoalStepDescription]
    let dailyGoalOption = app.staticTexts[AccessabilityLabels.kDailyGoal]
    let setReminderStepDescription = app.staticTexts[AccessabilityLabels.kSetReminderStepDescription]
    let fromOption = app.staticTexts[AccessabilityLabels.kFrom]
    let toOption = app.staticTexts[AccessabilityLabels.kTo]
    let everyOption = app.staticTexts[AccessabilityLabels.kEvery]

    // Welcome Screen step
    XCTAssert(welcomeTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Welcome Title missing")
    XCTAssert(welcomeDescription.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Welcome Description missing")
    XCTAssert(nextButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Next Button not displayed")
    nextButton.tap()

    // Choose Unit of Measure step
    XCTAssert(unitOfMeasureStepDescription.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Step description missing")
    XCTAssert(litersOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout),"Liters option not displayed")
    XCTAssert(ouncesOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Ounces option not displayed")
    XCTAssert(previousButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Previous Button not displayed")
    XCTAssert(nextButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Next Button not displayed")
    nextButton.tap()

    // Choose Gulp Sizes step
    XCTAssert(chooseGulpSizeStepDescription.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Choose Gulp Size step description not displayed")
    XCTAssert(smallGulpOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Small Gulp Option not displayed")
    XCTAssert(bigGulpOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Big Gulp Option not displayed")
    XCTAssert(previousButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Previous Button not displayed")
    XCTAssert(nextButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Next Button not displayed")
    nextButton.tap()

    // Choose your Daily Goal step
    XCTAssert(dailyGoalStepDescription.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Step description missing")
    XCTAssert(dailyGoalOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Daily Goal Option not displayed")
    XCTAssert(previousButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Previous Button not displayed")
    XCTAssert(nextButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Next Button not displayed")
    nextButton.tap()

    //Set Reminder step
    XCTAssert(setReminderStepDescription.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Step description missing")
    XCTAssert(fromOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "From Option not displayed")
    XCTAssert(toOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "To Option not displayed")
    XCTAssert(everyOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Every Option not displayed")
    XCTAssert(previousButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Previous Button not displayed")
    XCTAssert(doneButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Done Button not displayed")
    doneButton.tap()

    //Handle Notifications Alert
    handleAlert(description: AccessabilityLabels.kNotificationsAlertDescription, button: AccessabilityLabels.kAllow)
  }

  func handleAlert(description:String, button: String) {
    addUIInterruptionMonitor(withDescription: description) { (alert) -> Bool in
      alert.buttons[button].tap()
      return true
    }
  }
}

