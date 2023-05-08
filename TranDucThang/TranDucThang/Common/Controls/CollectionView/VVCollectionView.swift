//
//  VVCollectionView.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 24/05/2022.
// chưa xong!!!

import Foundation
import UIKit

class VVCollectionView: UICollectionView {
    /**Datas of tableView*/
    var datas:[Any] = [] {
        didSet {
            isLoading = datas.isEmpty
            reloadData()
        }
    }
    /**Block call when select item at IndexPath*/
    var onSelected: ((Any, IndexPath) -> Void)?
    var cellDelegate: VVCollectionViewCellDelegate?
    var configCell: ((VVCollectionViewCell, IndexPath) -> Void)?

    var collectDelegate: UICollectionViewDelegate?
    var sizeItem: CGSize = .zero
    var rowSpace: CGFloat = 0
    var columSpace: CGFloat = 0
    var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private var isLoading = true {
        didSet {
            self.isUserInteractionEnabled = !isLoading
            self.reloadData()
        }
    }
    
    @IBInspectable var cell: String = "" {
        didSet {
            if cell.count > 0 {
                if let cls = cell.toClass() {
                    let clsType: AnyClass = cls.self
                    cellClass = clsType as! VVCollectionViewCell.Type
                }
            }
        }
    }
    
    private var cellClass = VVCollectionViewCell.self {
        didSet {
            let identify = cellClass.identify
            if identify.count > 0 {
                let nib = UINib(nibName: identify, bundle: nil)
                self.register(nib, forCellWithReuseIdentifier: identify)
            }
        }
    }
    
    private let shrimmerView: UIView = {
        return UIView()
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        _init()
    }
    
    private func _init() {
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isLoading = true
    }
}

// MARK: UICollectionViewDataSource
extension VVCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return isLoading ? 8 : datas.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.identify, for: indexPath) as? VVCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        if !isLoading {
            cell.indexPath = indexPath
            cell.data = datas[indexPath.row]
            cell.delegate = cellDelegate
            configCell?(cell, indexPath)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension VVCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isLoading {
            let item = datas[indexPath.row]
            self.onSelected?(item, indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.setTempleteWithAllSubviews(isLoading, animate: true, viewBackgroundColor: .cLoading)
    }
}

// MARK: UICollectionViewDelegate
extension VVCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoading {
            return sizeItem
        }
        let item = datas[indexPath.row]
        if let size =  cellClass.sizeWithData(item,indexPath,datas) {
            return size
        }
        
        return sizeItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // khoảng cách giữa các row
        return rowSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // khoảng cách giữa các colum
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


