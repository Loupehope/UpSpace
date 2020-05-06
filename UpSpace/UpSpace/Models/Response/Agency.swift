//
//  Agency.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Agency: Decodable {
  var abbrev: String?
  var changed: String?
  var countryCode: String?
  var id: Int?
  var infoURL: String?
  var infoURLs: [String]?
  var name: String?
  var type: Int?
  var wikiURL: String?
}
