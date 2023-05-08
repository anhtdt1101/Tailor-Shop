//
//  TFContextType.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 05/08/2022.
//

import Foundation
import UIKit

enum TFContextType {
    case appSearching // search
    case phoneTransfer // transfer content
    case phoneTopup // transfer content
    case topupAmount // transfer content
    case transferContent // transfer content
    case searchLocation // searching location of
    case searchMerchant // searching location of
    case contact //all contact for topup,buy cardcode..
    case vvContact // Ví Vnpay wallet phone number
    case telecomCard //nhà mạng : mua mã thẻ
    case telecomData//nhà mạng : mua thẻ 3G|4G
    
    case billCode(String)//Nhập mã hóa đơn: params is txnType
    case billProvider(String)//Chọn nhà cung cấp: params is txnType
    case custom(String)
    case amount(String)
    case amountWithDraw
    case vetc
    case epass
    
    var contextId:String? {
        var id = ""
        switch(self) {
        case .appSearching:
            id = "appSearching"
            break
        case .transferContent:
            id = "transferContent"
            break
        case .phoneTransfer:
            id = "phoneTransfer"
            break
        case .phoneTopup:
            id = "phoneTopup"
            break
        case .topupAmount:
            id = "topupAmount"
            break
        case .searchLocation:
            id = "locationSearch"
            break
        case .searchMerchant:
            id = "searchMerchant"
            break
        case .amountWithDraw:
            id = "amountWithDraw"
            break
        case .contact:
            id = "contact"
            break
        case .vvContact:
            id = "vvContact"
            break
        case .custom(let custom):
            if custom.count == 0 {
                return nil
            }
            id = "VV" + custom
            break
        case .billCode(let txnType):
            id = "BillCode_" + txnType
            break
        case .vetc:
            id = "BillCode_VETC"
            break
        case .epass:
            id = "BillCode_EPASS"
            break
        case .billProvider(let txnType):
            id = "BillProvider_" + txnType
            break
        case .amount(let txnType):
            id = "VVAmount_" + txnType
            break
        case .telecomCard:
            id = "telecomCard"
            break
        case .telecomData:
            id = "telecomData"
            break
        }
        if !id.isEmpty {
            id = "TFContext_\(id)"
        }
        return id
    }
    
    var height:CGFloat {
        switch self {
        case .phoneTransfer,.transferContent:
            return 60
        case .vetc://2 dòng
            return 44
        case .epass://3 dòng
            return 60
        default:
            return 44
        }
    }
    
    static func ==(lhs:TFContextType, rhs:TFContextType) -> Bool {
        return lhs.contextId == rhs.contextId
    }
    
    var isContent:Bool {
        return self == .transferContent
    }
}
