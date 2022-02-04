//
//  MPinDialogueVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 24/12/21.
//


import UIKit

import UIKit

final class Shared {
     static let Sharedstringvariables = Shared() //lazy init, and it only runs once
     var tokenshared : String!
    var mobilenumbershared : String!
    var clientidshared : String!
}
class MPinDialogueVC: UIViewController {
    var Pinnumstr: String!
    var Kisshtstr: String!

    var timer: Timer?



    @IBOutlet weak var DialogueBackView: UIView!
    @IBOutlet weak var Btn: UIButton!
    
    //MARK:- IBOutlet Properties
    
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    
        public class homeVC{
            public init(){}
            public func viewController() -> HomeVC{
                let bundle = Bundle(for: HomeVC.self)
                let homeVC = HomeVC(nibName: "HomeVC", bundle: bundle)
                return homeVC
            }
    
        }
    
//    public class kisshtVC{
//        public init(){}
//        public func viewController() -> KisshtVC{
//            let bundle = Bundle(for: KisshtVC.self)
//            let kisshtVC = KisshtVC(nibName: "KisshtVC", bundle: bundle)
//            return kisshtVC
//        }
//
//    }
    
    
    //MARK:- IBAction
    @IBAction func continueAction(_ sender: UIButton) {
        print("Continue ")
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
        if count == 1{

            switch sender {
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()

            case tf4:
                tf4.becomeFirstResponder()

            default:
                print("default")
            }
        }
        
    }
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customActivityIndicatory(self.view, startAnimate: false)
        


        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
      
        tf1.isSecureTextEntry = true
        tf1.font = UIFont(name: "Avenir", size: 18)

        tf2.isSecureTextEntry = true
        tf2.font = UIFont(name: "Avenir", size: 18)
        tf3.isSecureTextEntry = true
        tf3.font = UIFont(name: "Avenir", size: 18)
        tf4.isSecureTextEntry = true
        tf4.font = UIFont(name: "Avenir", size: 18)





        

        // Do any additional setup after loading the view.
        setUpView()
        
        //--------------Background-View-Color and shadow------------//
        DialogueBackView.layer.cornerRadius = 15.0
        // border
        DialogueBackView.layer.shadowColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8470588235)
        DialogueBackView.layer.shadowOpacity = 0.2
        DialogueBackView.layer.shadowOffset = CGSize(width: 4, height: 4)
        DialogueBackView.layer.shadowRadius = 4.0
       // Backview.backgroundColor = isDarkMode ?  #colorLiteral(red: 0.2705882353, green: 0.1529411765, blue: 0.6274509804, alpha: 0.8470588235): .white
       // linelbl.backgroundColor = isDarkMode ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9640997024): #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        view.layer.masksToBounds = false
        //------------Login Button Radius-------------------------//
        Btn.layer.cornerRadius = 10.0
        Btn.layer.borderWidth = 1.0
        Btn.layer.borderColor = #colorLiteral(red: 0.4, green: 0.2941176471, blue: 0.768627451, alpha: 1)

        
    }
