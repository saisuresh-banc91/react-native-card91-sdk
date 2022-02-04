//
//  Services.swift
//  iOSCard91sdk
//
//  Created by Card91 on 19/01/22.
//

import UIKit

class Services: NSObject {
    var services:String
    
    
    init(services:String) {
      self.services = services
    }

}

//https://api.sb.stag.card91.in
//*****Login API*****//

var CardholderloginAPI = Services(services:"https://api.sb.stag.card91.in/issuance/v1/cardholders/login/token")

//***** Block API *****//
var BlockserviceAPI =   Services(services:"https://api.sb.stag.card91.in/issuance/v1/cardholders/cards/lock")

