//
//  HomeViewModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class HomeViewModel {
    var dataClient: [ClientModel] = []

    func fetchData() {
        dataClient.removeAll()
        let datas: [RClientModel] = RealmServices.shared.readData(RClientModel.self)
        datas.forEach { data in
            dataClient.append(data.toUIModel())
        }
    }
    
}
