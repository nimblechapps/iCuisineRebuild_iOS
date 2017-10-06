//
//  BLEHelper.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 24/06/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation
import CoreBluetooth



class BLEHelper : NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    
    var didUpdateCharactersticData:((CBCharacteristic?)->())?
    
    static let sharedInstance = BLEHelper()
    
    
    var manager : CBCentralManager?
    var connectedPeripherals : [CBPeripheral] = [CBPeripheral]()
    
    
    override init() {
        super.init()
        
        if manager == nil{
            manager = CBCentralManager(delegate: self, queue: nil)
        }
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case CBManagerState.poweredOff:
            print("BLE is powered off")
            break
        case CBManagerState.unauthorized:
            print("This device does not support BLE")
            break
        case CBManagerState.unknown:
            print("Unknown")
            break
        case CBManagerState.poweredOn:
            print("PoweredOn")
            self.scanPeripherals()
            break
        case CBManagerState.resetting:
            print("Resetting")
            break
        case CBManagerState.unsupported:
            print("Unsupported")
            break
        }
    }
    
    func scanPeripherals(){
        if let _manager = self.manager{
            _manager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        
        if let advData = advertisementData["kCBAdvDataLocalName"] as? String{
            
            if advData.contains("Wi-Key") == true || advData.contains("Kitchen") == true {
                if let _manager = self.manager{
                    peripheral.delegate = self
                    connectedPeripherals.append(peripheral)
                    print("Peripheral Discovered : \(peripheral.name)")
                    
                    _manager.connect(peripheral, options: nil)
                }
            }
        }
        else{
            return
        }
        
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error?.localizedDescription ?? "unkown error")
        
        self.scanPeripherals()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let _ = error{
            print(error?.localizedDescription ?? "unkown error")
            self.scanPeripherals()
            return
        }
        if let _services = peripheral.services{
            for service in _services{
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let _ = error{
            print(error?.localizedDescription ?? "unkown error")
            self.scanPeripherals()
            return
        }
        
        if let _characterstics = service.characteristics{
            for characterstic in _characterstics{
                
                
                switch characterstic.uuid {
                case ProductInformationCharacteristicUUID:
                    peripheral.readValue(for: characterstic)
                    
                case BatteryLevelCharacteristicUUID:
                    peripheral.readValue(for: characterstic)
                    peripheral.setNotifyValue(true, for: characterstic)
                    
                case Thermister1CharacteristicUUID:
                    peripheral.setNotifyValue(true, for: characterstic)
                    
                case LoadCell1CharacteristicUUID:
                    peripheral.setNotifyValue(true, for: characterstic)
                    
                case ThermisterLoadCellCharacteristicUUID:
                    peripheral.setNotifyValue(true, for: characterstic)
                    
                case Thermister4CharacteristicUUID:
                    peripheral.setNotifyValue(true, for: characterstic)
                default:
                    print("")
                }
            }
        }
    }
    
    func update(block : @escaping (CBCharacteristic?)->()){
        self.didUpdateCharactersticData = block
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let _ = error{
            print(error?.localizedDescription ?? "unkown error")
            self.scanPeripherals()
            return
        }
        
        switch characteristic.uuid {
            
        case ProductInformationCharacteristicUUID:
            if let value = characteristic.value{
                ToolHelpers.connectTool(peripheralUUID : peripheral.identifier.uuidString, forTool: value)
            }
            print(characteristic.value ?? "Product Info")
            
        case BatteryLevelCharacteristicUUID:
            print(characteristic.value ?? "Battery Level")
            
        case Thermister1CharacteristicUUID:
            if let value = characteristic.value{
                if let temperature = self.getTemperatureFromHexString(rawData: value){
                    
                    let temperatureTool = ToolHelpers.getToolInstanceFromPeripheralId(peripheralUUID: peripheral.identifier.uuidString)
                    
                    switch temperatureTool {
                    case is SpatulaTool:
                        SpatulaTool.updateTemperatureForSpatulaTool(temperature: temperature.temperature, temperatureString: temperature.temperatureString)
                        
                    default:
                        break
                    }
                }
            }
            
        case LoadCell1CharacteristicUUID:
            
            if let value = characteristic.value{
                if let weight = self.getWeightFromHexString(rawData: value){
                    
                    let weightTool = ToolHelpers.getToolInstanceFromPeripheralId(peripheralUUID: peripheral.identifier.uuidString)
                    
                    switch weightTool {
                    case is SmallCuttingBoardTool:
                        SmallCuttingBoardTool.updateWeightForSmallCuttingBoardTool(weight: weight.weight, weightString: weight.weightString)
                        
                    case is MeasuringSpoonTool:
                        MeasuringSpoonTool.updateWeightForMeasuringSpoonTool(weight: weight.weight, weightString: weight.weightString)
                    default:
                        break
                    }
                }
            }
            
        case ThermisterLoadCellCharacteristicUUID:
            print(characteristic.value ?? "ThermisterLoadcell")
            
        case Thermister4CharacteristicUUID:
            print(characteristic.value ?? "Thermister4")
        default:
            print("Other device detected")
        }
        
        if let block = self.didUpdateCharactersticData{
            block(characteristic)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if self.connectedPeripherals.contains(peripheral) == true{
            self.connectedPeripherals.remove(object: peripheral)
            ToolHelpers.disconnectTool(peripheralUUID: peripheral.identifier.uuidString)
            if let block = self.didUpdateCharactersticData{
                block(nil)
            }
        }
        self.scanPeripherals()
    }
    
    func getTemperatureFromHexString(rawData : Data) -> (temperature : Double, temperatureString : String)?{
        
        let temperatureComponent =  rawData.hexEncodedString().trimmingCharacters(in: .whitespacesAndNewlines)
        let temperatureInHex = temperatureComponent.substring(from: 2, length: 2) + temperatureComponent.substring(from: 0, length: 2)
        let temperature = UInt32(temperatureInHex, radix: 16)
        
        if temperature != nil{
            let actualTemperature = temperature!/100
            let sign = temperatureComponent.substring(from: 4, length: 2)
            if sign == "ff"{
                return((Double(actualTemperature) * -1),"-\(actualTemperature)")
            }
            else{
                return(Double(actualTemperature),"\(actualTemperature)")
            }
        }
        return nil
    }
    
    func getWeightFromHexString(rawData : Data) -> (weight : Double, weightString : String)?{
        
        let weightComponent =  rawData.hexEncodedString().trimmingCharacters(in: .whitespacesAndNewlines)
        let weightInHex = weightComponent.substring(from: 4, length: 2) + weightComponent.substring(from: 2, length: 2) + weightComponent.substring(from: 0, length: 2)
        let weight = UInt32(weightInHex, radix: 16)
        
        if weight != nil{
            return(Double(weight!),"\(weight!)")
        }
        return nil
    }
    
    
}



