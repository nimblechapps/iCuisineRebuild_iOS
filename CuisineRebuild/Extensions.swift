//
//  Extensions.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 26/06/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation
import  UIKit

// Mark : UIView Extensions

let _kBackgroundGrey : UIColor = UIColor(colorLiteralRed: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 0.5)
let _kThemeRed : UIColor = UIColor(colorLiteralRed: 251.0/255.0, green: 0.0/255.0, blue: 20.0/255.0, alpha: 1)

extension UIView {
    func roundedCorners(){
         self.layer.cornerRadius = 5
    }
    
    func connectedShadow(){
        
        self.layer.shadowColor = _kThemeRed.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func disconnectedShadow(){
        
        self.layer.shadowColor = _kBackgroundGrey.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func circularView(){
        self.layer.cornerRadius = self.frame.size.width/2
    }
}

extension UIButton {
    func roundedCornersWithBorder(){
         self.layer.cornerRadius = 5
         self.layer.borderWidth = 2.0
         self.layer.borderColor = _kBackgroundGrey.cgColor
    }
    
    func connectedGlow(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.borderColor = _kThemeRed.cgColor
    }
    
    func disconnectedGlow(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.borderColor = _kBackgroundGrey.cgColor
    }
    
    
}


// Mark : String Extensions

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.characters.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.characters.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return self[startIndex ..< endIndex]
    }
    
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
}

extension Double {
    
    var formattedTime: String {
        
        var formattedTime = "00:00"
        
        if self > 0 {
            
            let minutes = Int(truncatingRemainder(dividingBy: 3600) / 60)
            let seconds = Int((self.truncatingRemainder(dividingBy:3600)).truncatingRemainder(dividingBy:60))

            
            formattedTime = (minutes < 10 ? "0" + String(minutes) : String(minutes)) + ":" + (seconds < 10 ? "0" + String(seconds) : String(seconds))
        }
        
        return formattedTime
    }
}



// Mark : Data Extensions
// To convert data to Hexa decimal string 

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}




// Mark : Array Extensions
extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
