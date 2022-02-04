//
//  LoadingVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 12/01/22.
//

import UIKit

class LoadingVC: UIViewController {
    
    var Kisshtstr: String!
    var timer: Timer?


//    public class creditcardVC{
//        public init(){}
//        public func viewController() -> CreditcardVC{
//            let bundle = Bundle(for: CreditcardVC.self)
//            let creditcardVC = CreditcardVC(nibName: "CreditcardVC", bundle: bundle)
//            return creditcardVC
//        }
//
//    }
    public class mPinDialogueVC{
        public init(){}
        public func viewController() -> MPinDialogueVC{
            let bundle = Bundle(for: MPinDialogueVC.self)
            let mPinDialogueVC = MPinDialogueVC(nibName: "MPinDialogueVC", bundle: bundle)
            return mPinDialogueVC
        }

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: false)

        Kisshtstr = "Kissht"

        if (Kisshtstr == "" )
        {
            print("calling Kissht")
        }
        else if (Kisshtstr == "Kissht")
        {
            print("does not calling Kissht")

            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(action), userInfo: nil, repeats: false)
        }
        else
        {
            print("does not calling Kissht")

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: false)
        }

        // Do any additional setup after loading the view.
    }

    @objc func action () {
    print("done")
        
        let GotomPinDialogueVC = mPinDialogueVC()
        let VC = GotomPinDialogueVC.viewController()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)

        
//        let GotocreditcardVCVC = creditcardVC()
//        let VC = GotocreditcardVCVC.viewController()
//        VC.modalPresentationStyle = .fullScreen
//        self.present(VC, animated: true, completion: nil)
//
        
        
    }

}
