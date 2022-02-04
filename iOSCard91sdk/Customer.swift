//
//  Manager.swift
//  SampleSDK
//
//  Created by sureshbabu bandaru on 7/17/21.
//

import Foundation
import UIKit





public class Customer{
	public init(){}
    
	public func viewController() -> UIViewController{
            
		let bundle = Bundle(for: LoadingVC.self)
		let VC = LoadingVC(nibName: "LoadingVC", bundle: bundle)
		return VC
	}
	
}

class MyClass
 {
       class func myString() -> String
       {
        
           var str = String()
           str = "Kissht"
           if (str == "Kissht")
           {
               func viewController() -> UIViewController{
                      
                  let bundle = Bundle(for: MPinDialogueVC.self)
                  let VC = MPinDialogueVC(nibName: "MPinDialogueVC", bundle: bundle)
                  return VC
              }
               
           }
           else
           {
               
                   print("values is not calling")
               
           }
           
            
           return "Welcome"
       }
}
