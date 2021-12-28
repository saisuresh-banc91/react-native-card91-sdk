//
//  SwiftManager.swift
//  example
//
//  Created by Card91 on 22/12/21.
//

import Foundation




//
//  HellowWorld.swift
//  AwesomeProject
//
//  Created by Card91 on 21/12/21.
//

import Foundation;
import UIKit
import CustomerSDK


import Foundation

@objc(SwiftComponentManager)
class SwiftComponentManager : NSObject {

  @objc static func requiresMainQueueSetup() -> Bool {
      return false
  }

  // Reference to use main thread
  @objc func open(_ options: NSDictionary) -> Void {
    DispatchQueue.main.async {
      self._open(options: options)
    }
  }

  func _open(options: NSDictionary) -> Void {
    var items = [String]()
    let message = RCTConvert.nsString(options["message"])

    if message != "" {
      items.append(message!)
    }

    if items.count == 0 {
      print("No `message` to share!")
      return
    }

        let controller = RCTPresentedViewController();
    
    
    let custView = Customer()
    let VC = custView.viewController()
    VC.modalPresentationStyle = .fullScreen
    controller?.present(VC, animated: true, completion: nil)
    
  }
}




