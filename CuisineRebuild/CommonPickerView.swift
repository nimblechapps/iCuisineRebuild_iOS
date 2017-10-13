//
//  CommonPickerView.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 06/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

typealias SubCategory = (subCategoryTitle : String, subCategoryValue : Int)
typealias Category = (categoryTitle : String, subCategories : [SubCategory] )


class CommonPickerView : UIView, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var pickerView : UIPickerView!
    
    var callBackBlock: ((String?, CommonPickerView) -> ())?
    
    
    let dataSource : [Category] = [
        ("Beef_Lamb",[("Rare",50),("Medium_Rare",56),("Medium",61),("Medium_Well",67),("Well_Done",71)]),
        ("Pork",[("Medium",62),("Well_Done",67)]),
        ("Chicken",[("Whitemeat",71),("Darkmeat",80)]),
        ("Fish",[("Shrimp",49),("Scallops",49),("TunaSwordfishMarlin",51),("Salmon",55),("Trout",58),("Lobster",62)]),
        ("Pastry",[("Clafouti",71),("CremeBrulee",77),("BreadPudding",77),("Breads",96),("CakesCupcakes",96)]),
        ("Candy",[("Meringue",117),("Fruitpastes",120),("Marshmallows",121),("Caramel",123)]),
        ("Chocolate",[("White",117),("Milk",120),("Dark",121)]),
        ("Water",[("WarmWater",47),("HotWater",56),("Poach",76),("SlowBoil",96),("RollingBoil",100)])
    ]
    
    
    class func instanceFromNib(block : @escaping (String?, CommonPickerView)-> ()) -> CommonPickerView{
        
        let instance = CommonPickerView.instanceFromNib()
        instance.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 216)
        instance.callBackBlock  = block
        instance.pickerView.delegate = instance
        return instance
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return (component == 0) ?  self.dataSource.count : dataSource[self.pickerView.selectedRow(inComponent: 0)].subCategories.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return (component == 0) ? dataSource[row].categoryTitle : dataSource[self.pickerView.selectedRow(inComponent: 0)].subCategories[row].subCategoryTitle
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        callBackBlock?(self.dataSource[pickerView.selectedRow(inComponent: 0)].categoryTitle + " | " + self.dataSource[pickerView.selectedRow(inComponent: 0)].subCategories[pickerView.selectedRow(inComponent: 1)].subCategoryTitle,self)
    }
    
    class func instanceFromNib() -> CommonPickerView {
        return UINib(nibName: "CommonPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CommonPickerView
    }
    
    
}
