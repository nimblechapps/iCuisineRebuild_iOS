//
//  ToolCells.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 04/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation
import  UIKit

class SmallCuttingBoardCell : UITableViewCell{
    
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
        
//        if SmallCuttingBoardTool.sharedInstance.toolTimerEndDate == nil{
//            SmallCuttingBoardTool.sharedInstance.toolTimerEndDate = DateHelpers.getDateByAddingMinutes(minutes: 1.0)
//        }
        
    }
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolWeight : UILabel!
    @IBOutlet weak var labelToolTargetWeight : UILabel!
    
    
    
    
}





class SpatulaCell : UITableViewCell{
    
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
    
    @IBOutlet weak var buttonSteak    : UIButton!{
        didSet{
            buttonSteak.roundedCornersWithBorder()
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
    
    @IBOutlet weak var fullScreenView : UIView!
    @IBOutlet weak var labelToolName : UILabel!
    @IBOutlet weak var labelToolTemperature : UILabel!
    @IBOutlet weak var labelToolTargetTemperature : UILabel!
    
    
    
    
}
