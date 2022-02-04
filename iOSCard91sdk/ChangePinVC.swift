//
//  ChangePinVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 03/01/22.
//



import UIKit

class ChangePinVC: UIViewController {

   
    @IBOutlet weak var Bckview: UIView!
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var submitbtn: UIButton!
    @IBOutlet weak var tf1: UITextField!

    @IBOutlet weak var tf2: UITextField!
    
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    
    @IBOutlet weak var tf5: UITextField!
    
    @IBOutlet weak var tf6: UITextField!
    
    @IBOutlet weak var tf7: UITextField!
    
    @IBOutlet weak var tf8: UITextField!
    
    //    @IBOutlet weak var tf1: UITextField!
//    @IBOutlet weak var tf2: UITextField!
//    @IBOutlet weak var tf3: UITextField!
//    @IBOutlet weak var tf4: UITextField!
    //@IBOutlet weak var buttonContinue: UIButton!
    
    
    
        public class homeVC{
            public init(){}
            public func viewController() -> HomeVC{
                let bundle = Bundle(for: HomeVC.self)
                let homeVC = HomeVC(nibName: "HomeVC", bundle: bundle)
                return homeVC
            }
    
        }
    
    
    //MARK:- IBAction
    @IBAction func continueAction(_ sender: UIButton) {
        print("Continue ")
    }
    
    @IBAction func submitbtnclk(_ sender: Any) {
        print("submit btn clk")

//        let otpstr = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)"
//        print("change pin otpstr...",otpstr)
//
//        let otpstrFourDigits = String(otpstr).count > 4
//        print("otpstrFourDigits")

        
        if (tf1.text != "" && tf2.text != "" && tf3.text != "" && tf4.text != "" && tf5.text != "" && tf6.text != "" && tf7.text != "" && tf8.text != "")
        {
            
            
            let change_cardpinstr = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)"
            print("change pin change_cardpinstr...",change_cardpinstr)

            
            let confirm_cardpinstr = "\(tf5.text!)\(tf6.text!)\(tf7.text!)\(tf8.text!)"
            print("change pin confirm_cardpinstr...",confirm_cardpinstr)
            
            
            
            if (change_cardpinstr == confirm_cardpinstr)
            {
                print("Matched")
                let GotoHomeVC = homeVC()
                let VC = GotoHomeVC.viewController()
                VC.modalPresentationStyle = .fullScreen
                self.present(VC, animated: true, completion: nil)
                                    
            }
            else
            {
                print("does not Matched")
                let alert = UIAlertController(title: "Failure", message: "Pin should match", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }

        }
       
        else{
            
            let alert = UIAlertController(title: "Failure", message: "Pin should be 4 digit numeric", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func textEditDidBegin(_ sender: UITextField) {
        print("textEditDidBegin has been pressed")
        
        if !(sender.text?.isEmpty)!{
            sender.selectAll(self)
            //buttonUnSelected()
        }else{
            print("Empty")
            sender.text = " "
            
        }
        
    }
    @IBAction func textEditChanged(_ sender: UITextField) {
        print("textEditChanged has been pressed")
        let count = sender.text?.count
        //
        if count == 1{
            
            switch sender {
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()
                
            case tf4:
                tf4.resignFirstResponder()
                
                
            case tf5:
                tf6.becomeFirstResponder()
            case tf6:
                tf7.becomeFirstResponder()
            case tf7:
                tf8.becomeFirstResponder()
                
            case tf8:
                tf8.resignFirstResponder()
                
                
                
            default:
                print("First default")
            }
        }
        
        else{
            
            switch sender {
            case tf5:
                tf6.becomeFirstResponder()
            case tf6:
                tf7.becomeFirstResponder()
            case tf7:
                tf8.becomeFirstResponder()
                
            case tf8:
                tf8.resignFirstResponder()
            default:
                print("second default")
            }
            
            
        }
        
    }
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)

        // Do any additional setup after loading the view.
        setUpView()
        
        //--------------Background-View-Color and shadow------------//
        Bckview.layer.cornerRadius = 15.0
        // border
        Bckview.layer.shadowColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8470588235)
        Bckview.layer.shadowOpacity = 0.2
        Bckview.layer.shadowOffset = CGSize(width: 4, height: 4)
        Bckview.layer.shadowRadius = 4.0
       // Backview.backgroundColor = isDarkMode ?  #colorLiteral(red: 0.2705882353, green: 0.1529411765, blue: 0.6274509804, alpha: 0.8470588235): .white
       // linelbl.backgroundColor = isDarkMode ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9640997024): #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        view.layer.masksToBounds = false
        //------------Login Button Radius-------------------------//
        submitbtn.layer.cornerRadius = 10.0
       
        
    }
    
    //MARK:- Custom Action
    func setUpView(){
        tf1.setBorder()
        tf2.setBorder()
        tf3.setBorder()
        tf4.setBorder()
        tf5.setBorder()
        tf6.setBorder()
        tf7.setBorder()
        tf8.setBorder()
        
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        
        tf1.becomeFirstResponder()
        
        tf5.delegate = self
        tf6.delegate = self
        tf7.delegate = self
        tf8.delegate = self
        
        tf5.becomeFirstResponder()
        
        //buttonUnSelected()
    }
    
//    func buttonUnSelected(){
//        buttonContinue.layer.borderWidth = 1
//        buttonContinue.backgroundColor = UIColor.white
//        buttonContinue.layer.borderColor = Constants.Color.SavanColor.cgColor
//        buttonContinue.setTitleColor(Constants.Color.SavanColor, for: .normal)
//        buttonContinue.isUserInteractionEnabled = false
//    }
    func checkAllFilled(){
        
        if (tf1.text?.isEmpty)! || (tf2.text?.isEmpty)! || (tf3.text?.isEmpty)! || (tf4.text?.isEmpty)! || (tf5.text?.isEmpty)! || (tf6.text?.isEmpty)! || (tf7.text?.isEmpty)! || (tf8.text?.isEmpty)!{
           // buttonUnSelected()
        }else{
            //buttonSelected()
        }
    }
    
//    func buttonSelected(){
//        buttonContinue.layer.borderWidth = 0
//        buttonContinue.backgroundColor = Constants.Color.SavanColor
//        buttonContinue.setTitleColor(UIColor.white, for: .normal)
//        buttonContinue.isUserInteractionEnabled = true
//    }
    
}





extension ChangePinVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = ""
        if textField.text == "" {
            print("Backspace has been pressed")
        }
        
        if string == ""
        {
            print("Backspace was pressed")
            switch textField {
            case tf2:
                tf1.becomeFirstResponder()
            case tf3:
                tf2.becomeFirstResponder()
            case tf4:
                tf3.becomeFirstResponder()
                
            case tf6:
                tf5.becomeFirstResponder()
            case tf7:
                tf6.becomeFirstResponder()
            case tf8:
                tf7.becomeFirstResponder()
                
                
            default:
                print("default")
            }
            textField.text = ""
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkAllFilled()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//    navigationController?.navigationBar.barStyle = #colorLiteral(red: 0.4, green: 0.2941176471, blue: 0.768627451, alpha: 1)
//    }

}
