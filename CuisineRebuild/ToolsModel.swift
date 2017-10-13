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
                
            case is MeatThermometerTool:
                MeatThermometerTool.connectMeatThermometerTool(peripheralUUID: peripheralUUID)
                
            case is WhiskTool:
                WhiskTool.connectWhiskTool(peripheralUUID: peripheralUUID)
                
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
                
            case is MeatThermometerTool:
                MeatThermometerTool.disConnectMeatThermometerTool(peripheralUUID: peripheralUUID)
                
            case is WhiskTool:
                WhiskTool.disConnectWhiskTool(peripheralUUID: peripheralUUID)
                
                
                
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
            
        case MeatThermometer_Id:
            return MeatThermometerTool.sharedInstance
            
        case Whisk_Id:
            return WhiskTool.sharedInstance
            
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
        else if peripheralUUID == MeatThermometerTool.sharedInstance.toolPeripheralUUID{
            return MeatThermometerTool.sharedInstance
        }
        else if peripheralUUID == WhiskTool.sharedInstance.toolPeripheralUUID{
            return WhiskTool.sharedInstance
        }
        else{
            return nil
        }
    }
    
    
    class func getToolIdentifierFrom(rawData : Data) -> String{
        return rawData.hexEncodedString().substring(from: 12, length: 4).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    class func rearrangeConnectedTool(connectedTool : String) {
        let index = ToolsArray.index(of: connectedTool)
        if index != 0 {
            swap(&ToolsArray[0], &ToolsArray[index!])
        }
    }
    
    class func rearrangeDisconnectedTool(disConnectedTool : String) {
        let index = ToolsArray.index(of: disConnectedTool)
        if index != ToolsArray.count-1{
            swap(&ToolsArray[index!], &ToolsArray[ToolsArray.count-1])
        }
    }
}










