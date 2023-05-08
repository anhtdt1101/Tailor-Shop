//
//  ProfileClientVC.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import UIKit

class ProfileClientVC: BaseVC {
    @IBOutlet weak var tableView: VVTableView!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    var dataProduct: [ProductModel] = []
    var client: ClientModel?
    var isUpdate: Bool = false
    var onUpdate: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupTableView()
        tableView.onSelected = {[weak self] (item, index) in
            let vc = AddProductsVC()
            vc.isEdit = true
            vc.onUpdate = { [weak self] isUpdate in
                if isUpdate == true{
                    self?.isUpdate = isUpdate
                    self?.setupTableView()
                }
            }
            vc.dataProduct = item
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupTableView(){
        dataProduct.removeAll()
        if let client = client {
            self.client = DatabaseManager.getAClient(client)
            for i in client.listVest {
                dataProduct.append(i)
            }
            for i in client.listShirt {
                dataProduct.append(i)
            }
            for i in client.listPants {
                dataProduct.append(i)
            }
            dataProduct = dataProduct.sorted(by: { $0.status < $1.status })
            tableView.datas = dataProduct
        }
    }
    
    func setupData(){
        if let client = client {
            dataProduct.removeAll()
            nameLbl.text = client.fullName
            addressLbl.text = client.addDress
            phoneLbl.text = client.phoneNumber
            noteLbl.text = client.note
        }
    }
    
    override func setupNavbarView() {
        navBarView?.title = "Thông tin khách hàng"
        navBarView?.right1Image = UIImage(systemName: "plus")?.withTintColor(UIColor.gray)
        navBarView?.onRight1Action = { [weak self] in
            let vc = AddProductsVC()
            if let client = self?.client {
                vc.client = client
            }
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }
        navBarView?.onBackAction = { [weak self] in
            self?.onUpdate?(self?.isUpdate ?? false)
            self?.popViewController()
        }
    }
    
    func didUpdate(){
        if let client = client {
            self.client = DatabaseManager.getAClient(client)
            setupData()
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if let client = client {
            switch sender.selectedSegmentIndex {
            case 0:
                tableView.datas = client.listPants.sorted(by: { $0.status < $1.status })
            case 1:
                tableView.datas = client.listShirt.sorted(by: { $0.status < $1.status })
            case 2:
                tableView.datas = client.listVest.sorted(by: { $0.status < $1.status })
            default:
                tableView.datas = dataProduct
            }
        }
    }
    
    @IBAction func didSelectEdit(_ sender: Any) {
        let vc = AddNewClientVC()
        if let client = client {
            vc.dataModel = client
        }
        vc.onBackUpdate = { [weak self] isAddNew in
            if isAddNew{
                self?.isUpdate = isAddNew
                self?.didUpdate()
            }
        }
        vc.isEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didSelectRemove(_ sender: Any) {
        
    }
    
}
