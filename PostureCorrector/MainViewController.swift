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
    
    if segue.destination is  BluetoothTableViewController {
      if let btvc = segue.destination as? BluetoothTableViewController{
        btvc.mainViewController = self
      }
    }
    
  }
}

