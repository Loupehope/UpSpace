//
//  Pad.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 28/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

public struct Pad: Decodable {
  var agencies: [Agency]?
  var id: Int?
  var infoURL: String?
  var latitude: Float?
  var longitude: Float?
  var mapURL: String?
  var name: String?
  var wikiURL: String?
}
