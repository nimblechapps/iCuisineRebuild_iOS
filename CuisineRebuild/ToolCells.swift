//
//  ToolCells.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 04/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation
import  UIKit





class TextInputButton : UIButton, UIKeyInput, UITextInputTraits {
    
     var accessoryView : UIView?
     var _inputView : UIView?
    
    
    override var inputAccessoryView: UIView?{
        get {
            return accessoryView
        }
        set(newValue){
            accessoryView = newValue
        }
    }
    
    override var inputView: UIView?{
        get {
            return _inputView
        }
        set(newValue){
            _inputView = newValue
        }
    }
    
    func insertText(_ text: String) {
        
    }
    
    func deleteBackward() {
        
    }
    
    var hasText: Bool{
        return false
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var canResignFirstResponder: Bool{
        return true
    }
    
}




class SmallCuttingBoardCell : UITableViewCell{
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var topContainerView : UIView!{
        didSet {
            topContainerView.roundedCorners()
        }
    }

    
    @IBOutlet weak var buttonsContainerView : UIView!
    
    @IBOutlet weak var imageContainerView   : UIView!{
        didSet{
            imageContainerView.roundedCorners()
        }
    }
    @IBOutlet weak var toolImageView : UIImageView!{
        didSet{
            toolImageView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonSolidLiquid    : UIButton!{
        didSet{
            buttonSolidLiquid.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonExpandContract : UIButton!{
        didSet{
            buttonExpandContract.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTarget      : UIButton!{
        didSet{
            buttonSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTare        : UIButton!{
        didSet{
            buttonSetTare.roundedCornersWithBorder()
        }
    }
    
    @IBOutlet weak var buttonAddToNutrition : UIButton!{
        didSet{
            buttonAddToNutrition.roundedCornersWithBorder()
        }
    }
    
    @IBOutlet weak var labelTimer : UILabel!
    
    @IBAction func fullScreenTapped(){
        
        if SmallCuttingBoardTool.sharedInstance.toolIsExpanded == true{
            SmallCuttingBoardTool.sharedInstance.toolIsExpanded = false
        }
        else{
            SmallCuttingBoardTool.sharedInstance.toolIsExpanded = true
        }
    }
    
    
    @IBAction func targetTapped(){
    }
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolWeight : UILabel!
    @IBOutlet weak var labelToolTargetWeight : UILabel!
    
}





class SpatulaCell : UITableViewCell,UITextFieldDelegate{
    
    var toolBar : TextToolBar?
    var showPicker : Bool = false
    var pickerView : CommonPickerView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(SpatulaCell.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        
        self.toolBar = TextToolBar.instanceFromNib(block: { (_tapped, _string, _toolBarInstance) in
            
            self.toolBar?.textField?.resignFirstResponder()
            self.endEditing(true)
            
            print(_tapped)
            print(_string ?? "nil")
            
        })
        self.pickerView = CommonPickerView.instanceFromNib(block: { (_text, _commonPickerInstance) in
            self.toolBar?.textField?.text = _text
        })

    }
    
    func keyboardWillShow(){
        if showPicker == true{
        toolBar?.textField?.inputView = self.pickerView
        }
        else{
            toolBar?.textField?.inputView = nil
        }
        toolBar?.textField?.text = ""
        toolBar?.textField?.becomeFirstResponder()
    }

    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var topContainerView : UIView!{
        didSet {
            topContainerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonsContainerView : UIView!
    
    @IBOutlet weak var imageContainerView   : UIView!{
        didSet{
            imageContainerView.roundedCorners()
        }
    }
    @IBOutlet weak var toolImageView : UIImageView!{
        didSet{
            toolImageView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonPreSetTarget    : TextInputButton!{
        didSet{
            buttonPreSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonExpandContract : UIButton!{
        didSet{
            buttonExpandContract.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTarget      : TextInputButton!{
        didSet{
            buttonSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTimer        : UIButton!{
        didSet{
            buttonSetTimer.roundedCornersWithBorder()
        }
    }
    
    @IBOutlet weak var labelTimer : UILabel!
    
    @IBAction func fullScreenTapped(){
        
        if SpatulaTool.sharedInstance.toolIsExpanded == true{
            SpatulaTool.sharedInstance.toolIsExpanded = false
        }
        else{
            SpatulaTool.sharedInstance.toolIsExpanded = true
        }
    }
    
    @IBAction func timerTapped(){
                if SpatulaTool.sharedInstance.toolTimerEndDate == nil{
                    SpatulaTool.sharedInstance.toolTimerEndDate = DateHelpers.getDateByAddingMinutes(minutes: 1.0)
            }
    }
    
    @IBAction func targetTapped(){
        
      self.showPicker = false
      self.buttonSetTarget.inputAccessoryView = self.toolBar
      self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBAction func preSetTargetTapped(){
        
        self.showPicker = true
        self.buttonSetTarget.inputAccessoryView = self.toolBar
        self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolTemperature : UILabel!
    @IBOutlet weak var labelToolTargetTemperature : UILabel!
    
}




class MeatThermometerCell : UITableViewCell,UITextFieldDelegate{
    
    var toolBar : TextToolBar?
    var showPicker : Bool = false
    var pickerView : CommonPickerView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(MeatThermometerCell.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        self.toolBar = TextToolBar.instanceFromNib(block: { (_tapped, _string, _toolBarInstance) in
            
            self.toolBar?.textField?.resignFirstResponder()
            self.endEditing(true)
            
            print(_tapped)
            print(_string ?? "nil")
            
        })
        self.pickerView = CommonPickerView.instanceFromNib(block: { (_text, _commonPickerInstance) in
            self.toolBar?.textField?.text = _text
        })
        
    }
    
    func keyboardWillShow(){
        if showPicker == true{
            toolBar?.textField?.inputView = self.pickerView
        }
        else{
            toolBar?.textField?.inputView = nil
        }
        toolBar?.textField?.text = ""
        toolBar?.textField?.becomeFirstResponder()
    }
    
    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var topContainerView : UIView!{
        didSet {
            topContainerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonsContainerView : UIView!
    
    @IBOutlet weak var imageContainerView   : UIView!{
        didSet{
            imageContainerView.roundedCorners()
        }
    }
    @IBOutlet weak var toolImageView : UIImageView!{
        didSet{
            toolImageView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonPreSetTarget    : TextInputButton!{
        didSet{
            buttonPreSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonExpandContract : UIButton!{
        didSet{
            buttonExpandContract.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTarget      : TextInputButton!{
        didSet{
            buttonSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTimer        : UIButton!{
        didSet{
            buttonSetTimer.roundedCornersWithBorder()
        }
    }
    
    @IBOutlet weak var labelTimer : UILabel!
    
    @IBAction func fullScreenTapped(){
        
        if MeatThermometerTool.sharedInstance.toolIsExpanded == true{
            MeatThermometerTool.sharedInstance.toolIsExpanded = false
        }
        else{
            MeatThermometerTool.sharedInstance.toolIsExpanded = true
        }
    }
    
    @IBAction func timerTapped(){
        if MeatThermometerTool.sharedInstance.toolTimerEndDate == nil{
            MeatThermometerTool.sharedInstance.toolTimerEndDate = DateHelpers.getDateByAddingMinutes(minutes: 1.0)
        }
    }
    
    @IBAction func targetTapped(){
        
        self.showPicker = false
        self.buttonSetTarget.inputAccessoryView = self.toolBar
        self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBAction func buttonPreSetTargetTapped(){
        
        self.showPicker = true
        self.buttonSetTarget.inputAccessoryView = self.toolBar
        self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolTemperature : UILabel!
    @IBOutlet weak var labelToolTargetTemperature : UILabel!
    
}



class WhiskCell : UITableViewCell,UITextFieldDelegate{
    
    var toolBar : TextToolBar?
    var showPicker : Bool = false
    var pickerView : CommonPickerView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(WhiskCell.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        self.toolBar = TextToolBar.instanceFromNib(block: { (_tapped, _string, _toolBarInstance) in
            
            self.toolBar?.textField?.resignFirstResponder()
            self.endEditing(true)
            
            print(_tapped)
            print(_string ?? "nil")
            
        })
        self.pickerView = CommonPickerView.instanceFromNib(block: { (_text, _commonPickerInstance) in
            self.toolBar?.textField?.text = _text
        })
        
    }
    
    func keyboardWillShow(){
        if showPicker == true{
            toolBar?.textField?.inputView = self.pickerView
        }
        else{
            toolBar?.textField?.inputView = nil
        }
        toolBar?.textField?.text = ""
        toolBar?.textField?.becomeFirstResponder()
    }
    
    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var topContainerView : UIView!{
        didSet {
            topContainerView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonsContainerView : UIView!
    
    @IBOutlet weak var imageContainerView   : UIView!{
        didSet{
            imageContainerView.roundedCorners()
        }
    }
    @IBOutlet weak var toolImageView : UIImageView!{
        didSet{
            toolImageView.roundedCorners()
        }
    }
    
    @IBOutlet weak var buttonPreSetTarget    : TextInputButton!{
        didSet{
            buttonPreSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonExpandContract : UIButton!{
        didSet{
            buttonExpandContract.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTarget      : TextInputButton!{
        didSet{
            buttonSetTarget.roundedCornersWithBorder()
        }
    }
    @IBOutlet weak var buttonSetTimer        : UIButton!{
        didSet{
            buttonSetTimer.roundedCornersWithBorder()
        }
    }
    
    @IBOutlet weak var labelTimer : UILabel!
    
    @IBAction func fullScreenTapped(){
        
        if WhiskTool.sharedInstance.toolIsExpanded == true{
            WhiskTool.sharedInstance.toolIsExpanded = false
        }
        else{
            WhiskTool.sharedInstance.toolIsExpanded = true
        }
    }
    
    @IBAction func timerTapped(){
        if WhiskTool.sharedInstance.toolTimerEndDate == nil{
            WhiskTool.sharedInstance.toolTimerEndDate = DateHelpers.getDateByAddingMinutes(minutes: 1.0)
        }
    }
    
    @IBAction func targetTapped(){
        
        self.showPicker = false
        self.buttonSetTarget.inputAccessoryView = self.toolBar
        self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBAction func buttonPreSetTargetTapped(){
        
        self.showPicker = true
        self.buttonSetTarget.inputAccessoryView = self.toolBar
        self.buttonSetTarget.becomeFirstResponder()
        
    }
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolTemperature : UILabel!
    @IBOutlet weak var labelToolTargetTemperature : UILabel!
    
}





