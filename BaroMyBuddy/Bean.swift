//
//  Bean.swift
//  BaroMyBuddy
//
//  Created by Amanda Nguyen on 11/30/17.
//  Copyright © 2017 Amanda Nguyen. All rights reserved.
//

import CoreBluetooth
import Foundation

class Bean: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // Beacon constants
    let BEAN_NAME = "Bean"
    let BEAN_SCRATCH_UUID = CBUUID(string: "a495ff21-c5b1-4b44-b512-1370f02d74de")
    let BEAN_SERVICE_UUID = CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
    
    // Beacon management
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Beacon manager
        manager = CBCentralManager(delegate: self, queue: nil)
    }
 */
    
    // Check Bluetooth configuration on the device
    func centralManagerDidUpdateState(_ central:CBCentralManager) {
        
        // Is Bluetooth even on
        if central.state == CBManagerState.poweredOn {
            // Start looking
            central.scanForPeripherals(withServices: nil, options: nil)
            
            // Debug
            print("Searching ...")
        } else {
            // Bzzt!
            print("Bluetooth not available.")
        }
    }
    
    // Found a peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // Device
        let device = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey) as? NSString
        
        // Check if this is the device we want
        if device?.contains(BEAN_NAME) == true {
            // Stop looking for devices
            // Track as connected peripheral
            // Setup delegate for events
            self.manager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self
            
            // Connect to the perhipheral proper
            manager.connect(peripheral, options: nil)
            
            // Debug
            debugPrint("Found Bean.")
        }
    }
    
    // Connected to peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Ask for services
        peripheral.discoverServices(nil)
        
        // Debug
        print("Getting services ...")
    }
    
    // Discovered peripheral services
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        // Look through the service list
        for service in peripheral.services! {
            let thisService = service as CBService
            
            // If this is the service we want
            if service.uuid == BEAN_SERVICE_UUID {
                // Ask for specific characteristics
                peripheral.discoverCharacteristics(nil, for: thisService)
                
                // Debug
                print("Using scratch.")
            }
            
            // Debug
            print("Service: ", service.uuid)
        }
    }
    
    // Discovered peripheral characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Enabling ...")
        
        // Look at provided characteristics
        for characteristic in service.characteristics! {
            let thisCharacteristic = characteristic as CBCharacteristic
            
            // If this is the characteristic we want
            if thisCharacteristic.uuid == BEAN_SCRATCH_UUID {
                // Start listening for updates
                // Potentially show interface
                self.peripheral.setNotifyValue(true, for: thisCharacteristic)
                
                // Debug
                print("Set to notify: ", thisCharacteristic.uuid)
            }
            
            // Debug
            print("Characteristic: ", thisCharacteristic.uuid)
        }
    }
    
    // Data arrived from peripheral
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        // Make sure it is the peripheral we want
      //  if characteristic.uuid == BEAN_SCRATCH_UUID {
            
        //    characteristic.value!.getBytes(&count, length:sizeof(UInt32))
          //  labelCount.text = NSString(format: "%llu", count) as String
            
            /*
            // Get bytes into string
            let content = String(data: characteristic.value!, encoding: String.Encoding.utf8)
            
            // Formalize
            let reading = Reading(raw: content!)
            
            // Delegate
            delegate?.didGet(reading: reading)
            
            // Debug
            debugPrint(content!)
 */
        }
    }
    
    // Peripheral disconnected
    // Potentially hide relevant interface
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected.")
        
        // Start scanning again
        central.scanForPeripherals(withServices: nil, options: nil)
    }

