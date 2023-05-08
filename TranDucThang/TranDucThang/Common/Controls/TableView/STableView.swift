//
//  STableView.swift
//  IOSBase
//
//  Created by Tran Duc Tien Anh on 05/05/2023.
//

import Foundation
import UIKit

class STableView: UITableView{
    @IBInspectable var isAuto:Bool = true
    @IBInspectable var cell: String = "" {
        didSet{
            if !cell.isEmpty{
                // transform from text to class cell
                if let cls = cell.toClass(){
                    let clsType: AnyClass = cls.self
                    cellClass = clsType as! STableViewCell.Type
                }
            }
        }
    }
    
    var cellClass = STableViewCell.self{
        didSet{
            let identify = cellClass.identify
            self.registerCell(identify)
        }
    }
    
    private func registerCell(_ identify: String){
        if !identify.isEmpty{
            let nib = UINib(nibName: identify, bundle: nil)
            self.register(nib, forCellReuseIdentifier: identify)
        }
    }
    
    var datas: [Any] = []{
        didSet{
            isLoading = false
            if let _ = datas as? [STableSection] {
                self.isMultiSection = true
            } else {
                self.isMultiSection = false
            }
            reloadData()
        }
    }
    
    var isLoading = true {
        didSet{
            self.isUserInteractionEnabled = !isLoading
            self.reloadData()
        }
    }
        
    var headerClass = STableHeaderView.self {
        didSet {
            let identify = headerClass.identify
            if identify.count > 0 {
                let nib = UINib(nibName: identify, bundle: nil)
                self.register(nib, forHeaderFooterViewReuseIdentifier: identify)
            }
        }
    }
    
    var isMultiSection = false
    var cellFactory:((Any, IndexPath)-> STableViewCell.Type)?
    var configurationCell: ((STableViewCell, Any, IndexPath) -> Void)?
    var configurationHeader: ((STableHeaderView, Int) -> Void)?
    var onSelected:((Any, IndexPath)->Void)?
    weak var cellDelegate: STableViewCellDelegate?
    @IBOutlet var tblDelegate:UITableViewDelegate?
    
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
    // check and return array data
    func dataOfSec(_ section: Int) -> [Any]?{
        if isMultiSection{
            if let sec = datas[section] as? STableSection{
                return sec.datas
            }
        } else {
            return datas
        }
        return nil
    }
    
    // check and return data object in index of IndexPath
    func dataAt(_ indexPath: IndexPath) -> Any? {
        if let items = dataOfSec(indexPath.section) {
            let row = indexPath.row
            if items.count > row{
                return items[row]
            }
        }
        return nil
    }
    
}

extension STableView: UITableViewDataSource, UITableViewDelegate{
    private func cellClassOf(_ idx: IndexPath) -> STableViewCell.Type{
        if isLoading{
            return self.cellClass
        }
        guard let data = dataAt(idx) else {
            return STableViewCell.self
        }
        if let factory = self.cellFactory{
            let cls = factory(data,idx)
            let identify = cls.identify
            // register cell if needed
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
        if let items = dataOfSec(section) {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isAuto || isLoading{
            return UITableView.automaticDimension
        }
        var height: CGFloat = 0
        if let data = dataAt(indexPath){
            let cls = cellClassOf(indexPath)
            height = cls.heightOf(data)
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cls = cellClassOf(indexPath)
        let identify = cls.identify
        if identify == "TableViewCell" {
            return UITableViewCell()
        }
        let cell = self.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? STableViewCell{
            if !isLoading{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading, let data = dataAt(indexPath) {
            onSelected?(data,indexPath)
        }
    }
    
    //MARK: Header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isMultiSection || isLoading {
            return nil
        }
        if datas.isEmpty {
            return nil
        }
        guard let sec = datas[section] as? STableSection else {
            return nil
        }
        if sec.isHeaderHidden {
            return nil
        }
        if let vHeader = self.dequeueReusableHeaderFooterView(withIdentifier: headerClass.identify) as? STableHeaderView {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidScroll?(scrollView)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidScroll?(scrollView)
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tblDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tblDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
}

struct STableSection{
    var title = ""
    var datas: [Any]?
    // addtional information
    var infor: Any?
    var isHeaderHidden = false
    
    init(_ title: String, datas: [Any]){
        self.title = title
        self.datas = datas
    }
}
