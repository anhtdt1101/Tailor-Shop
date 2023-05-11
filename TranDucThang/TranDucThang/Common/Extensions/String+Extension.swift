//
//  ExString.swift
//  VVBASE
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import CommonCrypto.CommonDigest
import UIKit

extension String {
    var int:Int {
        return Int(self) ?? 0
    }
    var double:Double {
        return Double(self) ?? 0
    }
    func urldecode() -> String? {
        let str = replacingOccurrences(of: "+", with: " ")
        let decoded = str.removingPercentEncoding
        return decoded
    }
    
    func ecryptBioToken() -> String {
        var result = self
        result.append("f5")
        result = String(result.reversed())
        return result
    }
    
    func deEcryptBioToken() -> String? {
        var result = String(self.reversed())
        let last2 = result.suffix(2)
        if last2 == "f5" {
            result = String(result.dropLast(2))
            return result
        } else {
            return nil
        }
    }
    
    func toClass() -> AnyClass? {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let result: AnyClass = NSClassFromString("\(namespace).\(self)")!
        return result
    }
    
    func matchWith(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: self.count)
        let found = regex.firstMatch(in: self, options: [], range: range)
        return found != nil
    }
    
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var empty:Bool {
        return !self.notEmpty
    }
    var isHTTP:Bool {
        return self.trim().hasPrefix("http")
    }
    var notEmpty:Bool {
        return isEmpty() == false
    }
    func isEmpty() -> Bool {
        if self.trim().count == 0 {
            return true
        } else {
            return false
        }
    }
    
    func removeUTF8() -> String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        var str = simple.components(separatedBy: nonAlphaNumeric).joined(separator: " ")
        str = str.replacingOccurrences(of: "Đ", with: "D")
        str = str.replacingOccurrences(of: "đ", with: "d")
        str = str.replacingOccurrences(of: "ð", with: "d")
        str = str.replacingOccurrences(of: "\n", with: "")
        return str
    }
    func removeCcy() -> String {
        let rslt = self.replacingOccurrences(of: ".", with: "")
        return rslt
    }
    
    func formatCurrencyVND() -> String {
        let inputNumber = NSNumber(value: Double(self) ?? 0.0)
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = "."
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        formatter.positiveFormat = "#,##0¤"
        return formatter.string(from: inputNumber) ?? ""
    }
    /* formatCurrencyVND: viết thêm hàm này cho code ngắn*/
    func ccyFormat() -> String {
        let rslt = self.formatCurrencyVND()
        return rslt
    }
    func ccyAndVND() -> String {
        let formated = self.formatCurrencyVND()
        let rslt = formated + " VND"
        return rslt
    }
    
    func isValidRegEx(_ regex: String) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = stringTest.evaluate(with: self)
        return result
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
 
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidatePhoneNumber() -> Bool {
        let trimmedString = self.removingAllWhitespaces()
        let phoneRegEx = "(0|\\+84)+([0-9]{9})\\b"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: trimmedString)
    }
    
    func removingAllWhitespaces() -> String {
        return removingCharacters(from: .whitespaces)
    }
    
    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
    
    func nameString() -> String {
        let result = self.trim()
        let array = result.components(separatedBy: " ")
        var name: String = ""
        if array.count > 4 {
            let subArray = getLast(array: array, count: 4)
            subArray.enumerated().forEach { (idx, item) in
                name.append("\(item) ")
            }
        } else {
            name = result
        }
        return name
    }
    
    func getLast<T>(array: [T], count: Int) -> [T] {
      if count >= array.count {
        return array
      }
      let first = array.count - count
      return Array(array[first..<first+count])
    }
    
    func formatPhoneNumber() -> String? {
        var newString = replacingOccurrences(of: " ", with: "", options: .regularExpression
            )//, range: Range.init(NSRange(location: 0, length: count)))

        newString = newString.replacingOccurrences(of: "+840", with: "0")
        newString = newString.replacingOccurrences(of: "+84", with: "0")
        if newString.hasPrefix("840") {
            newString = (newString as NSString).substring(from: 3)
            newString = "0\(newString)"
        }
        if newString.hasPrefix("84") {
            newString = (newString as NSString).substring(from: 2)
            newString = "0\(newString)"
        }
        if newString.hasPrefix("016") {
            newString = (newString as NSString).substring(from: 3)
            newString = "03\(newString)"
        }

        //vietnamobie & gmobile
        if newString.hasPrefix("018") || newString.hasPrefix("019") {
            newString = "05\((newString as NSString).substring(from: 3))"
        }
        // mobifone
        if newString.hasPrefix("0120") {
            newString = "070\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0121") {
            newString = "079\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0122") {
            newString = "077\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0126") {
            newString = "076\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0128") {
            newString = "078\((newString as NSString).substring(from: 4))"
        }

        // vinaphone
        if newString.hasPrefix("0123") {
            newString = "083\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0124") {
            newString = "084\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0125") {
            newString = "085\((newString as NSString).substring(from: 4))"
        }
        if newString.hasPrefix("0127") {
            newString = "081\(newString.substring(from: 4))"
        }
        if newString.hasPrefix("0129") {
            newString = "082\(newString.substring(from: 4))"
        }
        
        let doNotWant = CharacterSet(charactersIn: "!@#$%^&*()_+-|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        newString = newString.components(separatedBy: doNotWant).joined(separator: "")
        newString = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return newString.removeWhitespace()
    }
    
    func removeWhitespace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func maskPhone() -> String {
        var result = ""
        if self.isValidatePhoneNumber() {
            let first = self[...2]
            let end = self[8...10]
            result = "\(first)****\(end)"
        } else {
            result = self
        }
        
        return result
    }
    
    func maskNumberId() -> String {
        if self.count > 4 {
            let countStar = self.count - 4
            var countString: String = ""
            for _ in 1...countStar {
                countString.append("*")
            }
            
            let last4 = String(self.suffix(4))
            return "\(countString)\(last4)"
        }
        return self
    }
    
    func cardNumber() -> String? {
        if self.count > 10 {
            let last4 = String(self.suffix(4))
            let first6 = String(self.prefix(6))
            return "\(first6)******\(last4)"
        }
        return nil
    }
    
    func accountNo() -> String {
        if self.count > 14 {
            let result = String(self.suffix(14))
            return result
        }
        return self
    }
    
    func MD5() -> String {
        let data = self.MD5Data()
        let md5Hex =  data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    func MD5Data() -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

// MARK: Emoji
extension String {
    // Not needed anymore in swift 4.2 and later, using `.count` will give you the correct result
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }

    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }

    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }

    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }

    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }

    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?

        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner, !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)

            previousScalar = scalar
        }

        scalars.append(currentScalarSet)

        return scalars.map { $0.map { String($0) }.reduce("", +) }
    }

    var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                chars.append(previous)
                chars.append(cur)

            } else if cur.isEmoji {
                chars.append(cur)
            }

            previous = cur
        }

        return chars
    }
    
    func parseFlightBookingCode() -> String? {
        var billInfo = self.components(separatedBy: "Mã thanh toán: ")
        if billInfo.count != 2 {
            billInfo = self.components(separatedBy: "Payment code: ")
        }
        if billInfo.count >= 2 {
            let codeInfo = billInfo[1].components(separatedBy: ";")
            let billCode = codeInfo.first
            return billCode
        }
        return nil
    }
    
    func encodeEmoji() -> String {
        if let data = self.data(using: .nonLossyASCII, allowLossyConversion: true) {
            return String(data: data, encoding: .utf8) ?? self
        } else {
            return self
        }
    }
    
    func decodeEmoji() -> String {
        if let string = jsonStringRedecoded {
            return string
        } else if let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false),
                  let decodedStr = NSString(data: data, encoding: String.Encoding.nonLossyASCII.rawValue) as String? {
            return decodedStr
        }
        return self
    }
    
    func encodeOnlyEmoji() -> String {
        var c: [Character] = []
        self.forEach { _c in
            if _c.isEmoji {
                c.append(contentsOf: String(_c).encodeEmoji())
            } else {
                c.append(_c)
            }
        }
        return String(c)
    }
    
    var jsonStringRedecoded: String? {
        // https://stackoverflow.com/questions/60932154/text-with-emoji-is-not-decoding-ios-swift
        if let data = ("\"" + self + "\"").data(using: .utf8),
           let string = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? String {
            return string
        }
        return nil
    }
    
}

