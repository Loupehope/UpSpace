//
//  NetworkService.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 22/08/2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation

protocol NetworkService {
    associatedtype Result
    
    func load(successCompletion: ((Result?) -> Void)?, errorCompletion: ((Error) -> Void)?)
}
