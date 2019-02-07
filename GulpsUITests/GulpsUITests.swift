//
//  GulpsUITests.swift
//  GulpsUITests
//
//  Created by George Galan on 16/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import XCTest

class GulpsUITests: TestBase {

  override func setUp() {
    if (self.name == "-[GulpsUITests testOnboardingWithDefaultParameters]") {
      setUpWithOnBoarding(true)
    }
    else {
      setUpWithOnBoarding(false)
    }
  }

  func testOnboardingWithDefaultParameters() {
    // Perform onboarding with default values (validating each step)
    performOnboardingWithDefaultValues()
		// Check if we are left on correct screen with all elements
		screens.drink.validateDrinkScreenElements()
    }

  func testAddGulpsFromDrinkScreen() {
		// Validate Drink Screen is displayed with all elements
		screens.drink.validateDrinkScreenElements()

    // Add a small gulp in the Drink Screen (and get the percent displayed before adding)
		let initialPercentBeforeSmallGulpAdded = screens.drink.getInitialPercent()
    screens.drink.addSmallGulp()

		// Check correct percentage value displayed and plus sign appears again
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeSmallGulpAdded, adding: AppConstants.kSmallGulpPercentageAmount)
		screens.drink.validatePlusSymbolDisplayed()

    // Add a big gulp in the Drink Screen (and get the percent displayed before adding)
		let initialPercentBeforeBigGulpAdded = screens.drink.getInitialPercent()
    screens.drink.addBigGulp()

		// Check correct percentage value displayed and plus sign appears again
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeBigGulpAdded, adding: AppConstants.kLargeGulpPercentageAmount)
		screens.drink.validatePlusSymbolDisplayed()
  }

  func testMyProgressDailyGoalCheck() {
		// Validate Drink Screen is displayed with all elements
		screens.drink.validateDrinkScreenElements()
    
		// Add a small gulp in the Drink Screen (and get the percent displayed before adding)
		let initialPercentBeforeSmallGulpAdded = screens.drink.getInitialPercent()
		screens.drink.addSmallGulp()

		// Check correct percentage value displayed and plus sign appears again
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeSmallGulpAdded, adding: AppConstants.kSmallGulpPercentageAmount)
		screens.drink.validatePlusSymbolDisplayed()

    // Get the percentage displayed in the Drink Screen after adding
    let drinkScreenPercentageValue = screens.drink.getInitialPercent()

		// Go to My Progress Screen and validate elements
    screens.drink.goToScreen(screens.myProgress)
		screens.myProgress.validateMyProgressScreenElements()

		//Check that the percentage value that was displayed in the Drink screen is equal to the percentage value displayed in My Progress Screen
		utiliy.comparePercentageAmounts(compare: drinkScreenPercentageValue, with: screens.myProgress.getCurrentPercent())

    // Add a small gulp in the My Progress Screen (and get the percent displayed before adding)
		let initialPercentBeforeLittleGulpAdded = screens.myProgress.getCurrentPercent()
    screens.myProgress.addLittleGulp()

		// Check correct percentage value is displayed
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeLittleGulpAdded, adding: AppConstants.kSmallGulpPercentageAmount)

    // Add a big gulp in the My Progress Screen (and get the percent displayed before adding)
		let initialPercentBeforeLargeGulpAdded = screens.myProgress.getCurrentPercent()
    screens.myProgress.addBigGulp()

		// Check correct percentage value is displayed
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeLargeGulpAdded, adding: AppConstants.kLargeGulpPercentageAmount)

    // Add gulps till progress percentage reaches/passes 100
    screens.myProgress.addGulpsTillDailyGoalReached()

		// Validate "Goal Met" text appears
		screens.myProgress.validateGoalMetDisplayed()
	}

  func testSwitchingMeasureUnits() {
		// Validate Drink Screen is displayed with all elements
		screens.drink.validateDrinkScreenElements()

    // Go to Preferences Screen and validate elements on screen
    screens.drink.goToScreen(screens.preferences)
		screens.preferences.validatePreferencesScreenElements()

		//Change unit of measure to Ounces
    screens.preferences.modifyUnitofMeasure(to: .Ounces)

		// Validate the Portions have change the measure unit to "Oz"
		screens.preferences.checkMeasurementUnitOfPortions(unit: AccessabilityLabels.kOz)

		//Change unit of measure to Liters
		screens.preferences.modifyUnitofMeasure(to: .Liters)

		// Validate the Portions have change the measure unit to "L"
		screens.preferences.checkMeasurementUnitOfPortions(unit: AccessabilityLabels.kL)
  }

  func testDrinkScreenUndoButton() {
		// Validate Drink Screen is displayed with all elements
		screens.drink.validateDrinkScreenElements()

		// Add a small gulp in the Drink Screen (and get the percent displayed before adding)
		let initialPercentBeforeSmallGulpAdded = screens.drink.getInitialPercent()
		screens.drink.addSmallGulp()

		// Check correct percentage value displayed and plus sign appears again
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeSmallGulpAdded, adding: AppConstants.kSmallGulpPercentageAmount)
		screens.drink.validatePlusSymbolDisplayed()

    // Undo last gulp
    screens.drink.undoLastGulpAdded()

		// Validate correct amount undone
		screens.drink.validateCorrectAmountUndone()

		// Add a big gulp in the Drink Screen (and get the percent displayed before adding)
		let initialPercentBeforeBigGulpAdded = screens.drink.getInitialPercent()
		screens.drink.addBigGulp()

		// Check correct percentage value displayed and plus sign appears again
		utiliy.validateCorrectPercentageAmountAdded(from: initialPercentBeforeBigGulpAdded, adding: AppConstants.kLargeGulpPercentageAmount)
		screens.drink.validatePlusSymbolDisplayed()

		// Get percentage after Big Gulp added
		let percentageAfterBigGulpAdded = screens.drink.getInitialPercent()

    // Attempt to undo last gulp but cancel
    screens.drink.tapUndoButtonAndCancel()

		// Validate the percentage added was not undone
		utiliy.validateACorrectPercentageIsDisplayed(percentage: percentageAfterBigGulpAdded)
  }
}
