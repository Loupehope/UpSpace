//
//  Location.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 27/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Location: Decodable {
  var countryCode: String?
  var id: Int?
  var infoURL: String?
  var name: String?
  var pads: [Pad]?
  var wikiURL: String?
}
