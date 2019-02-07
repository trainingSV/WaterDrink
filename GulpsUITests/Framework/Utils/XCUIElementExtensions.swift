//
//  XCUIElementExtensions.swift
//  GulpsUITests
//
//  Created by George Galan on 14/01/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

class XCUIElementExtensions {
}

extension XCUIElementQuery {

  func labels() -> [String] {
    var labelValues = [String]()
    let elements = allElementsBoundByIndex
    for element in elements {
      labelValues.append(element.label)
    }
    return labelValues
  }

  func identifiers() -> [String] {
    var labelValues = [String]()
    let elements = allElementsBoundByIndex
    for element in elements {
      labelValues.append(element.identifier)
    }
    return labelValues
  }

  func values() -> [String] {
    var elementsValues = [String]()
    let elements = allElementsBoundByIndex
    for element in elements {
      if let value = element.value as? String , value != "" {
        elementsValues.append(value)
      }
    }
    return elementsValues
  }
}

extension XCUIElement {
  func tapW() {
    self.waitForExistence(timeout: FrameworkConstants.defaultTimeout)
    tap()
  }
}
