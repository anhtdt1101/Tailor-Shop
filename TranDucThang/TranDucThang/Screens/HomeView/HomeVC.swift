//
//  HomeVC.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak var tableView: STableView!
    @IBOutlet weak var searchTF: VVTextFieldFloat!
    
    var dataClient: [ClientModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupTextField()
    }

    func setupTextField(){
        searchTF.tf.onEdittingChanged = { [weak self] tf in
            if let text = tf.text, !text.isEmpty{
            let dataSearch = DatabaseManager.filterClient(text)
            self?.tableView.datas = dataSearch
            } else {
                self?.tableView.datas = self?.dataClient ?? []
            }
        }
    }
    
    override func setupNavbarView() {
        navBarView?.title = "Danh sách"
        navBarView?.isHiddenLeft = true
        navBarView?.right1Image = UIImage(systemName: "plus")?.withTintColor(UIColor.gray)
        navBarView?.onRight1Action = { [weak self] in
            let vc = AddNewClientVC()
            vc.onBackUpdate = { [weak self] isAddNew in
                if isAddNew{
                    self?.fetchData()
                }
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onUpdateAProfile(_ index: IndexPath){
        if let newData = DatabaseManager.getAClient(dataClient[index.row]){
            dataClient[index.row] = newData
            tableView.reloadRows(at: [index], with: .none)
        }
    }
    
    func fetchData(){
        dataClient = DatabaseManager.getClient()
        tableView.datas = dataClient
        tableView.onSelected = {[weak self] (item, index) in
            if let item = item as? ClientModel{
                let vc = ProfileClientVC()
                vc.client = item
                vc.onUpdate = { [weak self] isUpdate in
                    self?.onUpdateAProfile(index)
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
