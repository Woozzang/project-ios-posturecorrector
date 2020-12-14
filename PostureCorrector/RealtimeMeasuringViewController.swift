//
//  RealtimeResultViewController.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/12.
//

import UIKit

class RealtimeMeasuringViewController: UIViewController {
  
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var faceImage: UIImageView!
  @IBOutlet weak var feedBackLabel: UILabel!
  
  @IBOutlet weak var correctRateLabel: UILabel!
  @IBOutlet weak var badRateLabel: UILabel!
  @IBOutlet weak var backgroundImage: UIImageView!
  

  
  // Timer for timerLabel
  var timer: Timer?
  var sec: Int = 0
  
  // Timer for Update FaceImage by ratio
  var updateFaceTimer: Timer?
  // Interval that RaspberryPi sending data
  var raspberryInterval: Double = 1.0
  

  
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
    self.view.sendSubviewToBack(backgroundImage)
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      
      if self.sec < Result.testResultList.count {
        self.resultList.append(Result.testResultList[self.sec])
        
        //debugging
        print(self.resultList[self.resultList.count-1].postureType)
      }
      
      self.sec += 1
      self.timerLabel.text = self.timeFomatter(self.sec)
    }
    
    self.updateFaceTimer = Timer.scheduledTimer(withTimeInterval: raspberryInterval, repeats: true, block: { (_) in
      self.changeInfoByRatio()
      
      self.correctRateLabel.text = String(format: "%.1f", self.correctRate) + "%"
      self.badRateLabel.text = String(format: "%.1f", self.badRate) + "%"
    })
  }
  
  override func viewWillAppear(_ animated: Bool) {
    resultList.removeAll()
    self.view.sendSubviewToBack(self.backgroundImage)
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.timer?.invalidate()
    self.updateFaceTimer?.invalidate()
  }
}

// About Timer
extension RealtimeMeasuringViewController {
  
  func timeFomatter(_ timeCount: Int) -> String {
    
    let hour = timeCount / 3600
    let min = (timeCount % 3600) / 60
    let sec = (timeCount % 3600) % 60
    
    let hourStr =  hour < 10 ? "0\(hour)" : String(hour)
    let minStr = min < 10 ? "0\(min)" : String(min)
    let secStr = sec < 10 ? "0\(sec)" : String(sec)
    
    return "\(hourStr):\(minStr):\(secStr)"
  }
}

extension RealtimeMeasuringViewController {
  
  public var correctRate: Double {
    get {
      if resultList.count == 0 {
        return 0
      }
      
      let correctCount = Double(resultList.filter{$0.postureType == Result.PostureType.Correct}.count)
      
      return correctCount / Double(resultList.count) * 100
    }
  }
  
  public var badRate: Double {
    get {
      if resultList.count == 0 {
        return 0
      }
      
      return 100 - correctRate
    }
  }
  
  private func changeInfoByRatio(){
    
    if correctRate > 66 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "happy-face")
      self.feedBackLabel.text = "Keep Going!🤩"
      
    } else if correctRate > 32 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "blank-face")
      self.feedBackLabel.text = "Not bad...?🙄"
      
    } else if correctRate >= 0 {
      
      self.faceImage.image = UIImage(imageLiteralResourceName: "sad-face")
      self.feedBackLabel.text = "Inappropriate😡"
      
    } else {
      
      fatalError("Nan error: Correct & Bad Rate")
    }
  }
}


