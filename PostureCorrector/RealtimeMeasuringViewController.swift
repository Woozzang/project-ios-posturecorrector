//
//  RealtimeResultViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/12.
//

import UIKit

class RealtimeMeasuringViewController: UIViewController {
  
  @IBOutlet weak var correctRateLabel: UILabel!
  @IBOutlet weak var badRateLabel: UILabel!
  
  private var resultList: [Result] = [] {
    
    //Called when new element added
    didSet {
      correctRateLabel.text = "\(correctRate) %"
      badRateLabel.text = "\(badRate) %"
    }
  }

  override func viewDidLoad() {
      super.viewDidLoad()
    
      // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    resultList.removeAll()
  }
  
  @IBAction func stopMeasuring(_ sender: UIButton) {
    
  }
}

extension RealtimeMeasuringViewController {
  var correctRate: Double {
    get {
      (Double(resultList.filter{$0.postureType == Result.PostureType.Correct}.count) / Double( resultList.count)) * 100
    }
  }
  
  var badRate: Double {
    get {
      100 - correctRate
    }
  }
  
}
