//
//  AppConstants.swift
//  GulpsUITests
//
//  Created by George Galan on 05/02/2019.
//  Copyright © 2019 Fancy Pixel. All rights reserved.
//

import Foundation

struct AppConstants {

  static let kSmallGulp: Double = 0.2
  static let kLargeGulp: Double = 0.5
  static let kDailyGoal: Double =  2
  static let kSmallGulpPercentageAmount = Int((kSmallGulp * 100) / kDailyGoal)
  static let kLargeGulpPercentageAmount = Int((kLargeGulp * 100) / kDailyGoal)
}
