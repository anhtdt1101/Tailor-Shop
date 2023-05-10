//
//  AddNewClientVC.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import UIKit

class AddNewClientVC: BaseVC {
    @IBOutlet weak var tableView: STableView!
    @IBOutlet weak var addNewBtn: UIButton!
    
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
        var phone = DetailCellModel(title: "Số điện thoại", value: isEdit ? dataModel.phoneNumber : "", typeTextField: .phone, isValidate: true, errorTF: "Bố chưa nhập số điện thoại hoặc chưa nhập đủ 10 số",isEnable: !isEdit)
        phone.onTextF = { [weak self] text in
            self?.dataModel.phoneNumber = text
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
    
    func validateAddBtn(){
        if dataModel.fullName.notEmpty && dataModel.addDress.notEmpty && dataModel.phoneNumber.count == 10 && dataModel.phoneNumber.notEmpty {
            addNewBtn.blueBtnDisable(false)
        } else {
            addNewBtn.blueBtnDisable(true)
        }
    }
    
    @IBAction func didSelectAddNew(_ sender: Any) {
        if isEdit {
            DatabaseManager.update(dataModel, with: dataDic) { [weak self] isSuccess in
                if let wSelf = self{
                    if isSuccess {
                        UIAlertController.showConfirm(wSelf,"Cập nhật khách hàng thành công") { [weak self] in
                            self?.onBackUpdate?(self?.isAddNew ?? false)
                            self?.popViewController()
                        }
                    } else {
                        UIAlertController.showPopUp(wSelf,"Cập nhật lỗi rồi. Báo cho con nhá")
                    }
                }
            }
        } else  {
            UIAlertController.showConfirm(self,"Bố có muốn thêm ông này không") { [weak self] in
                if let dataModel = self?.dataModel{
                    DatabaseManager.insertClient(dataModel) { [weak self] isSucces in
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

private var window: UIWindow!
extension UIAlertController {
    
    private static var _aletrWindow: UIWindow?
    private static var aletrWindow: UIWindow {
        if let window = _aletrWindow {
            return window
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.windowLevel = UIWindow.Level.alert + 1
            window.backgroundColor = .clear
            _aletrWindow = window
            return window
        }
    }
    
    class func showPopUp(_ viewController: UIViewController,_ message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    class func showConfirm(_ viewController: UIViewController,_ message: String, callback: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            callback?()
        }))
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    func presentGlobally(animated: Bool, completion: (() -> Void)? = nil) {
        UIAlertController.aletrWindow.makeKeyAndVisible()
        UIAlertController.aletrWindow.isHidden = false
        UIAlertController.aletrWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIAlertController.aletrWindow.isHidden = true
    }
    
}

extension UIButton {
    func blueBtnDisable(_ isDisable: Bool) {
        self.backgroundColor = isDisable ? UIColor.cPlaceHolder : UIColor.cBlue
        self.isEnabled = !isDisable
    }
}
