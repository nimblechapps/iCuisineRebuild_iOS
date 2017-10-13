//
//  MeatThermometerToolModel.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 13/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation


class MeatThermometerTool {
    
    static let sharedInstance = MeatThermometerTool()
    
    var toolPeripheralUUID              : String = ""
    var toolName                        : String = MeatThermometer
    var toolBatteryLevel                : String = ""
    var toolIsConnected                 : Bool = false
    var toolCurrentTemperature          : Double = 0
    var toolTargetTemperature           : Double = 0
    var toolCurrentTemperatureString    : String = "--"
    var toolTargetTemperatureString     : String = "--"
    var toolIsExpanded                  : Bool = false
    var toolTimerEndDate                : Date?
    
    
    class func connectMeatThermometerTool(peripheralUUID : String){
        
        if  MeatThermometerTool.sharedInstance.toolIsConnected == false{
            
            ToolHelpers.rearrangeConnectedTool(connectedTool: _kMeatThermometer)
            
            MeatThermometerTool.sharedInstance.toolPeripheralUUID = peripheralUUID
            MeatThermometerTool.sharedInstance.toolIsConnected = true
            MeatThermometerTool.sharedInstance.toolTimerEndDate = nil
            MeatThermometerTool.sharedInstance.toolIsExpanded = false
        }
    }
    
    class func disConnectMeatThermometerTool(peripheralUUID : String){
        
        ToolHelpers.rearrangeDisconnectedTool(disConnectedTool: _kMeatThermometer)
        
        
        MeatThermometerTool.sharedInstance.toolPeripheralUUID = ""
        MeatThermometerTool.sharedInstance.toolIsConnected = false
        MeatThermometerTool.sharedInstance.toolCurrentTemperature = 0
        MeatThermometerTool.sharedInstance.toolTargetTemperature = 0
        MeatThermometerTool.sharedInstance.toolCurrentTemperatureString = "--"
        MeatThermometerTool.sharedInstance.toolTargetTemperatureString =  "--"
        MeatThermometerTool.sharedInstance.toolTimerEndDate = nil
        MeatThermometerTool.sharedInstance.toolIsExpanded = false
    }
    
    class func updateTemperatureForMeatThermometerTool(temperature : Double, temperatureString : String){
        
        MeatThermometerTool.sharedInstance.toolCurrentTemperature = temperature
        MeatThermometerTool.sharedInstance.toolCurrentTemperatureString = temperatureString + "°c"
        
    }
    
    
}