extension UnicodeScalar {
    /// Note: This method is part of Swift 5, so you can omit this.
    /// See: https://developer.apple.com/documentation/swift/unicode/scalar
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
             0x1F300...0x1F5FF, // Misc Symbols and Pictographs
             0x1F680...0x1F6FF, // Transport and Map
             0x1F1E6...0x1F1FF, // Regional country flags
             0x2600...0x26FF, // Misc symbols
             0x2700...0x27BF, // Dingbats
             0xE0020...0xE007F, // Tags
             0xFE00...0xFE0F, // Variation Selectors
             0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
             0x1F018...0x1F270, // Various asian characters
             0x238C...0x2454, // Misc items
             0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true

        default: return false
        }
    }

    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension NSAttributedString {
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            // not sure which is more reliable: String.Encoding.utf16 or String.Encoding.unicode
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString: attributedString)
    }
    
    convenience init(string: String,
                     attribute: [NSAttributedString.Key: Any],
                     hightlights hStrings: [String],
                     attributes: [[NSAttributedString.Key: Any]]) {
        let att = NSMutableAttributedString(string: string, attributes: attribute)
        let ranges = hStrings
            .filter { string.range(of: $0) != nil }
            .map { NSRange(string.range(of: $0)!, in: string) }
        
        ranges.enumerated().forEach { (element) in
            guard !attributes.isEmpty else { return }
            
            if element.offset < attributes.count {
                att.addAttributes(
                    attributes[element.offset],
                    range: ranges[element.offset])
            } else {
                att.addAttributes(
                    attributes.last ?? attributes[0],
                    range: ranges[element.offset])
            }
        }
        self.init(attributedString: att)
    }
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        if #available(iOS 10.2, *) {
            return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
        }
        return false
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool {
        if #available(iOS 10.2, *) {
            unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false
        }
        return false
    }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
