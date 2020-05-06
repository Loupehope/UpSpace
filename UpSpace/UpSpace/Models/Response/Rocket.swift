//
//  Rocket.swift
//  UpSpace
//
//  Created by Andrew on 06/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
  var agencies: [Agency]?
  var configuration: String?
  var familyname: String?
  var id: Int?
  var imageSizes: [Int]?
  var imageURL: String?
  var infoURLs: [String]?
  var name: String?
  var wikiURL: String?
}
