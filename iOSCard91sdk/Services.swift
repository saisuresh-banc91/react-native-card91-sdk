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

//devsandbox
//*****Login API*****//

var LoginServiceAPI = Services(services:"https://devsandbox-app.card91.io/customer/1.0/login/mobile")
//*****Customer Listing API*****//
var CustomerListingcardAPI = Services(services:"https://devsandbox-app.card91.io/custlisting/1.0/card/allCustomerCards?noOfRecords=5&pagingState=0")

//*****TransactionAPI*****//
var TransactionlistAPI = Services(services:"https://devsandbox-app.card91.io/custlisting/1.0/txn/allCustomerTxns?noOfRecords=5")

//*****Smart Wallets*****//
var getCardApplicationsAPI = Services(services:"https://devsandbox-app.card91.io/custmgmt/1.0/getCardApplications/")

// API sendotp
var sendotpAPI = Services(services:"https://devsandbox-app.card91.io/customer/1.0/forgotpassword/sendotp")
//verifyOtp API
var verifyOtpAPI = Services(services:"https://devsandbox-app.card91.io/custmgmt/1.0/verifyOtp/?otp=")

var BlockserviceAPI = Services(services:"https://devsandbox-app.card91.io/custmgmt/1.0/block/")












//prelive
var PreLiveServiceAPI = Services(services:"https://prelive-app.card91.io/customer/1.0/login/mobile")



//func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
//
//
//    let mainContainer: UIView = UIView(frame: viewContainer.frame)
//    mainContainer.center = viewContainer.center
//    //mainContainer.backgroundColor = UIColor.init(netHex: 0xFFFFFF)
//    mainContainer.alpha = 0.5
//    mainContainer.tag = 789456123
//    mainContainer.isUserInteractionEnabled = false
//
//    let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 200,height: 100))
//    viewBackgroundLoading.center = viewContainer.center
//    // viewBackgroundLoading.backgroundColor = UIColor.init(netHex: 0x444444)
//    viewBackgroundLoading.backgroundColor = UIColor.black
//    viewBackgroundLoading.alpha = 0.5
//    viewBackgroundLoading.clipsToBounds = true
//    viewBackgroundLoading.layer.cornerRadius = 5
//    
//    let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
//    activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
//    activityIndicatorView.style = UIActivityIndicatorView.Style.whiteLarge
//    activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
//    if startAnimate!{
//        viewBackgroundLoading.addSubview(activityIndicatorView)
//        mainContainer.addSubview(viewBackgroundLoading)
//        viewContainer.addSubview(mainContainer)
//        activityIndicatorView.startAnimating()
//    }else{
//        for subview in viewContainer.subviews{
//            if subview.tag == 789456123{
//                subview.removeFromSuperview()
//            }
//        }
//    }
//    return activityIndicatorView
//
//}
