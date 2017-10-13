//
//  SpatulaToolModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 13/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation



class SpatulaTool {
    
    static let sharedInstance = SpatulaTool()
    
    var toolPeripheralUUID              : String = ""
    var toolName                        : String = Spatula
    var toolBatteryLevel                : String = ""
    var toolIsConnected                 : Bool = false
    var toolCurrentTemperature          : Double = 0
    var toolTargetTemperature           : Double = 0
    var toolCurrentTemperatureString    : String = "--"
    var toolTargetTemperatureString     : String = "--"
    var toolIsExpanded                  : Bool = false
    var toolTimerEndDate                : Date?
    
    
    class func connectSpatulaTool(peripheralUUID : String){
        
        if  SpatulaTool.sharedInstance.toolIsConnected == false{
            
            ToolHelpers.rearrangeConnectedTool(connectedTool: _kSpatula)
            
            SpatulaTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            SpatulaTool.sharedInstance.toolIsConnected = true
            SpatulaTool.sharedInstance.toolTimerEndDate = nil
            SpatulaTool.sharedInstance.toolIsExpanded = false
        }
    }
    
    class func disConnectSpatulaTool(peripheralUUID : String){
        
        ToolHelpers.rearrangeDisconnectedTool(disConnectedTool: _kSpatula)
        
        
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
