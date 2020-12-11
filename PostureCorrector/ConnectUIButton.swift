//
//  ConnectUIButton.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/11.
//

import UIKit

class ConnectUIButton: UIButton {

  /*
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
      // Drawing code
  }
  */
  init() {
    super.init(frame: CGRect.zero)
//    self.isConnected = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension UIButton {
  
//  internal var isConnected:Bool {
//
//    didSet{
//      if isConnected == true {
//        self.setImage(UIImage(imageLiteralResourceName: "DisconncetDevice"), for: .normal)
//      } else {
//        self.setImage(UIImage(imageLiteralResourceName: "ConnectDevice"), for: .normal)
//      }
//    }
//  }
}
