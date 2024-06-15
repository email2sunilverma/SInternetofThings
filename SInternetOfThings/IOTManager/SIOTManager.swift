//
//  SIOTManager.swift
//  SInternetOfThings
//
//  Created by Sunil Verma on 15/06/24.
//

// Referecne: https://github.com/emqx/CocoaMQTT

import Foundation
import CocoaMQTT
struct SIOTDevice {
    let clientId: String
    let host:String
    let post: UInt16
}
class SiOTManager {
    
    static let shared = SiOTManager()
    private var mqtt: CocoaMQTT!
    
    func connectDevice() {
        
        let clientID = "your-client-id"
        let serverURL = "your-iot-device-ip"
        let serverPort: UInt16 = 1883 // or the port specified by your IoT device
        
        //  CocoaMQTT5(clientID: "", host: "", port: serverPort)
        mqtt = CocoaMQTT(clientID: clientID, host: serverURL, port: serverPort)
        mqtt.delegate = self
        //        mqtt.username = ""
        //        mqtt.password = ""
        //        mqtt.keepAlive = true
        _ = mqtt.connect()
    }
    func connectDevice(device: SIOTDevice) {
        mqtt = CocoaMQTT(clientID: device.clientId, host: device.host, port: device.post)
        mqtt.delegate = self
        _ = mqtt.connect()
        
        mqtt.didReceiveMessage = { mqtt, message, id in
            print("Message received in topic \(message.topic) with payload \(message.string!)")
        }
    }
    
    func disconnnect() {
        if mqtt.connState == .connected {
            self.mqtt.disconnect()
        }
    }
}
extension SiOTManager {
    func subscribeToTopic(topic: String) {
        mqtt.subscribe(topic)
    }
    
    func publishData(topic: String, message: String) {
        mqtt.publish(topic, withString: message, qos: .qos1)
    }
}
// MARK: - CocoaMQTTDelegate methods

extension SiOTManager: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print(ack.description)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print(" \(message.description)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("didPublishAck")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print(message)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print(success)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print(topics)
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("PING")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("PONG")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Disconnected")
    }
}
