//
//  BluetoothTableViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/01.
//
import CoreBluetooth
import UIKit

class BluetoothTableViewController: UITableViewController {
  
  @IBOutlet var bluetoothTableView: UITableView!
  
  var bluetoothDeviceDict: [String:CBPeripheral] = [:]
  
  var centralManager: CBCentralManager!
  
  var updateTimer: Timer!

    override func viewDidLoad() {
      super.viewDidLoad()
      
      centralManager = CBCentralManager(delegate: self, queue: nil)
      
      updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
        self.update()
      }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  
  override func viewWillAppear(_ animated: Bool) {
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {

  }

    // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
    return bluetoothDeviceDict.count
  }

  @IBAction func touchUpCancleButton(_ sender: UIBarButtonItem) {
    updateTimer.invalidate()
    self.dismiss(animated: true, completion: nil)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "deviceName", for: indexPath)
    
    cell.textLabel?.text = Array(self.bluetoothDeviceDict.keys)[indexPath.row]
    
    return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BluetoothTableViewController: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      break
    case .resetting:
      break
    case .unsupported:
      break
    case .unauthorized:
      break
    case .poweredOff:
      break
    case .poweredOn:
      centralManager.scanForPeripherals(withServices: nil)
    @unknown default:
      print()
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                      advertisementData: [String: Any], rssi RSSI: NSNumber) {
    guard let name = peripheral.name  else {
      return
    }
    bluetoothDeviceDict.updateValue(peripheral, forKey: name)
  }
  
  func update() {
    DispatchQueue.global(qos: .background).async {

        // Background Thread

        DispatchQueue.main.async {
          self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
  }
}
