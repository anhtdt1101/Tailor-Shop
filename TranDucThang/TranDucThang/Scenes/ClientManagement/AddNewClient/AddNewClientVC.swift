//
//  AddNewClientVC.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import UIKit

class AddNewClientVC: BaseVC {
    @IBOutlet private weak var tableView: STableView!
    @IBOutlet private weak var addNewBtn: UIButton!
    private var viewModel = AddNewClientViewModel()
    
    var dataModel = ClientModel()
    var isEdit: Bool = false
    var onBackUpdate: ((Bool) -> Void)?
    
    var isAddNew: Bool = false
    var dataDic: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addNewBtn.blueBtnDisable(true)
        addNewBtn.setTitle(isEdit ? "Cập nhật" : "Thêm mới", for: .normal)
    }
    
    override func setupNavbarView() {
        self.navBarView?.title = "Thêm khách hàng mới"
        self.navBarView?.onBackAction = { [weak self] in
            self?.onBackUpdate?(self?.isAddNew ?? false)
            self?.popViewController()
        }
    }
    
    func setupTableView(){
        var fullname = DetailCellModel(title: "Tên khách hàng", value: isEdit ? dataModel.fullName : "", typeTextField: .none,isValidate: true, errorTF: "Bố chưa nhập tên này")
        fullname.onTextF = { [weak self] text in
            if self?.isEdit == true {
                self?.dataDic["fullName"] = text
            } else {
                self?.dataModel.fullName = text
            }
            self?.validateAddBtn()
        }
        var address = DetailCellModel(title: "Địa chỉ", value: isEdit ? dataModel.addDress : "", typeTextField: .none, isValidate: true, errorTF: "Bố chưa nhập địa chỉ")
        address.onTextF = { [weak self] text in
            if self?.isEdit == true {
                self?.dataDic["addDress"] = text
            } else {
                self?.dataModel.addDress = text
            }
            self?.validateAddBtn()
        }
        var phone = DetailCellModel(title: "Số điện thoại", value: "", typeTextField: .phone, isValidate: true, errorTF: "Bố chưa nhập số điện thoại hoặc chưa nhập đủ 10 số",isEnable: !isEdit)
        phone.onTextF = { [weak self] text in
            self?.dataModel.phoneNumber.append(text)
            self?.validateAddBtn()
        }
        var note = DetailCellModel(title: "Ghi chú", value: isEdit ? dataModel.note : "Ghi chú", typeTextField: .none, isTextView: true)
        note.onTextView = { [weak self] text in
            if self?.isEdit == true {
                self?.dataDic["note"] = text
            } else {
                self?.dataModel.note = text
            }
            self?.validateAddBtn()
        }
        tableView.datas = [fullname,address,phone,note]
    }
    
    private func validateAddBtn(){
        if dataModel.fullName.notEmpty && dataModel.addDress.notEmpty {
            addNewBtn.blueBtnDisable(false)
        } else {
            addNewBtn.blueBtnDisable(true)
        }
    }
    
    @IBAction func didSelectAddNew(_ sender: Any) {
        if isEdit {
            //            DatabaseManager.update(dataModel, with: dataDic) { [weak self] isSuccess in
            //                if let wSelf = self{
            //                    if isSuccess {
            //                        UIAlertController.showConfirm(wSelf,"Cập nhật khách hàng thành công") { [weak self] in
            //                            self?.onBackUpdate?(self?.isAddNew ?? false)
            //                            self?.popViewController()
            //                        }
            //                    } else {
            //                        UIAlertController.showPopUp(wSelf,"Cập nhật lỗi rồi. Báo cho con nhá")
            //                    }
            //                }
            //            }
        } else {
            UIAlertController.showConfirm(self,"Bố có muốn thêm ông này không") { [weak self] in
                if let dataModel = self?.dataModel{
                    self?.viewModel.insertClient(dataModel) { [weak self] isSucces in
                        if let wSelf = self{
                            if !isSucces {
                                UIAlertController.showPopUp(wSelf,"Số điện thoại này đã cón rồi, bố không thêm được đâu")
                            }
                            self?.setupTableView()
                        }
                    }
                }
            }
        }
        isAddNew = true
    }
    
}
