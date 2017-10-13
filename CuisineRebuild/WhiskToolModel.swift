//
//  WhiskToolModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 13/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation


class WhiskTool {
    
    static let sharedInstance = WhiskTool()
    
    var toolPeripheralUUID              : String = ""
    var toolName                        : String = Whisk
    var toolBatteryLevel                : String = ""
    var toolIsConnected                 : Bool = false
    var toolCurrentTemperature          : Double = 0
    var toolTargetTemperature           : Double = 0
    var toolCurrentTemperatureString    : String = "--"
    var toolTargetTemperatureString     : String = "--"
    var toolIsExpanded                  : Bool = false
    var toolTimerEndDate                : Date?
    
    
    class func connectWhiskTool(peripheralUUID : String){
        
        if  WhiskTool.sharedInstance.toolIsConnected == false{
            
            ToolHelpers.rearrangeConnectedTool(connectedTool: _kWhisk)
            
            WhiskTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            WhiskTool.sharedInstance.toolIsConnected = true
            WhiskTool.sharedInstance.toolTimerEndDate = nil
            WhiskTool.sharedInstance.toolIsExpanded = false
        }
    }
    
    class func disConnectWhiskTool(peripheralUUID : String){
        
        ToolHelpers.rearrangeDisconnectedTool(disConnectedTool: _kWhisk)
        
        
        WhiskTool.sharedInstance.toolPeripheralUUID = ""
        WhiskTool.sharedInstance.toolIsConnected = false
        WhiskTool.sharedInstance.toolCurrentTemperature = 0
        WhiskTool.sharedInstance.toolTargetTemperature = 0
        WhiskTool.sharedInstance.toolCurrentTemperatureString = "--"
        WhiskTool.sharedInstance.toolTargetTemperatureString =  "--"
        WhiskTool.sharedInstance.toolTimerEndDate = nil
        WhiskTool.sharedInstance.toolIsExpanded = false
    }
    
    class func updateTemperatureForSpatulaTool(temperature : Double, temperatureString : String){
        
        WhiskTool.sharedInstance.toolCurrentTemperature = temperature
        WhiskTool.sharedInstance.toolCurrentTemperatureString = temperatureString + "°c"
        
    }
    
    
}
