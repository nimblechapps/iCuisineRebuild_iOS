//
//  SmallCuttingBoardToolModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 13/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation


class SmallCuttingBoardTool {
    
    static let sharedInstance = SmallCuttingBoardTool()
    
    var toolPeripheralUUID      : String  = ""
    var toolName                : String  = SmallCuttingBoard
    var toolBatteryLevel        : String  = ""
    var toolIsConnected         : Bool    = false
    var toolCurrentWeight       : Double  = 0
    var toolTargetWeight        : Double  = 0
    var toolPreviousWeight      : Double  = 0
    var toolCurrentWeightString : String  = "--"
    var toolTargetWeightString  : String  = "--"
    var toolIsExpanded          : Bool    = false
    var toolTareWeight          : Double  = 0
    var toolLoadingCounter      : Int     = _kLoadCellLoadTime
    var toolIsLoading           : Bool    = true
    
    class func connectSmallCuttingBoardTool(peripheralUUID : String){
        
        if  SmallCuttingBoardTool.sharedInstance.toolIsConnected == false{
            
            ToolHelpers.rearrangeConnectedTool(connectedTool: _kSmallCuttingBoard)
            
            SmallCuttingBoardTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            SmallCuttingBoardTool.sharedInstance.toolIsConnected = true
            SmallCuttingBoardTool.sharedInstance.toolLoadingCounter = _kLoadCellLoadTime
            SmallCuttingBoardTool.sharedInstance.toolIsLoading = true
        }
        
        
    }
    
    class func disConnectSmallCuttingBoardTool(peripheralUUID : String){
        
        ToolHelpers.rearrangeDisconnectedTool(disConnectedTool: _kSmallCuttingBoard)
        
        SmallCuttingBoardTool.sharedInstance.toolPeripheralUUID = ""
        SmallCuttingBoardTool.sharedInstance.toolIsConnected = false
        SmallCuttingBoardTool.sharedInstance.toolLoadingCounter = _kLoadCellLoadTime
        SmallCuttingBoardTool.sharedInstance.toolIsLoading = true
        SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = 0
        SmallCuttingBoardTool.sharedInstance.toolTargetWeight = 0
        SmallCuttingBoardTool.sharedInstance.toolPreviousWeight = 0
        SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "--"
        SmallCuttingBoardTool.sharedInstance.toolTargetWeightString =  "--"
        SmallCuttingBoardTool.sharedInstance.toolTareWeight = 0
        SmallCuttingBoardTool.sharedInstance.toolIsExpanded = false
        
    }
    
    class func updateWeightForSmallCuttingBoardTool(weight : Double, weightString : String){
        
        
        if SmallCuttingBoardTool.sharedInstance.toolLoadingCounter != 0{
            SmallCuttingBoardTool.sharedInstance.toolLoadingCounter = SmallCuttingBoardTool.sharedInstance.toolLoadingCounter - 1
            SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "loading"
        }
        else if SmallCuttingBoardTool.sharedInstance.toolLoadingCounter == 0 && SmallCuttingBoardTool.sharedInstance.toolIsLoading == true{
            SmallCuttingBoardTool.sharedInstance.toolIsLoading = false
            SmallCuttingBoardTool.sharedInstance.toolTareWeight = weight
            
            
            let actualWeight = weight - SmallCuttingBoardTool.sharedInstance.toolTareWeight
            SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = actualWeight
            SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
            SmallCuttingBoardTool.sharedInstance.toolPreviousWeight = actualWeight
            
        }
        else{
            
            if abs(SmallCuttingBoardTool.sharedInstance.toolPreviousWeight - weight) > 3{
                
                let actualWeight = weight - SmallCuttingBoardTool.sharedInstance.toolTareWeight
                
                if abs(actualWeight) <= 4{
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = 0.0
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "\(0) g"
                }else{
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = actualWeight
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
                }
                
                SmallCuttingBoardTool.sharedInstance.toolPreviousWeight = weight
                
                
            }else{
                let actualWeight = SmallCuttingBoardTool.sharedInstance.toolPreviousWeight - SmallCuttingBoardTool.sharedInstance.toolTareWeight
                
                if abs(actualWeight) <= 4{
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = 0.0
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "\(0) g"
                }else{
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeight = actualWeight
                    SmallCuttingBoardTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
                }
            }
        }
        
    }
    
}
