//
//  ViewController.swift
//  M1-AirPodOSC
//
//  Created by Dylan Marcus on 9/17/20.
//

import UIKit
import CoreMotion
import SwiftOSC

// OSC Setup
var client = OSCClient(address: "localhost", port: 9901)
var bIgnoreDeviceIMU = false;
var degreesYaw = 0.0
var degreesPitch = 0.0
var degreesRoll = 0.0

// OSC vars
var ipAddress = "localhost"
var port = 9901
var yawEnabled = true
var pitchEnabled = false
var rollEnabled = false
let myRedColor : UIColor = UIColor(red:1.0, green:0, blue:0, alpha:1.0)
let myBlackColor : UIColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)

@available(iOS 14.0, *)
class ViewController: UITableViewController, CMHeadphoneMotionManagerDelegate
 {
    
    @IBOutlet var pitchValue: UILabel!
    @IBOutlet var rollValue: UILabel!
    @IBOutlet var yawValue: UILabel!

    @IBAction func enablePitch(_ sender: Any) {
        pitchEnabled = !pitchEnabled
        if(!pitchEnabled){
            degreesPitch = 0
        }
    }
    @IBAction func enableRoll(_ sender: Any) {
        rollEnabled = !rollEnabled
        if(!rollEnabled){
            degreesRoll = 0
        }
    }
    @IBAction func enableYaw(_ sender: Any) {
        yawEnabled = !yawEnabled
        if(!yawEnabled){
            degreesYaw = 0
        }
    }
    
    var motionManager: CMHeadphoneMotionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMHeadphoneMotionManager()
        motionManager.delegate = self
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
                print(error)
                
                if (yawEnabled){
                    degreesYaw = -(motion?.attitude.yaw)! * 180 / Double.pi
                } else {
                    degreesYaw = 0;
                }
                if (pitchEnabled){
                    degreesPitch = (motion?.attitude.pitch)! * 180 / Double.pi
                } else {
                    degreesPitch = 0;
                }
                if (rollEnabled){
                    degreesRoll = (motion?.attitude.roll)! * 180 / Double.pi
                } else {
                    degreesRoll = 0;
                }
                
                self.yawValue.text = "\(degreesYaw)"
                self.pitchValue.text = "\(degreesPitch)"
                self.rollValue.text = "\(degreesRoll)"
                
                let message = OSCMessage(
                    OSCAddressPattern("/orientation"),
                    degreesYaw,
                    degreesPitch,
                    degreesRoll
                )
                client.send(message)
                //print(message)
            }
        }
    }
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        print("connect")
    }
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        print("disconnect")
    }
    
    //Connect UI and send OSC message
    @IBAction func ipAddressTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            ipAddress = text
            client = OSCClient(address: ipAddress, port: port)
        }
    }
    
    @IBAction func portTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            if let number = Int(text) {
                print(number)
                port = number
                client = OSCClient(address: ipAddress, port: port)
            }
        }
    }
}

@available(iOS 14.0, *)
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
