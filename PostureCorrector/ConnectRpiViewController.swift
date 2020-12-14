//
//  ConnectRpiViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/12.
//

import UIKit
import CocoaMQTT

class ConnectRpiViewController: UIViewController {
  
  @IBOutlet weak var ipAdressTextField: UITextField!
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var disconnectButton: UIButton!
  
  private var serverIPAdrees: String?
  private var mqttClient: CocoaMQTT?
  
  var mainViewController: MainViewController?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    if ipAdressTextField.canBecomeFirstResponder {
      ipAdressTextField.becomeFirstResponder()
    }
    
    guard let mqttClient = mqttClient else {
      return
    }
    
    if mqttClient.connState == .connected {
      connectButton.isEnabled = false
      disconnectButton.isEnabled = true
    } else {
      connectButton.isEnabled = true
      disconnectButton.isEnabled = false
    }
  }
  
  @IBAction func connectServer(_ sender: Any) {
    
    guard let _ = ipAdressTextField.text else {
      
      fatalError("cannot be nil: ipAdressTextField.text")
    }
    
    mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.30.1.7", port: 1883)
    
    let _ = mqttClient?.connect()
    connectButton.isEnabled = false
    disconnectButton.isEnabled = true
  }
  
  @IBAction func disconnectServer(_ sender: Any) {
    
    mqttClient?.disconnect()
    connectButton.isEnabled = true
    disconnectButton.isEnabled = false
  }
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }

}

extension ConnectRpiViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}
