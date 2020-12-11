//
//  MainViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/11/26.
//
import CoreBluetooth
import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var measuringButton: UIButton!
  @IBOutlet weak var dailyreportButton: UIButton!
  
  var isDeviceConnected: Bool = false {
    didSet {
      guard isDeviceConnected == false else {
        
        // if true
        connectButton.setImage(UIImage(named: "DisconnectDevice"), for: .normal)
        return
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    connectButton.isEnabled = true
    measuringButton.isEnabled = false
    dailyreportButton.isEnabled = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true

  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
    
    print(segue.destination)
    
    if let dest = segue.destination as? UINavigationController {
      
      if let btvc = dest.topViewController as? BluetoothTableViewController {
        btvc.mainViewController = self
      }
    }
  }
  
  @IBAction func checkStateThenDisconnect(_ sender: UIButton) {
    
    if isDeviceConnected == true {
      
      // Code to disconnect from BLE Device
      print("disconnect device")
      self.performSegue(withIdentifier: "connectActionSegue" , sender: nil)
    } else {
      self.performSegue(withIdentifier: "connectActionSegue" , sender: nil)
    }
    
  }
  
  // unwindsegue 를 이용한 프로퍼티 접근
  @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
//    if let bluetoothVC = unwindSegue.source as? BluetoothTableViewController {
//      self.connectButton.isEnabled = bluetoothVC.isConnected
//    }
  }
}
