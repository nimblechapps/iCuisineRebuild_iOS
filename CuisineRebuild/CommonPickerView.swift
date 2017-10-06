//
//  CommonPickerView.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 06/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

class CommonPickerView : UIView, UIPickerViewDelegate {
    
    @IBOutlet var pickerView : UIPickerView!
    
    var callBackBlock: ((String?, CommonPickerView) -> ())?
    
    
    class func instanceFromNib(block : @escaping (String?, CommonPickerView)-> ()) -> CommonPickerView{
        
        let instance = CommonPickerView.instanceFromNib()
        instance.frame = CGRect(x: 0, y: 0, width: 568, height: 44)
        instance.callBackBlock  = block
        return instance
    }
    
    
    class func instanceFromNib() -> CommonPickerView {
        return UINib(nibName: "CommonPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CommonPickerView
    }
    
    
    @IBAction func doneTapped(){
        callBackBlock?("", self)
    }
    
    @IBAction func cancelTapped(){
        callBackBlock?("", self)
    }
    
    
}
