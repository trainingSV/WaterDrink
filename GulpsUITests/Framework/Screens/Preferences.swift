//
//  Preferences.swift
//  GulpsUITests
//
//  Created by George Galan on 14/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

class Preferences: ScreenBase {

  lazy var unitOfMesureOption = app.staticTexts[AccessabilityLabels.kUnitOfMesure]
  lazy var smallGulpOptionTitle = app.staticTexts[AccessabilityLabels.kSmallLowerCaseGulp]
  lazy var bigGulpOptionTitle = app.staticTexts[AccessabilityLabels.kBigLowerCaseGulp]
  lazy var dailyGoalOptionTitle = app.staticTexts[AccessabilityLabels.kDailyGoal]
  lazy var smallGulpOptionQuery = tablesQuery.cells.containing(.staticText, identifier:AccessabilityLabels.kSmallLowerCaseGulp)
  lazy var bigGulpOptionQuery = tablesQuery.cells.containing(.staticText, identifier:AccessabilityLabels.kBigLowerCaseGulp)
  lazy var dailyGoalOptionQuery = tablesQuery.cells.containing(.staticText, identifier:AccessabilityLabels.kDailyGoal)
  lazy var fromOption = app.staticTexts[AccessabilityLabels.kFrom]
  lazy var toOption = app.staticTexts[AccessabilityLabels.kTo]
  lazy var everyOption = app.staticTexts[AccessabilityLabels.kEvery]
  lazy var exportDataToHealthText = app.staticTexts[AccessabilityLabels.kExportDataToHeatlh]
  lazy var exportDataToHealthToggle = tablesQuery.switches[AccessabilityLabels.kExportDataToHeatlh]
  lazy var remindToDrinkText = app.staticTexts[AccessabilityLabels.kRemindMeToDrink]
  lazy var remindToDrinkToggle = tablesQuery.switches[AccessabilityLabels.kRemindMeToDrink]
  lazy var settingsSubTitle = tablesQuery.otherElements[AccessabilityLabels.kUpperCaseSettings]
  lazy var portionsSubTitle = tablesQuery.otherElements[AccessabilityLabels.kUpperCasePortions]
  lazy var notificationsSubTitle = tablesQuery.otherElements[AccessabilityLabels.kUpperCaseNotifications]
  lazy var appleHealthSubTitle = tablesQuery.otherElements[AccessabilityLabels.kUpperCaseAppleHealth]
  lazy var selectUnitOfMeasureMenuHeader = tablesQuery.staticTexts[AccessabilityLabels.kUnitofMeasureWithColon]
  lazy var ouncesMenuOption = tablesQuery.containing(.staticText, identifier:AccessabilityLabels.kUnitofMeasureWithColon).staticTexts[AccessabilityLabels.kOunces]
  lazy var litersMenuOption = tablesQuery.containing(.staticText, identifier:AccessabilityLabels.kUnitofMeasureWithColon).staticTexts[AccessabilityLabels.kLiters]
  lazy var cancelButton = app.buttons[AccessabilityLabels.kCancel]
  lazy var portions = [smallGulpOptionTitle:smallGulpOptionQuery, bigGulpOptionTitle:bigGulpOptionQuery, dailyGoalOptionTitle:dailyGoalOptionQuery]

  override func goToScreen(_ screen: ScreenBase) {
    switch screen {
    case is MyProgress:
      myProgressTab.tap()
    case is Drink:
      drinkTab.tap()
    default:
      break
    }
    screen.validateScreen()
  }

  override func validateScreen() {
		XCTAssertTrue(portionsSubTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Portions' subttile not present on screen")
  }

  // Modifies the unit of measure preference option to the chosen unit and checks if the update is reflected for small gulp, big gulp and daily goal preference options
  func modifyUnitofMeasure(to unit:unitOfMeasure) {
    switch (unit) {
    case .Ounces:
      selectUnitOfMesureOption(unit: .Ounces)
    case .Liters:
      selectUnitOfMesureOption(unit: .Liters)
    }
  }

  // Validates if the measurement units of the Portions has been changed accordingly
  func checkMeasurementUnitOfPortions(unit:String) {
    for (portionName, portionMeasureUnit) in portions {
      XCTAssertTrue(portionMeasureUnit.staticTexts[unit].waitForExistence(timeout: FrameworkConstants.defaultTimeout), "\(portionName) measurement was not changed to \(unit)")
    }
  }
  // Selects a unit of measure from theUnit Of Mesure menu
  func selectUnitOfMesureOption(unit:unitOfMeasure) {
    switch (unit) {
    case .Ounces:
      unitOfMesureOption.tap()
			validateUnitOfMeasureMenu()
      ouncesMenuOption.tap()
    case .Liters:
      unitOfMesureOption.tap()
			validateUnitOfMeasureMenu()
      litersMenuOption.tap()
    }
  }

	func validateUnitOfMeasureMenu() {
		XCTAssertTrue(selectUnitOfMeasureMenuHeader.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "User was not redirected to select measure unit menu")
		XCTAssertTrue(cancelButton.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "There is no Cancel button")
	}

  // Validates the elements on the Preference Screen
  func validatePreferencesScreenElements() {
    XCTAssertTrue(unitOfMesureOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Unit of mesure' option not present on screen")
    XCTAssertTrue(smallGulpOptionTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Small gulp' option not present on screen")
    XCTAssertTrue(bigGulpOptionTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Big gulp' optionnot present on screen")
    XCTAssertTrue(dailyGoalOptionTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Daily goal' option not present on screen")
    XCTAssertTrue(fromOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'From' option not present on screen")
    XCTAssertTrue(toOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'To' option not present on screen")
    XCTAssertTrue(everyOption.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Every' option not present on screen")
    XCTAssertTrue(exportDataToHealthText.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Export data to Heatlh' not present on screen")
    XCTAssertTrue(exportDataToHealthToggle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Export data to Health' Toggle not present on screen")
    XCTAssertTrue(remindToDrinkText.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Remind me to drink' text not present on screen")
    XCTAssertTrue(remindToDrinkToggle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Remind me to drink' toggle not present on screen")
    XCTAssertTrue(settingsSubTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Settings' subtitle not present on screen")
    XCTAssertTrue(portionsSubTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Portions' subttile not present on screen")
    XCTAssertTrue(notificationsSubTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Notifications' not present on screen")
    XCTAssertTrue(appleHealthSubTitle.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "'Apple Health' subtitle not present on screen")
		validateNavigationBar()
  }

  enum unitOfMeasure {
    case Liters
    case Ounces
  }
}
