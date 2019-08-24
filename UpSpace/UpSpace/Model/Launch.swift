//
//  Launch.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

struct Launch: Decodable, Equatable {
    let id: Int
    let name: String
    let windowstart: String
    var start: String {
        let formatter = DateFormatterAPI()
        let date = formatter.transformComing(dateString: windowstart)
        guard let finalDate = date else {
            fatalError("Couldn't convert start's date")
        }
        return formatter.convert(date: finalDate)
    }
}
