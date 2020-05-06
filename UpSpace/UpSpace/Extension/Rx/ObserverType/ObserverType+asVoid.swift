//
//  Observable+asVoid.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 06.05.2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

import RxSwift

extension ObserverType {
    func asVoid() -> Observable<Void> {
        .just(())
    }
}
