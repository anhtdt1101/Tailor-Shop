//
//  SCollectionView.swift
//  IOSBase
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import UIKit

class SCollectionView: UICollectionView{
    
    @IBInspectable var cell: String = "" {
        didSet{
            if !cell.isEmpty{
                if let cls = cell.toClass() {
                    let clsType: AnyClass = cls.self
                    cellClass = clsType as! SCollectionViewCell.Type
                }
            }
        }
    }
    
    var datas: [Any] = []{
        didSet{
            isLoading = false
            reloadData()
        }
    }
    
    var cellClass = SCollectionViewCell.self{
        didSet{
            let identify = cellClass.identify
            if !identify.isEmpty{
                let nib = UINib(nibName: identify, bundle: nil)
                self.register(nib, forCellWithReuseIdentifier: identify)
            }
        }
    }
    
    var isLoading = true {
        didSet{
            self.isUserInteractionEnabled = !isLoading
            self.reloadData()
        }
    }
    
    var onSelected: ((Any, IndexPath) -> Void)?
    var cellDelegate: SCollectionViewCellDelegate?
    var configCell: ((SCollectionViewCell, IndexPath) -> Void)?
    var collectDelegate: UICollectionViewDelegate?
    var sizeItem: CGSize = .zero
    var rowSpace: CGFloat = 0
    var columSpace: CGFloat = 0
    var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    private func _init(){
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        isLoading = false
    }
    
    func dataAt(_ indexPath: IndexPath) -> Any?{
        if let datas = datas as? [[Any]] {
            let array = datas[indexPath.section]
            let item = array[indexPath.row]
            return item
        }
        return datas[indexPath.row]
    }
    
}

extension SCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let datas = datas as? [[Any]]{
            return datas.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoading ? 8 : datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.identify, for: indexPath) as? SCollectionViewCell else {
            debugPrint("Could not dequeue cell")
            return UICollectionViewCell()
        }
        if !isLoading{
            if let obj = dataAt(indexPath) {
                cell.indexPath = indexPath
                cell.data = obj
                cell.delegate = cellDelegate
                configCell?(cell, indexPath)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isLoading {
            if let item = dataAt(indexPath) {
                self.onSelected?(item, indexPath)
            }
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        cell.setTempleteWithAllSubviews(isLoading, animate: true, viewBackgroundColor: .cLoading)
    //    }
}

extension SCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoading {
            return sizeItem
        }
        if let item = dataAt(indexPath),
           let size =  cellClass.sizeWithData(item,indexPath,datas) {
            return size
        }
        
        return sizeItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // space between rows
        return rowSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // space between colums
        return columSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return inset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        collectDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
}


