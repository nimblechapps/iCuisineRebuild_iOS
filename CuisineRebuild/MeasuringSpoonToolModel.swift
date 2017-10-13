//
//  MeasuringSpoonToolModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 13/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation

class MeasuringSpoonTool {
    
    static let sharedInstance = MeasuringSpoonTool()
    
    var toolPeripheralUUID      : String  = ""
    var toolName                : String  = MeasuringSpoon
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
    
    
    
    
    class func connectMeasuringSpoonTool(peripheralUUID : String){
        
        if  MeasuringSpoonTool.sharedInstance.toolIsConnected == false{
            
            MeasuringSpoonTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            MeasuringSpoonTool.sharedInstance.toolIsConnected = true
            MeasuringSpoonTool.sharedInstance.toolLoadingCounter = _kLoadCellLoadTime
            MeasuringSpoonTool.sharedInstance.toolIsLoading = true
        }
    }
    
    class func disConnectMeasuringSpoonTool(peripheralUUID : String){
        
        MeasuringSpoonTool.sharedInstance.toolPeripheralUUID = ""
        MeasuringSpoonTool.sharedInstance.toolIsConnected = false
        MeasuringSpoonTool.sharedInstance.toolLoadingCounter = _kLoadCellLoadTime
        MeasuringSpoonTool.sharedInstance.toolIsLoading = true
        MeasuringSpoonTool.sharedInstance.toolCurrentWeight = 0
        MeasuringSpoonTool.sharedInstance.toolTargetWeight = 0
        MeasuringSpoonTool.sharedInstance.toolPreviousWeight = 0
        MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "--"
        MeasuringSpoonTool.sharedInstance.toolTargetWeightString =  "--"
        MeasuringSpoonTool.sharedInstance.toolTareWeight = 0
        MeasuringSpoonTool.sharedInstance.toolIsExpanded = false
        
        
    }
    
    
    
    class func updateWeightForMeasuringSpoonTool(weight : Double, weightString : String){
        
        
        if MeasuringSpoonTool.sharedInstance.toolLoadingCounter != 0{
            MeasuringSpoonTool.sharedInstance.toolLoadingCounter = MeasuringSpoonTool.sharedInstance.toolLoadingCounter - 1
            MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "loading"
        }
        else if MeasuringSpoonTool.sharedInstance.toolLoadingCounter == 0 && MeasuringSpoonTool.sharedInstance.toolIsLoading == true{
            MeasuringSpoonTool.sharedInstance.toolIsLoading = false
            MeasuringSpoonTool.sharedInstance.toolTareWeight = weight
            
            let actualWeight = weight - MeasuringSpoonTool.sharedInstance.toolTareWeight
            MeasuringSpoonTool.sharedInstance.toolCurrentWeight = actualWeight
            MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
            MeasuringSpoonTool.sharedInstance.toolPreviousWeight = actualWeight
            
        }
        else{
            
            if abs(MeasuringSpoonTool.sharedInstance.toolPreviousWeight - weight) > 3{
                
                let actualWeight = weight - MeasuringSpoonTool.sharedInstance.toolTareWeight
                
                if abs(actualWeight) <= 4{
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeight = 0.0
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "\(0) g"
                }else{
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeight = actualWeight
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
                }
                
                MeasuringSpoonTool.sharedInstance.toolPreviousWeight = weight
                
                
            }else{
                let actualWeight = MeasuringSpoonTool.sharedInstance.toolPreviousWeight - MeasuringSpoonTool.sharedInstance.toolTareWeight
                
                if abs(actualWeight) <= 4{
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeight = 0.0
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "\(0) g"
                }else{
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeight = actualWeight
                    MeasuringSpoonTool.sharedInstance.toolCurrentWeightString = "\(Int(actualWeight)) g"
                }
            }
        }
        
    }
    
}
