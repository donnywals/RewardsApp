//
//  RewardsResponse.swift
//  RewardsApp
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation

struct RewardsResponse: Codable {
  let rewards: [Reward]
  let loyaltyPoints: Int?
}

struct Reward: Codable {
  enum RewardType: String, Codable {
    case jackpot, regular, small
  }

  let type: RewardType
}