//    @objc func action () {
//    print("done")
//        
//        let GotoKisshtVC = kisshtVC()
//        let VC = GotoKisshtVC.viewController()
//        VC.modalPresentationStyle = .fullScreen
//        self.present(VC, animated: true, completion: nil)
//        
//    }
    
    
    //MARK:- Custom Action
    func setUpView(){
        tf1.setBorder()
        tf2.setBorder()
        tf3.setBorder()
        tf4.setBorder()
        
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        tf1.becomeFirstResponder()
        
        buttonUnSelected()
    }
    
    func buttonUnSelected(){

    }
    func checkAllFilled(){
        
        if (tf1.text?.isEmpty)! || (tf2.text?.isEmpty)! || (tf3.text?.isEmpty)! || (tf4.text?.isEmpty)!{
            buttonUnSelected()
        }else{
            //buttonSelected()
        }
    }
    
    @IBAction func submitbtnclk(_ sender: Any) {
        
        
        
        
        
        let otpstr = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)"
        print("otpstr...",otpstr)

        let otpstrFourDigits = String(otpstr).count > 4
        print("otpstrFourDigits")


        if (tf1.text != "" && tf2.text != "" && tf3.text != "" && tf4.text != "")
        {
            print("Allow")
            LoginAPI()

        }
        else{

            let alert = UIAlertController(title: "Failure", message: "Please Enter 4 digit PIN", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func LoginAPI()
    {
        print("Login service " + LoginServiceAPI.services)
        print("global Calling Prelive login service from class is " + PreLiveServiceAPI.services)
       //9000099990
        let Mobilenumber = "91" + "9553397941"
        
        //let password = Passwordtxtfld!.text
        //var password:String = Passwordtxtfld!.text as Any as! String
        
        var PINpassword:String = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)"

        let loginString = "\(Mobilenumber):\(PINpassword)"
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        
        //Request
        let url = URL(string: LoginServiceAPI.services)!
        var request = URLRequest(url: url)
        customActivityIndicatory(self.view, startAnimate: true)

        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        //Fix "Failed to obtain sandbox extension"
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        
        //Setup Session
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            guard let responseData = data,
                error == nil,
                let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: []) else {
                print("Error")
                return
            }
            
            if let json = jsonObject as? [String : Any] {
                print("Customer data",json)
               // let message = json["message"]! as! Bool
                var status = false
            status = json["success"]! as! Bool
                print("status..",status)
                if let httpResponse = response as? HTTPURLResponse {
                     if let jwt_token = httpResponse.value(forHTTPHeaderField: "jwt_token") as? String {
                
                if (status == true)
                {
                    
                    DispatchQueue.main.async {
                    customActivityIndicatory(self.view, startAnimate: false)
                    }
                    var customerDic = json["customer"]! as! NSDictionary
                    var loginRetrivedData = Loginmodel()
                    loginRetrivedData.mobilenumstr = customerDic["mobileNumber"]! as! String
                    print("model string values",loginRetrivedData.mobilenumstr)

                    loginRetrivedData.id = customerDic["id"]! as! String
                    print("cardId_str...",loginRetrivedData.id)
                    DispatchQueue.main.async {
                        let GotoHomeVC = homeVC()
                        
                        print("jwt_token....",jwt_token)

//                        var tokenstr = jwt_token
//                        print("tokenstr",tokenstr)

                        let VC = GotoHomeVC.viewController()
                        var defaults = UserDefaults(suiteName: "group.com.seligmanventures.LightAlarmFree")
                        UserDefaults.standard.set(jwt_token, forKey: "Refreshtoken")

                        Shared.Sharedstringvariables.tokenshared = jwt_token
                        Shared.Sharedstringvariables.mobilenumbershared = loginRetrivedData.mobilenumstr
                        Shared.Sharedstringvariables.clientidshared = loginRetrivedData.id
                        VC.modalPresentationStyle = .fullScreen
                        self.present(VC, animated: true, completion: nil)
                    }
                    
                }
            }
                     
                     else
                     {
                        DispatchQueue.main.async {

                         print("false values")
                        let alert = UIAlertController(title: "LOGIN_UNSUCCESSFUL", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                     }
                     }
                }
                else
                {
                    DispatchQueue.main.async {

                    print("boolean values failuer")

                    let alert = UIAlertController(title: "Alert", message: "Sorry. Due to many unsuccessful attempts we have blocked the customer. Please do forgot pin to unblock it", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   
                    }
                    
                }
                    

            }
            
        }
        
        task.resume()
    }
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {


        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        //mainContainer.backgroundColor = UIColor.init(netHex: 0xFFFFFF)
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false

        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 200,height: 100))
        viewBackgroundLoading.center = viewContainer.center
        // viewBackgroundLoading.backgroundColor = UIColor.init(netHex: 0x444444)
        viewBackgroundLoading.backgroundColor =  #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 5
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView

    }

    }

extension MPinDialogueVC : UITextFieldDelegate{
    
    
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
    
}
