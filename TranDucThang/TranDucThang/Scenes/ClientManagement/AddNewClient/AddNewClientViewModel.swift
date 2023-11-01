//
//  AddNewClientViewModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class AddNewClientViewModel {
    
    func insertClient(_ data: ClientModel, callback: ((Bool) -> Void)? = nil) {
        RealmServices.shared.create(RClientModel(uiModel: data)) { isSuccess in
            callback?(isSuccess)
        }
    }
    
}
