//
//  GenericTableViewController.swift
//  F5SmartAccount
//
//  Created by Anh Nguyen on 3/19/21.
//  Copyright © 2021 Anh Nguyen. All rights reserved.
//

import UIKit

class VVGenericTableView<T, Cell: VVTableViewCell>: BaseVC, UITextFieldDelegate {
    /**Flag mark is Showing Child items*/
    private var isChildShowing = false
    @IBOutlet var vHeader:UIView!
    @IBOutlet weak var subTitleLabel: VVLabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var titleLabel: VVLabel!
    @IBOutlet weak var tableView: VVTableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: VVTextField!
    @IBOutlet weak var noDataLabel: VVLabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var isShortFormEnabled = true
    var isShowDragIndicator = true // show DragIndication on top
    
    private var items: [T] = [] // search data
    private var objects: [T] = [] // origin data
    private var subObjects: [T]? // childs items
    var configure: ((Cell, T, Int, UIViewController) -> Void)?
    var filterHandler: (([T], String) -> [T])?
    var selectedItemBlock: ((T, Int) -> Bool)? // đánh dấu check mark
    var didSelectRow: ((T, IndexPath, UIViewController) -> Void)?
    var onDismiss:VVVoidBlock?
    var titleString: String = ""
    var subTitle: String?
    var shouldDismissOnBackgroundTouch: Bool = false
    var noDataString: String?
    var maximumSearchLenght: Int?
    var canUpdateLayoutWhenSearch: Bool = false {
        didSet {
            if canUpdateLayoutWhenSearch {
            } else {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
    private var canSearch: Bool = false {
        didSet {
            var heightHeader: CGFloat = 0
            if canSearch {
                heightHeader = 35
            } else {
                heightHeader = 0
            }
            searchView.cHeight?.constant = heightHeader
            searchView.isHidden = !canSearch
        }
    }
    
    var showBack: Bool = false {
        didSet {
            if showBack {
                backButton.isHidden = false
                closeButton.isHidden = true
            } else {
                backButton.isHidden = true
                closeButton.isHidden = false
            }
        }
    }
    
    // MARK: initial
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items: [T], title: String, subTitle: String? = nil, configure: ((Cell, T, Int, UIViewController) -> Void)?, cell:VVTableViewCell.Type? = nil) {
        self.items = items
        self.objects = items
        self.titleString = title
        if let configure = configure {
            self.configure = configure
        }
        self.subTitle = subTitle
        super.init(nibName: "VVGenericTableView", bundle: nil)
        Bundle.main.loadNibNamed(String(describing: "VVGenericTableView"), owner: self, options: nil)
        titleLabel.text = titleString
        subTitleLabel.text = subTitle
        searchTextField.delegate = self
        if let cell = cell {
            tableView.cellClass = cell
        }else {
            tableView.cellFactory = { (data, idx) in
                return Cell.self
            }
        }
        configTableView()
    }
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.maxLength = 20
        searchTextField.validChars = "^[A-Za-z0-9-\\\\/ ]{0,}$"
    }
    
    deinit {
        onDismiss?()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configTableView() {
        tableView.configurationCell = {[weak self] (cell, item, index) in
            guard let wSelf = self else { return }
            if let cell = cell as? Cell, let item = item as? T {
                wSelf.configure?(cell, item, index.row, wSelf)
            }
        }
        tableView.onSelected = {[weak self] (item, index) in
            guard let wSelf = self else { return }
            if let item = item as? T {
                wSelf.onSelect(item, index)
            }
        }
        tableDrawDatas(items)
    }
    func dismis() {
        self.dismiss(animated: true, completion: nil)
    }
    func tableDrawDatas(_ datas:[Any]) {
        tableView.datas = datas
        canSearch = datas.count > 10
    }
    
    func onSelect(_ item:T,_ idxPath:IndexPath) {
        didSelectRow?(item, idxPath, self)
        self.onDismiss = nil
        dismis()
    }
    
    @IBAction func didSelectClose(_ sender: Any) {
        dismis()
    }
    
    @IBAction func didSelectBack(_ sender: Any) {
        if isChildShowing {
            showBack = false
            tableView.datas = items
            subObjects = nil
            isChildShowing = false
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func updateSearchResultWithSearcBar(_ textField: UITextField) {
//        if let filter = self.filterHandler {
//            let alls = subObjects ?? self.objects
//            if let text = searchTextField.text, text.count > 0 {
//                self.items = filter(alls, text)
//            } else {
//                self.items = alls
//            }
//            let txtSearch = searchTextField.text
//            self.items.forEach {
//                if var o = $0 as? TitleValueProtocol {
//                    o.textSearch = txtSearch
//                }
//            }
//            reloadData()
//        }
    }
    
    
    @objc func reloadData(_ notification: Notification) {
        if let idx = notification.object as? Int {
            objects.remove(at: idx)
            items.remove(at: idx)
            reloadData()
        }
    }
    
    private func reloadData() {
        if (self.items.count > 0) {
            self.noDataView.isHidden = true
        } else {
            self.noDataView.isHidden = false
            if objects.count > 0 { //search
                noDataLabel.text = "notFound"
            } else { //
                noDataLabel.text = noDataString
            }
        }
        tableView.datas = items
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(updateSearchResultWithSearcBar(_:)), object: nil)
        perform(#selector(updateSearchResultWithSearcBar(_:)), with: searchTextField, afterDelay: 0.5)
        if textField == searchTextField {
            searchTextField.text = textField.text?.removeUTF8()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let count = text.count + (string.count - range.length)
            if textField == searchTextField {
                if count <= 50 {
                    return true
                } else {
                    return false
                }
            }
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(updateSearchResultWithSearcBar(_:)), object: nil)
            perform(#selector(updateSearchResultWithSearcBar(_:)), with: searchTextField, afterDelay: 0.5)
        }
        return true
    }
    
    var allowsDragToDismiss: Bool = true
    var allowsTapToDismiss: Bool = true
}

// MARK: PanModalPresentable
extension VVGenericTableView: PanModalPresentable {
    var cornerRadius: CGFloat {
        return 20
    }

    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var shortFormHeight: PanModalHeight {
        let heightView = tableView.contentSize.height + vHeader.height
        var shortHeight =  (heightView < .kScreenHeight - 10) ? heightView : (.kScreenHeight - 10)
        if shortHeight < .kScreenHeight/3 {
            shortHeight = .kScreenHeight/3
        }
        return isShortFormEnabled ? .contentHeight(shortHeight) : longFormHeight
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var scrollIndicatorInsets: UIEdgeInsets {
        let bottomOffset = presentingViewController?.bottomLayoutGuide.length ?? 0
        return UIEdgeInsets(top: 0, left: 0, bottom: bottomOffset, right: 0)
    }

    var anchorModalToLongForm: Bool {
        return false
    }

//    func willTransition(to state: PanModalPresentationController.PresentationState) {
//        guard isShortFormEnabled, case .longForm = state
//            else { return }
//
//        isShortFormEnabled = false
//        panModalSetNeedsLayoutUpdate()
//    }
    
    var showDragIndicator: Bool {
        return isShowDragIndicator
    }
}
