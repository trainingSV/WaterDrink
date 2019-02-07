//
//  ScreenBase.swift
//  GulpsUITests
//
//  Created by George Galan on 11/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import XCTest

class ScreenBase {

  lazy var app = XCUIApplication()
  lazy var tablesQuery = app.tables
  lazy var tabBarsQuery = app.tabBars

  lazy var drinkTab = tabBarsQuery.buttons[AccessabilityLabels.kDrink]
  lazy var myProgressTab = tabBarsQuery.buttons[AccessabilityLabels.kMyProgress]
  lazy var preferencesTab = tabBarsQuery.buttons[AccessabilityLabels.kPreferences]

  // Validates the three tabs are displayed in the navbar (which is common for all screens)
  func validateNavigationBar () {
		XCTAssert(drinkTab.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Drink Tab not displayed")
		XCTAssert(myProgressTab.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "My Progress Tab not displayed")
		XCTAssert(preferencesTab.waitForExistence(timeout: FrameworkConstants.defaultTimeout), "Preferences Tab not displayed")
  }

  func validateScreen() {}

  func goToScreen(_ screen: ScreenBase) {}
}
