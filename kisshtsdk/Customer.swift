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
            
		let bundle = Bundle(for: CreditcardVC.self)
		let VC = CreditcardVC(nibName: "CreditcardVC", bundle: bundle)
		return VC
	}
	
}

 
