//
//  RewardsServiceTests.swift
//  RewardsAppTests
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation
import XCTest
@testable import RewardsApp

class RewardsServiceTests: XCTestCase {
  var service: RewardsService!
  let mockNetwork = MockNetworking()

  override func setUp() {
    self.service = RewardsService(network: mockNetwork)
  }

  private func expectSuccessForResponse(_ response: RewardsResponse, andAssert assert: @escaping (RewardsResponse) -> Void) {

    let expect = expectation(description: "Expected test to complete")

    mockNetwork.responseData = response.dataValue

    service.fetchRewards { result in
      guard case .success(let response) = result else {
        XCTFail("Expected the rewards to be fetched")
        return
      }

      assert(response)
      expect.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testRewardServiceCanReceiveEmptyRewardsWithNoPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([], points: nil)

    expectSuccessForResponse(response) { result in
      XCTAssertTrue(result.rewards.isEmpty)
      XCTAssertNil(result.loyaltyPoints)
    }
  }

  func testRewardsServiceCanReceiveJackpotWithNoPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([.jackpot], points: nil)

    expectSuccessForResponse(response) { result in
      XCTAssertNil(result.loyaltyPoints)
      XCTAssertEqual(Reward.RewardType.jackpot, result.rewards[0].type)
    }
  }

  func testRewardsServiceCanReceiveRegularPriceWithPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([.regular], points: 50)

    expectSuccessForResponse(response) { result in
      XCTAssertEqual(50, result.loyaltyPoints)
      XCTAssertEqual(Reward.RewardType.regular, result.rewards[0].type)
    }
  }


  func testRewardsServiceCanReceiveNoRewardsWithPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([], points: 100)

    expectSuccessForResponse(response) { result in
      XCTAssertEqual(100, result.loyaltyPoints)
      XCTAssertTrue(result.rewards.isEmpty)
    }
  }

  func testRewardsServiceCanReceiveSmallAnRegularPriceWithPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([.small, .regular], points: 70)

    expectSuccessForResponse(response) { result in
      XCTAssertEqual(70, result.loyaltyPoints)
      XCTAssertEqual(2, result.rewards.count)
    }
  }

  func testRewardsServiceCanReceiveSmallAndRegularPricesWithNoPoints() {
    let response = RewardsResponseFactory.createResponseWithRewards([.small, .regular], points: nil)

    expectSuccessForResponse(response) { result in
      XCTAssertNil(result.loyaltyPoints)
      XCTAssertEqual(2, result.rewards.count)
    }
  }
}
