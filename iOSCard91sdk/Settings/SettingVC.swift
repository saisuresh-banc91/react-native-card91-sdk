//
//  SettingVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 10/01/22.
//

import UIKit




class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var toPassmPIN: String!

    @IBOutlet weak var Gentalsettingtbl: UITableView!
    
    
    @IBOutlet weak var Transactionctrltbl: UITableView!
    
    @IBOutlet weak var callbtn: UIButton!
    let GeneralsettingArray: [String] = ["Change MPIN", "Change Language"]
    //var GeneralsettingimagesArray: [UIImage] = [UIImage(systemName: "chevron.right")!,UIImage(named: "chevron.up")!]
    
    
//    let arrowRight = UIImage(systemName: "multiply.circle.fill")
//    let arrowUP = UIImage(systemName: "multiply.circle.fill")
//    let GeneralsettingArray: [String] = [arrowRight, arrowUP]
//

//
//    var GeneralsettingimagesArray: [UIImage] = [UIImage(systemName: "heart.fill"),UIImage(systemName: "heart.fill")]
////

    let TransactionCtrlArray: [String] = ["ATM Withdrawal", "Online Transaction", "POS Swipe (Merchant)"]

    public class mobileOTPVC{
        public init(){}
        public func viewController() -> MobileOTPVC{
            let bundle = Bundle(for: MobileOTPVC.self)
            let mobileOTPVC = MobileOTPVC(nibName: "MobileOTPVC", bundle: bundle)
            return mobileOTPVC
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        callbtn.layer.cornerRadius = 10.0
        callbtn.layer.borderWidth = 1.0
        callbtn.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        //Generalsetingtblcell
        let bundle = Bundle(for: type(of: self))
        Gentalsettingtbl.register(UINib(nibName: "Generalsetingtblcell", bundle: bundle), forCellReuseIdentifier: "Generalsetingtblcell")
        //Transactionctrltblcell
        Transactionctrltbl.register(UINib(nibName: "Transactionctrltblcell", bundle: bundle), forCellReuseIdentifier: "Transactionctrltblcell")
        
        self.Gentalsettingtbl.rowHeight = 65
        self.Transactionctrltbl.rowHeight = 65


        
        // Do any additional setup after loading the view.
    }


    
//    extension HomeVC:UITableViewDelegate,UITableViewDataSource {
//        public func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // return self.smartWalletsArray.count
             
             var count:Int?
            
             if tableView == self.Gentalsettingtbl {
                 count = GeneralsettingArray.count

             return count!
                 }
             else{
                 if tableView == self.Transactionctrltbl {
                 count = TransactionCtrlArray.count
                 return count!

                 }
                 }
                 return 0
       }
       
    func tableView(tableView: UITableView,
       heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return UITableView.automaticDimension
   }
//         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 60
//        }
       // create a cell for each table view row
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if tableView == self.Gentalsettingtbl {
               let cell = tableView.dequeueReusableCell(withIdentifier: "Generalsetingtblcell", for: indexPath) as! Generalsetingtblcell
               //cell.accessoryType = .disclosureIndicator
               
               
                cell.titlelbl.text = GeneralsettingArray[indexPath.row]
               
               //image Array display
               if (indexPath.row == 0)
               {
                   cell.Languageicon.image = UIImage(systemName: "key.icloud")
                   cell.img.image = UIImage(systemName: "chevron.right")

               }
               else if(indexPath.row == 1)
               {
                   cell.img.image = UIImage(systemName: "chevron.down")
                   cell.Languageicon.image = UIImage(systemName: "globe")

               }
               //let image = GeneralsettingimagesArray[indexPath.row]
               //cell.img.image = UIImage(systemName: "heart.fill")
               
                  return cell
              } else {
                  
                  let cell = tableView.dequeueReusableCell(withIdentifier: "Transactionctrltblcell", for: indexPath) as! Transactionctrltblcell
                  let switchOnOff = UISwitch(frame:CGRect(x: 300, y: 100, width: 250, height: 10))
                  switchOnOff.onTintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                  switchOnOff.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                  switchOnOff.thumbTintColor = UIColor.white
                  switchOnOff.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                  switchOnOff.layer.cornerRadius = 15
                  
                switchOnOff.addTarget(self, action: #selector(self.switchStateDidChange), for: .valueChanged)
                      switchOnOff.setOn(true, animated: false)
                  
                  cell.accessoryView = switchOnOff
                  cell.titlelbl.text = TransactionCtrlArray[indexPath.row]
                  return cell

              }
       }
    
    @objc func switchStateDidChange(sender:UISwitch){
       if (sender.isOn == true){
           sender.setOn(true, animated: false)
           //sender.onImage = UIImage(named: "edit.png")
       }
       else{

           sender.setOn(false, animated: false)
           //sender.offImage = UIImage(named: "offSwitch.png")


       }
   }
       
       // method to run when table view cell is tapped
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
            if tableView == Gentalsettingtbl {
                if (indexPath.row == 0)
                {
                    let GotoMobileOTPVC = mobileOTPVC()
                    var mPINstr = String.self

                    let VC = GotoMobileOTPVC.viewController()
                    UserDefaults.standard.set("Change MPIN", forKey: "mPINkey") //setObject


                    VC.toPassmPIN = "Change MPIN"
                
                    
                    VC.modalPresentationStyle = .fullScreen
                    self.present(VC, animated: true, completion: nil)
                }
                
                } else if tableView == Transactionctrltbl {
                    print("nothing")
                }
        }
    
    @IBAction func Backbtnclk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
