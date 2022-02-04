//
//  Model.swift
//  iOSCard91sdk
//
//  Created by Card91 on 19/01/22.
//

import Foundation

//login model variables
struct Loginmodel {
    var mobilenumstr: String = ""
    var id: String = ""

    
    //var id: Int = 0
 
}

//Listing cards model variable's
struct Listingcardsmodel {
    var cardHolderNamestr:String = ""
    var last4Digitstr:String = ""
}

//Transaction List variables

struct Transactionlistmodel {
    var merchantNamestr:String = ""
    var amountstr:String = ""
    var walletnamestr:String = ""
    var Datestr:String = ""
    var txnStatusstr:String = ""
    var cardidstr:String = ""
}


struct smartwallet_getapplicationmodel {
    var namestr:String = ""
    var balance:String = ""
    
    
}
