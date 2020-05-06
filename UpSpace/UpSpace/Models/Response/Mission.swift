//
//  Mission.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 01/09/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Mission: Decodable {
  var id: Int?
  var name: String?
  var description: String?
  var launch: Int?
  var type: Int?
  var wikiURL: String?
  var infoURL: String?
  var changed: String?
  var infoURLs: [String]?
  var agencies: [Agency]?
  var typeName: String?
}
