//
//  Networking.swift
//  RewardsApp
//
//  Created by Wals, Donny on 04/10/2019.
//  Copyright © 2019 Wals, Donny. All rights reserved.
//

import Foundation

protocol Networking {
  func fetch(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: Networking {
  func fetch(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    self.dataTask(with: url) { data, response, error in
      completion(data, response, error)
    }.resume()
  }
}
