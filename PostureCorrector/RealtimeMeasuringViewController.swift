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
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var faceImage: UIImageView!
  
  private var resultList: [Result] = [] {
    
    //Called when new element added
    didSet {
      correctRateLabel.text = "\(correctRate) %"
      badRateLabel.text = "\(badRate) %"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    faceImage.image = UIImage(imageLiteralResourceName: "blank-face")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    resultList.removeAll()
    self.view.sendSubviewToBack(self.backgroundImage)
  }
  
  @IBAction func stopMeasuring(_ sender: UIButton) {
    
  }
}

extension RealtimeMeasuringViewController {
  
  public var correctRate: Double {
    get {
      (Double(resultList.filter{$0.postureType == Result.PostureType.Correct}.count) / Double( resultList.count)) * 100
    }
  }
  
  public var badRate: Double {
    get {
      100 - correctRate
    }
  }
  
  private func changeFaceByRatio(){
    
    if correctRate > 66 {
      self.faceImage.image = UIImage(imageLiteralResourceName: "happy-face")
    } else if correctRate > 32 {
      self.faceImage.image = UIImage(imageLiteralResourceName: "blank-face")
    } else if correctRate > 0 {
      self.faceImage.image = UIImage(imageLiteralResourceName: "sad-face")
    } else {
      fatalError("Nan error: Correct & Bad Rate")
    }
  }
}
