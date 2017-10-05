//
//  TextToolBar.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 05/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

protocol ToolBarDelegate {
    
    func doneTapped(textInput : String)
    func cancelTapped()
}

class TextToolBarView : UIView, UITextFieldDelegate {
    
    var toolBarDelegate : ToolBarDelegate?
    
    var btnDone   : UIBarButtonItem?
    var btnCancel : UIBarButtonItem?
    var textField : UITextField?
    
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeToolBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeToolBar()
    }
    
    
    func initializeToolBar() {
        let tb : ToolBar =  ToolBar.instanceFromNib() as! ToolBar
        tb.frame = self.frame
        self.btnDone = tb.btnDone
        self.btnCancel = tb.btnCancel
        self.textField = tb.textField
        self.textField?.inputAccessoryView = self
        self.addSubview(tb)
    }
    
    @IBAction func doneTapped(){
        if let delegate = toolBarDelegate{
            if let txtFld = self.textField{
            delegate.doneTapped(textInput: txtFld.text!)
            }
            else{
             delegate.doneTapped(textInput: "")
            }
        }
    }
    
    @IBAction func cancelTapped(){
        if let delegate = toolBarDelegate{
            delegate.cancelTapped()
        }
    }
    
    
}

class ToolBar: UIToolbar {
    
    @IBOutlet var btnDone     : UIBarButtonItem!
    @IBOutlet var btnCancel   : UIBarButtonItem!
    @IBOutlet var textField   : UITextField!
    
    class func instanceFromNib() -> UIToolbar {
        return UINib(nibName: "TextToolBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ToolBar
    }
}

