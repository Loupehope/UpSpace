//
//  Launch.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Launch: Decodable, Equatable {
  var changed: String?
  var failreason: String?
  var hashtag: String?
  var holdreason: String?
  var id: Int?
  var infoURL: String?
  var infoURLs: [String]?
  var inhold: Int?
  var isoend: String?
  var isonet: String?
  var isostart: String?
  var location: Location?
  var lsp: Lsp?
  var missions: [Mission]?
  var name: String?
  var net: String?
  var netstamp: Int?
  var probability: Int?
  var rocket: Rocket?
  var status: Int?
  var tbddate: Int?
  var tbdtime: Int?
  var vidURL: String?
  var vidURLs: [String]?
  var westamp: Int?
  var windowend: String?
  var windowstart: String?
  var wsstamp: Int?
  
  var isFinished: Bool {
    start.timeIntervalSince1970 < Date().timeIntervalSince1970
  }
  
  var start: Date {
    guard let result = DateFormatterAPI().getDate(from: isostart ?? "") else {
      fatalError("Couldn't convert date from string")
    }
    return result
  }
  
  static func == (lhs: Launch, rhs: Launch) -> Bool {
      lhs.id == rhs.id
  }
  
  static func makeEmptyLaunch(with date: Date) -> Launch {
    let location = Location(countryCode: .empty, id: 0, pads: [])
    let dateString = DateFormatterAPI.makeiSOString(for: date)
    return Launch(changed: .empty,
                  failreason: .empty,
                  hashtag: .empty,
                  holdreason: .empty,
                  id: 0,
                  infoURL: .empty,
                  infoURLs: [String](),
                  inhold: 0,
                  isoend: .empty,
                  isonet: .empty,
                  isostart: dateString,
                  location: location,
                  lsp: Lsp(),
                  missions: [Mission](),
                  name: .empty,
                  net: .empty,
                  netstamp: 0,
                  probability: 0,
                  rocket: Rocket(),
                  status: 0,
                  tbddate: 0,
                  tbdtime: 0,
                  vidURL: .empty,
                  vidURLs: [String](),
                  westamp: 0,
                  windowend: .empty,
                  windowstart: .empty,
                  wsstamp: 0)
  }
}
