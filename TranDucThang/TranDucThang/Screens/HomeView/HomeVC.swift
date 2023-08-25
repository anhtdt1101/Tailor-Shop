//
//  HomeVC.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak var tableView: STableView!
    @IBOutlet weak var searchTF: TextField!
    
    var dataClient: [ClientModel] = []
    let emptyView = EmptyDataView(frame: CGRect(x: 0, y: 0, width: .kScreenWidth, height: 400))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupTextField()
    }
    
    func setupTextField(){
        searchTF.onEdittingChanged = { [weak self] tf in
            if let text = tf.text, !text.isEmpty{
                let dataSearch = DatabaseManager.filterClient(text)
                self?.isEmptyData(dataSearch)
            } else {
                self?.isEmptyData(self?.dataClient ?? [])
            }
        }
    }
    
    override func setupNavbarView() {
        navBarView?.title = "Danh sách khách hàng"
        navBarView?.isHiddenLeft = true
        navBarView?.right1Image = UIImage(systemName: "plus")
        navBarView?.onRight1Action = { [weak self] in
            self?.onAdd()
        }
    }
    
    func onUpdateAProfile(_ index: IndexPath){
        if let newData = DatabaseManager.getAClient(dataClient[index.row]){
            dataClient[index.row] = newData
            tableView.reloadRows(at: [index], with: .none)
        }
    }
    
    func onAdd(){
        let vc = AddNewClientVC()
        vc.onBackUpdate = { [weak self] isAddNew in
            if isAddNew{
                self?.fetchData()
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isEmptyData(_ data: [ClientModel]){
        emptyView.setupContent(title: "Không có dữ liệu")
        tableView.tableFooterView = data.isEmpty ? emptyView : UIView()
        tableView.datas = data
    }
    
    func fetchData(){
        dataClient = DatabaseManager.getClient()
        isEmptyData(dataClient)
        tableView.tableFooterView = dataClient.isEmpty ?  emptyView : UIView()
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
