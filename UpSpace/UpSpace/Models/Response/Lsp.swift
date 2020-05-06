//
//  Lsp.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Lsp: Decodable {
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
