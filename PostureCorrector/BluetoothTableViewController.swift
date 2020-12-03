//
//  BluetoothTableViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/01.
//
import CoreBluetooth
import UIKit

class BluetoothTableViewController: UITableViewController {
  
  var mainViewController: MainViewController?
  
  @IBOutlet var bluetoothTableView: UITableView!
  
//  var bluetoothDeviceDict: [String:CBPeripheral] = [:]
  var bluetoothDeviceList: [CBPeripheral] = []
  
  var centralManager: CBCentralManager!
  
  var isConnected: Bool = false
  
  var updateTimer: Timer!

    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.navigationController?.isNavigationBarHidden = false
      centralManager = CBCentralManager(delegate: self, queue: nil)
      
      updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
        self.updateTableView()
      }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  
  override func viewWillAppear(_ animated: Bool) {
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    mainViewController?.connectButton.isEnabled = false
    updateTimer.invalidate()
  }

    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
    return bluetoothDeviceList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "deviceName", for: indexPath)
    
    cell.textLabel?.text = self.bluetoothDeviceList[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  func updateTableView() {
    DispatchQueue.global(qos: .background).async {

        // Background Thread

        DispatchQueue.main.async {
          self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
  }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

}

extension BluetoothTableViewController: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      break
    case .resetting:
      break
    case .unsupported:
      dismiss(animated: true, completion: nil)
    case .unauthorized:
      break
    case .poweredOff:
      break
    case .poweredOn:
      centralManager.scanForPeripherals(withServices: nil)
    @unknown default:
      break
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
  
  guard peripheral.name != nil else {
    return
  }
  
  for (index, device) in bluetoothDeviceList.enumerated() {
    if device.name == peripheral.name {
      
      bluetoothDeviceList[index] = peripheral
      
      bluetoothDeviceList.sort { (lhs, rhs) -> Bool in
        guard let lname = lhs.name, let rname = rhs.name else {
          return false
        }
        
        return lname > rname
      }
      
      return
    }
  }
    
    bluetoothDeviceList.append(peripheral)
    bluetoothDeviceList.sort { (lhs, rhs) -> Bool in
      guard let lname = lhs.name, let rname = rhs.name else {
        return false
      }
      
      return lname > rname
    }
    
    return
}
  

}
