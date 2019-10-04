//
//  MockNetworking.swift
//  RewardsAppTests
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation
@testable import RewardsApp

class MockNetworking: Networking {
  var responseData: Data?
  var error: Error?

  func fetch(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    completion(responseData, nil , error)
  }
}
