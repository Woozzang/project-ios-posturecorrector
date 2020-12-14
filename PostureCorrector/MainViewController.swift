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
        
        // if conncected
        connectButton.setImage(UIImage(named: "DisconnectDevice"), for: .normal)
        measuringButton.isEnabled = true
        return
      }
      
      // if disconnected
      connectButton.setImage(UIImage(named: "ConnectDevice"), for: .normal)
      measuringButton.isEnabled = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    connectButton.isEnabled = true
    measuringButton.isEnabled = true
    dailyreportButton.isEnabled = true
    
    // Init SampleList
    Result.makeUpSampleList(count: 60)
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
    
    if segue.identifier == "connectActionSegue"{
      guard let crvc = segue.destination as? ConnectRpiViewController else {
        fatalError("Check prepaer(segue:sender:) at MainViewController; case: \"connectActionSegue\"")
      }
      
      crvc.mainViewController = self
    }
  }
  
  @IBAction func checkStateThenDisconnect(_ sender: UIButton) {
    
    if isDeviceConnected == true {
      
      // Code to disconnect from RaspberryPi
      print("disconnect device")
//      self.performSegue(withIdentifier: "connectActionSegue" , sender: nil)
    } else {
      self.performSegue(withIdentifier: "connectActionSegue" , sender: nil)
    }
    
  }
  
  @IBAction func startMeasuring(_ sender: UIButton) {
    self.performSegue(withIdentifier: "measureActionSegue", sender: nil)
  }
  
  
  // unwindsegue 를 이용한 프로퍼티 접근
  @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
//    if let bluetoothVC = unwindSegue.source as? BluetoothTableViewController {
//      self.connectButton.isEnabled = bluetoothVC.isConnected
//    }
  }
}
