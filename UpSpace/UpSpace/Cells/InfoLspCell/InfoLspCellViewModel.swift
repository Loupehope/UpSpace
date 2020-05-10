//
//  InfoLspCellViewModel.swift
//  UpSpace
//
//  Created by Andrew on 09/05/2020.
//  Copyright © 2020 Vlad Suhomlinov. All rights reserved.
//

final class InfoLspCellViewModel: ViewModel {
    let lsp: Lsp
    
    init(lsp: Lsp) {
        self.lsp = lsp
    }
}
