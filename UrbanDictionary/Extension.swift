//
//  Extension.swift
//  UrbanDictionary
//
//  Created by Doyeong's MacBookPro on 21/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit

//extension String {
//    func maxLength(length: Int) -> String {
//        var string = self
//        let nsString = string as NSString
//        if nsString.length >= length {
//            string = nsString.substring(with: NSRange(location: 0,
//                                                      length: nsString.length > length ? length : nsString.length))
//        }
//        return string
//    }
//}

extension UILabel {
    func maxLength(first: String, second: String, length: Int) {
        var secondConvertText = ""

        if second.count >= length {
            let index = second.index((second.startIndex), offsetBy: length)
            secondConvertText = second.substring(to: index)
            secondConvertText = secondConvertText.appending("...")
            
            self.attributedText = attributedText(first: first, second: secondConvertText)
        }
    }
    
    func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
    }
}
