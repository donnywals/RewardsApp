//
//  RewardsResponseFactory.swift
//  RewardsAppTests
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation
@testable import RewardsApp

class RewardsResponseFactory {
  static func createResponseWithRewards(_ types: [Reward.RewardType], points: Int?) -> RewardsResponse {
    let rewards = types.map { type in Reward(type: type) }
    return RewardsResponse(rewards: rewards, loyaltyPoints: points)
  }
}

extension RewardsResponse {
  var dataValue: Data {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return try! encoder.encode(self)
  }
}
