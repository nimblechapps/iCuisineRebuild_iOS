//
//  TextToolBar.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 05/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit


class TextToolBar : UIView, UITextFieldDelegate {
    
    @IBOutlet  var btnDone   : UIButton?
    @IBOutlet  var btnCancel : UIButton?
    @IBOutlet  var textField : UITextField?
    
    enum Tapped {
        case Done, Cancel
    }
    
    var callBackBlock: ((Tapped, String?, TextToolBar) -> ())?
    
    class func instanceFromNib(block : @escaping (Tapped, String?, TextToolBar)-> ()) -> TextToolBar{
        let instance = TextToolBar.instanceFromNib()
        instance.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        instance.callBackBlock  = block
        return instance
    }
    
    class func instanceFromNib() -> TextToolBar {
        return UINib(nibName: "TextToolBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TextToolBar
    }

    
    @IBAction func doneTapped(){
     callBackBlock?(Tapped.Done, self.textField?.text!, self)
    }
    
    
    @IBAction func cancelTapped(){
        callBackBlock?(Tapped.Cancel, self.textField?.text!, self)
    }
    
    
}


