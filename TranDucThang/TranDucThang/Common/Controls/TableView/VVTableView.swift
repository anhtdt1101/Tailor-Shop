//
//  VVTableView.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 06/05/2022.
// còn thiếu add edting + multi section

import Foundation
import UIKit

class VVTableView : TPKeyboardAvoidingTableView {
    /**auto layout contraint height. Default is true*/
    @IBInspectable var isAuto:Bool = true
    @IBInspectable var cell:String = "" {
        didSet {
            if cell.count > 0 {
                if let cls = cell.toClass() {
                    let clsType: AnyClass = cls.self
                    cellClass = clsType as! VVTableViewCell.Type
                }
            }
        }
    }
    /**cellClass for coding: if need multi cells use cellFactory block**/
    var cellClass = VVTableViewCell.self {
        didSet {
            let identify = cellClass.identify
            self.registerCell(identify)
        }
    }
    var cellFactory:((Any, IndexPath)->VVTableViewCell.Type)?
    /**Datas of tableView*/
    var datas:[Any] = [] {
        didSet {
            isLoading = false
            if let _ = datas as? [VVTableSection] {
                self.isMultiSection = true
            }else if let data = datas as? [[Any]]
            {
                //convert [[Any]] to [VVTableSection]
                var sections:[VVTableSection] = []
                var idx:Int = 0
                for arr in data {
                    let sec = VVTableSection("\(idx)",arr)
                    sections.append(sec)
                    idx += 1
                }
                self.isMultiSection = true
                self.datas = sections
                return
            }else {
                self.isMultiSection = false
            }
            reloadData()
        }
    }
    var isMultiSection = false
    /**Block call when select item at IndexPath*/
    var onSelected:((Any, IndexPath)->Void)?
    var configurationCell: ((VVTableViewCell, Any, IndexPath) -> Void)?
    var configurationHeader: ((VVTableHeaderView, Int) -> Void)?
    @IBOutlet var tblDelegate:UITableViewDelegate?
    weak var cellDelegate:VVTableViewCellDelegate?
    
    var headerClass = VVTableHeaderView.self {
        didSet {
            let identify = headerClass.identify
            if identify.count > 0 {
                let nib = UINib(nibName: identify, bundle: nil)
                self.register(nib, forHeaderFooterViewReuseIdentifier: identify)
            }
        }
    }
    
    var isLoading = true {
        didSet {
            self.isUserInteractionEnabled = !isLoading
            self.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        _init()
    }
    
    private func _init() {
        self.delegate = self
        self.dataSource = self
        self.isLoading = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    }
    
    func dataOfSec(_ sec:Int) -> [Any]? {
        if isMultiSection {
            if let sec = datas[sec] as? VVTableSection {
                return sec.datas
            }
        }else {
            return datas
        }
        return nil
    }
    
    func dataAt(_ indexPath: IndexPath) -> Any? {
        if let items = dataOfSec(indexPath.section) {
            let row = indexPath.row
            if items.count > row {
                return items[row]
            }
        }
        return nil
    }
    
    private var cellRegistered:[String] = []
    private func registerCell(_ identify:String) {
        if let _ = cellRegistered.first(where: {$0==identify}) {
            //did registered
            // dont need to anymore
            return
        }
        if identify.count > 0 {
            let nib = UINib(nibName: identify, bundle: nil)
            self.register(nib, forCellReuseIdentifier:  identify)
            cellRegistered.append(identify)
        }
    }
}

extension VVTableView: UITableViewDelegate, UITableViewDataSource {
    private func cellClassOf(_ idx:IndexPath) -> VVTableViewCell.Type {
        if isLoading {
            return self.cellClass
        }
        guard let data = dataAt(idx) else {
            return VVTableViewCell.self
        }
        if let factory = self.cellFactory {
            let cls = factory(data,idx)
            let identify = cls.identify
            //register if needed
            self.registerCell(identify)
            return cls
        }
        return self.cellClass
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isLoading {
            return 1
        }
        if isMultiSection {
            return datas.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 20
        }
        if let items = dataOfSec(section) {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isAuto || isLoading {
            return UITableView.automaticDimension
        }
        var height:CGFloat = 0
        if let data = dataAt(indexPath) {
            let cls = cellClassOf(indexPath)
            height = cls.heightOf(data)
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cls = cellClassOf(indexPath)
        let identify = cls.identify
        if identify == "VVTableViewCell" {
            return UITableViewCell()
        }
        let cell = self.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        if let cell = cell as? VVTableViewCell {
            if !isLoading {
                cell.indexPath = indexPath
                if let data = dataAt(indexPath) {
                    configurationCell?(cell, data, indexPath)
                    cell.data = data
                }
                if let cellDelegate = cellDelegate {
                    cell.delegate = cellDelegate
                }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTempleteWithAllSubviews(isLoading, animate: true, viewBackgroundColor: .cLoading)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading, let data = dataAt(indexPath) {
            onSelected?(data,indexPath)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidScroll?(scrollView)
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    //MARK: Header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isMultiSection || isLoading {
            return nil
        }
        guard let sec = datas[section] as? VVTableSection else {
            return nil
        }
        if sec.isHeaderHidden {
            return nil
        }
        if let vHeader = self.dequeueReusableHeaderFooterView(withIdentifier: headerClass.identify) as? VVTableHeaderView {
            vHeader.drawSection(sec,section)
            configurationHeader?(vHeader, section)
            return vHeader
        }
        
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !isMultiSection {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

struct VVTableSection {
    var title = ""
    var inf:Any?
    var datas:[Any]?
    /**Hidden header of this section*/
    var isHeaderHidden = false
    init() {
        
    }
    init(_ inf:Any,_ datas:[Any]) {
        self.inf = inf
        if let title = inf as? String {
            self.title = title
        }
        self.datas = datas
    }
    init(_ title:String,_ datas:[Any]) {
        self.title = title
        self.datas = datas
    }
}


