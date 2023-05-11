//
//  AddProductsVC.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 19/08/2022.
//

import UIKit

class AddProductsVC: BaseVC {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var tableView: STableView!
    @IBOutlet weak var typeProductBtn: UIButton!
    @IBOutlet weak var emptyLbl: UILabel!
    
    var indexSelected: Int = -1
    let dataArr: [TypeProduct] = [.shirt,.pants,.vest]
    var dataTBV: [DetailCellModel] = []
    
    var client: ClientModel?
    var dataProduct: Any?
    var onUpdate: ((Bool) -> Void)?
    var dataUpdate = ProductUpdate()
    
    var isEdit: Bool = false
    var isUpdate: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.datas = []
        if isEdit {
            var title = ""
            if let dataProduct = dataProduct as? ProductModel {
                title = dataProduct.status == "0" ? "Khách hàng đã lấy" : "Khách hàng Chưa lấy"
            }
            typeProductBtn.setTitle(isEdit ? title : "Chọn kiểu sản phầm", for: .normal)
            if let dataProduct = dataProduct as? ShirtModel{
                dataUpdate = dataProduct.toProductUpdate()
            } else if let dataProduct = dataProduct as? VestModel {
                dataUpdate = dataProduct.toProductUpdate()
            } else if let dataProduct = dataProduct as? PantsModel {
                dataUpdate = dataProduct.toProductUpdate()
            }
            didSelectType()
        }
    }
    
    override func setupNavbarView() {
        navBarView?.title = "\(isEdit ? "Sửa" : "Thêm") sản phẩm"
        navBarView?.onBackAction = { [weak self] in
            self?.onUpdate?(self?.isUpdate ?? false)
            self?.popViewController()
        }
    }
    
    func didSelectType(){
        var price = DetailCellModel(title: "Giá sản phẩm", value: dataUpdate.price, typeTextField: .amount, isValidate: true, errorTF: "Bố chưa nhập giá sản phẩm")
        price.onTextF = { [weak self] text in
            self?.validateAddBtn()
            self?.dataUpdate.price = text
        }
        var deposit = DetailCellModel(title: "Tiền đặt trước", value: dataUpdate.deposit, typeTextField: .amount, isValidate: true, errorTF: "")
        deposit.onTextF = { [weak self] text in
            self?.validateAddBtn()
            self?.dataUpdate.deposit = text
        }
        var pickUpDate = DetailCellModel(title: "Ngày Nhận Hàng", value: dataUpdate.pickUpDate, typeTextField: .none, isValidate: true, errorTF: "Bố Chưa nhập Ngày Nhận")
        pickUpDate.onTextF = { [weak self] text in
            self?.validateAddBtn()
            self?.dataUpdate.pickUpDate = text
        }
        var productColor = DetailCellModel(title: "Màu sản phẩm", value:  dataUpdate.productColor, typeTextField: .none, isValidate: true, errorTF: "Bố chưa nhập màu sản phầm")
        productColor.onTextF = { [weak self] text in
            self?.validateAddBtn()
            self?.dataUpdate.productColor = text
        }
        var total = DetailCellModel(title: "Tổng", value: dataUpdate.total, typeTextField: .phone, isValidate: true, errorTF: "")
        total.onTextF = { [weak self] text in
            self?.dataUpdate.total = text
        }
        var long = DetailCellModel(title: "Dài", value: dataUpdate.long, typeTextField: .phone, isValidate: true, errorTF: "")
        long.onTextF = { [weak self] text in
            self?.dataUpdate.long = text
        }
        var chest = DetailCellModel(title: "Ngực", value: dataUpdate.chest, typeTextField: .phone, isValidate: true, errorTF: "")
        chest.onTextF = { [weak self] text in
            self?.dataUpdate.chest = text
        }
        var bodyWaist = DetailCellModel(title: "Eo", value: dataUpdate.bodyWaist, typeTextField: .phone, isValidate: true, errorTF: "")
        bodyWaist.onTextF = { [weak self] text in
            self?.dataUpdate.bodyWaist = text
        }
        var butt = DetailCellModel(title: "Mông", value: dataUpdate.butt, typeTextField: .phone, isValidate: true, errorTF: "")
        butt.onTextF = { [weak self] text in
            self?.dataUpdate.butt = text
        }
        var arm = DetailCellModel(title: "Bắp tay", value: dataUpdate.arm, typeTextField: .phone, isValidate: true, errorTF: "")
        arm.onTextF = { [weak self] text in
            self?.dataUpdate.biceps = text
        }
        var withinArmpit = DetailCellModel(title: "Vòng nách", value: dataUpdate.withinArmpit, typeTextField: .phone, isValidate: true, errorTF: "")
        withinArmpit.onTextF = { [weak self] text in
            self?.dataUpdate.withinArmpit = text
        }
        var hand = DetailCellModel(title: "Tay", value: dataUpdate.hand, typeTextField: .phone, isValidate: true, errorTF: "")
        hand.onTextF = { [weak self] text in
            self?.dataUpdate.hand = text
        }
        var horizontalFront = DetailCellModel(title: "Ngang trước", value: dataUpdate.horizontalFront, typeTextField: .phone, isValidate: true, errorTF: "")
        horizontalFront.onTextF = { [weak self] text in
            self?.dataUpdate.horizontalFront = text
        }
        var necklace = DetailCellModel(title: "Vòng cổ", value: dataUpdate.necklace, typeTextField: .phone, isValidate: true, errorTF: "")
        necklace.onTextF = { [weak self] text in
            self?.dataUpdate.necklace = text
        }
        var horizontalBack = DetailCellModel(title: "Ngang sau", value: dataUpdate.horizontalBack, typeTextField: .phone, isValidate: true, errorTF: "")
        horizontalBack.onTextF = { [weak self] text in
            self?.dataUpdate.horizontalBack = text
        }
        var shirtLength = DetailCellModel(title: "Dài áo", value: dataUpdate.shirtLength, typeTextField: .phone, isValidate: true, errorTF: "")
        shirtLength.onTextF = { [weak self] text in
            self?.dataUpdate.shirtLength = text
        }
        var sleeveLenght = DetailCellModel(title: "Dài tay", value: dataUpdate.sleeveLenght, typeTextField: .phone, isValidate: true, errorTF: "")
        sleeveLenght.onTextF = { [weak self] text in
            self?.dataUpdate.sleeveLenght = text
        }
        var waist = DetailCellModel(title: "Bụng", value: dataUpdate.waist, typeTextField: .phone, isValidate: true, errorTF: "")
        waist.onTextF = { [weak self] text in
            self?.dataUpdate.waist = text
        }
        var trouserLeg = DetailCellModel(title: "Ống quần", value: dataUpdate.trouserLeg, typeTextField: .phone, isValidate: true, errorTF: "")
        trouserLeg.onTextF = { [weak self] text in
            self?.dataUpdate.trouserLeg = text
        }
        var thigh = DetailCellModel(title: "Đùi", value: dataUpdate.thigh, typeTextField: .phone, isValidate: true, errorTF: "")
        thigh.onTextF = { [weak self] text in
            self?.dataUpdate.thigh = text
        }
        var calf = DetailCellModel(title: "Bắp chân", value: dataUpdate.calf, typeTextField: .phone, isValidate: true, errorTF: "")
        calf.onTextF = { [weak self] text in
            self?.dataUpdate.calf = text
        }
        var crotch = DetailCellModel(title: "Vòng đũng", value: dataUpdate.crotch, typeTextField: .phone, isValidate: true, errorTF: "")
        crotch.onTextF = { [weak self] text in
            self?.dataUpdate.crotch = text
        }
        var shoulder = DetailCellModel(title: "Vai", value: dataUpdate.shoulder, typeTextField: .phone, isValidate: true, errorTF: "")
        shoulder.onTextF = { [weak self] text in
            self?.dataUpdate.shoulder = text
        }
        var note = DetailCellModel(title: "Ghi chú", value: dataUpdate.note, typeTextField: .content,isTextView: true)
        note.onTextView = { [weak self] text in
            self?.dataUpdate.note = text
        }
        if isEdit {
            if let dataProduct = self.dataProduct as? ProductModel{
                indexSelected = dataProduct.product
            }
        }
        if indexSelected != -1{
            tableView.cPaddingBottom?.constant = 64
            let type = dataArr[indexSelected]
            switch type {
            case .pants:
                dataTBV = [waist,butt,long,trouserLeg,thigh,calf,crotch]
            case .vest:
                dataTBV = [total,long,chest,bodyWaist,butt,arm,withinArmpit,hand,horizontalFront,horizontalBack,necklace]
            case .shirt:
                dataTBV = [shoulder,chest,shirtLength,sleeveLenght,necklace,bodyWaist,arm]
            }
            navBarView?.title = "\(isEdit ? "Sửa" : "Thêm") \(type.title)"
            dataTBV.append(contentsOf: [pickUpDate,productColor,price,deposit,note])
            emptyLbl.isHidden = true
            tableView.datas = dataTBV
        } else {
            emptyLbl.isHidden = false
            tableView.cPaddingBottom?.constant = 0
            tableView.datas = []
        }
    }
    
    func validateAddBtn(){
        if dataUpdate.pickUpDate.notEmpty && dataUpdate.price.notEmpty && dataUpdate.deposit.notEmpty && dataUpdate.productColor.notEmpty {
            saveBtn.blueBtnDisable(false)
        } else {
            saveBtn.blueBtnDisable(true)
        }
    }
    
    @IBAction func didSelectAdd(_ sender: Any) {
        if isEdit{
            UIAlertController.showConfirm(self,"Bố có muốn cập nhật sản phẩm này không") {
                let type = self.dataArr[self.indexSelected]
                switch type {
                case .pants:
                    if let dataProduct = self.dataProduct as? PantsModel{
                        DatabaseManager.update(dataProduct, with: self.dataUpdate.toDictPants()) { [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    }
                    break
                case .vest:
                    if let dataProduct = self.dataProduct as? VestModel{
                        DatabaseManager.update(dataProduct, with: self.dataUpdate.toDictVest()) { [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    }
                case .shirt:
                    if let dataProduct = self.dataProduct as? ShirtModel{
                        DatabaseManager.update(dataProduct, with: self.dataUpdate.toDictShirt()) { [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    }
                }
            }
        } else {
            UIAlertController.showConfirm(self,"Bố có muốn thêm sản phẩm này không") {
                if let client = self.client {
                    let type = self.dataArr[self.indexSelected]
                    switch type {
                    case .pants:
                        DatabaseManager.addPants(client, self.dataUpdate.toPants()) { [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    case .vest:
                        DatabaseManager.addVest(client, self.dataUpdate.toVest()){ [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    case .shirt:
                        DatabaseManager.addShirt(client, self.dataUpdate.toShirts()){ [weak self] isSuccess in
                            self?.didUpdate(isSuccess)
                        }
                    }
                }
            }
        }
    }
    
    func didUpdate(_ isSuccess: Bool){
        if isSuccess{
            UIAlertController.showConfirm(self,"Thành công") {
                self.isUpdate = true
                self.onUpdate?(self.isUpdate)
                self.popViewController()
            }
        } else {
            UIAlertController.showPopUp(self,"Lỗi rồi bố ơi, báo cho con nhé")
        }
    }
    
    @IBAction func didSelectType(_ sender: Any) {
//        if isEdit{
//            UIAlertController.showConfirm(self,"Bố có muốn chuyển trạng thái không") {
//                if let dataProduct = self.dataProduct as? ProductModel {
//                    DatabaseManager.updateStatus(dataProduct) { [weak self] isSuccess in
//                        let title = dataProduct.status == "0" ? "Khách hàng đã lấy" : "Khách hàng Chưa lấy"
//                        self?.typeProductBtn.setTitle(title, for: .normal)
//                        self?.isUpdate = true
//                        self?.onUpdate?(self?.isUpdate ?? false)
//                    }
//                }
//            }
//            
//        } else {
//            let didSelectRow = { [weak self] (service: TypeProduct, index: IndexPath, controller: UIViewController) in
//                controller.dismiss(animated: true)
//                guard let wSelf = self else { return }
//                wSelf.indexSelected = index.row
//                wSelf.didSelectType()
//            }
//            let configure = {[weak self] (cell: TypeClothesCell, item: TypeProduct, index: Int, viewcontroller: UIViewController) in
//                cell.serviceLbl.text = item.title
//                cell.isChecked = (self?.indexSelected == index)
//            }
//            let billStatis = VVGenericTableView(items: dataArr, title: "Kiểu sản phẩm", configure: configure)
//            billStatis.maximumSearchLenght = 20
//            billStatis.canUpdateLayoutWhenSearch = false
//            billStatis.didSelectRow = didSelectRow
//            self.presentPanModal(billStatis)
//        }
    }
}
