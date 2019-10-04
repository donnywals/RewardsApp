//
//  RewardsService.swift
//  RewardsApp
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation

struct RewardsService {
  let network: Networking

  func fetchRewards(_ completion: @escaping (Result<RewardsResponse, Error>) -> Void) {
    network.fetch(URL(string: "https://reward-app.com/rewards")!) { data, urlResponse, error in
      let decoder = JSONDecoder()

      decoder.keyDecodingStrategy = .convertFromSnakeCase

      guard let data = data,
        let response = try? decoder.decode(RewardsResponse.self, from: data) else {
          // You should call the completion handler with a .failure result and an error
          return
      }

      completion(.success(response))
    }
  }
}
