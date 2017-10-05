//
//  ToolsModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 29/06/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation
import UIKit

let _kLoadCellLoadTime = 20


let SmallCuttingBoard = "SmallCuttingBoard".localized
let SmallCuttingBoard_Id = "0203"


let MeasuringSpoon    = "MeasuringSpoon".localized
let MeasuringSpoon_Id    = "0206"


let Spatula           = "Spatula".localized
let SpatulaTool_Id       = "0103"



class ToolHelpers {
    
    
    class func connectTool(peripheralUUID : String, forTool : Data){
        
        if let toolInstance = ToolHelpers.getToolInstanceFrom(productId: forTool)   {
            
            switch toolInstance {
            case is SpatulaTool:
                SpatulaTool.connectSpatulaTool(peripheralUUID: peripheralUUID)
                
            case is SmallCuttingBoardTool:
                SmallCuttingBoardTool.connectSmallCuttingBoardTool(peripheralUUID: peripheralUUID)
                
            case is MeasuringSpoonTool:
                MeasuringSpoonTool.connectMeasuringSpoonTool(peripheralUUID: peripheralUUID)
                
            
                
            default:
                break
            }
        }
        
    }
    
    class func disconnectTool(peripheralUUID : String){
        
        if let toolInstance = ToolHelpers.getToolInstanceFromPeripheralId(peripheralUUID: peripheralUUID)   {
            
            switch toolInstance {
            case is SpatulaTool:
                SpatulaTool.disConnectSpatulaTool(peripheralUUID: peripheralUUID)
                
            case is SmallCuttingBoardTool:
                SmallCuttingBoardTool.disConnectSmallCuttingBoardTool(peripheralUUID: peripheralUUID)
                
            case is MeasuringSpoonTool:
                MeasuringSpoonTool.disConnectMeasuringSpoonTool(peripheralUUID: peripheralUUID)
                
            
                
            default:
                break
            }
        }
        
    }
    
    
    
    
    class func getToolInstanceFrom(productId : Data) -> Any? {
        
        switch ToolHelpers.getToolIdentifierFrom(rawData: productId) {
            
        case SpatulaTool_Id:
            return SpatulaTool.sharedInstance
            
        case SmallCuttingBoard_Id:
            return SmallCuttingBoardTool.sharedInstance
            
        case MeasuringSpoon_Id:
            return MeasuringSpoonTool.sharedInstance
            
        default :
            return nil
        }
        
    }
    
    class func getToolInstanceFromPeripheralId(peripheralUUID : String) -> AnyObject? {
        
         if peripheralUUID == MeasuringSpoonTool.sharedInstance.toolPeripheralUUID{
            return MeasuringSpoonTool.sharedInstance
        }
        else if peripheralUUID == SmallCuttingBoardTool.sharedInstance.toolPeripheralUUID{
            return SmallCuttingBoardTool.sharedInstance
        }
        else if peripheralUUID == SpatulaTool.sharedInstance.toolPeripheralUUID{
            return SpatulaTool.sharedInstance
        }
        else if peripheralUUID == MeasuringSpoonTool.sharedInstance.toolPeripheralUUID{
            return MeasuringSpoonTool.sharedInstance
        }
        else{
            return nil
        }
    }
    
    
    class func getToolIdentifierFrom(rawData : Data) -> String{
        return rawData.hexEncodedString().substring(from: 12, length: 4).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    
    
}

class SpatulaTool {
    
    static let sharedInstance = SpatulaTool()
    
    var toolPeripheralUUID              : String = ""
    var toolName                        : String = Spatula
    var toolBatteryLevel                : String = ""
    var toolImage                       : UIImage = UIImage(named: "Spatula")!
    var toolIsConnected                 : Bool = false
    var toolCurrentTemperature          : Double = 0
    var toolTargetTemperature           : Double = 0
    var toolCurrentTemperatureString    : String = "--"
    var toolTargetTemperatureString     : String = "--"
    var toolIsExpanded                  : Bool = false
    var toolTimerEndDate                : Date?
    
    
    class func connectSpatulaTool(peripheralUUID : String){
        
        if  SpatulaTool.sharedInstance.toolIsConnected == false{
            SpatulaTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            SpatulaTool.sharedInstance.toolIsConnected = true
        }
    }
    
    class func disConnectSpatulaTool(peripheralUUID : String){
        
        SpatulaTool.sharedInstance.toolPeripheralUUID = ""
        SpatulaTool.sharedInstance.toolIsConnected = false
        SpatulaTool.sharedInstance.toolCurrentTemperature = 0
        SpatulaTool.sharedInstance.toolTargetTemperature = 0
        SpatulaTool.sharedInstance.toolCurrentTemperatureString = "--"
        SpatulaTool.sharedInstance.toolTargetTemperatureString =  "--"
        SpatulaTool.sharedInstance.toolTimerEndDate = nil
        SpatulaTool.sharedInstance.toolIsExpanded = false
    }
    
    class func updateTemperatureForSpatulaTool(temperature : Double, temperatureString : String){
        
        SpatulaTool.sharedInstance.toolCurrentTemperature = temperature
        SpatulaTool.sharedInstance.toolCurrentTemperatureString = temperatureString + "°c"
        
    }
    
    
}

class SmallCuttingBoardTool {
    
    static let sharedInstance = SmallCuttingBoardTool()
    
    var toolPeripheralUUID      : String  = ""
    var toolName                : String  = SmallCuttingBoard
    var toolBatteryLevel        : String  = ""
    var toolImage               : UIImage = UIImage(named: "SmallCuttingBoard")!
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
            
            SmallCuttingBoardTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            SmallCuttingBoardTool.sharedInstance.toolIsConnected = true
            SmallCuttingBoardTool.sharedInstance.toolLoadingCounter = _kLoadCellLoadTime
            SmallCuttingBoardTool.sharedInstance.toolIsLoading = true
        }
        
        
    }
    
    class func disConnectSmallCuttingBoardTool(peripheralUUID : String){
        
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
class MeasuringSpoonTool {
    
    static let sharedInstance = MeasuringSpoonTool()
    
    var toolPeripheralUUID      : String  = ""
    var toolName                : String  = MeasuringSpoon
    var toolBatteryLevel        : String  = ""
    var toolImage               : UIImage = UIImage(named: "MeasuringSpoon")!
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





