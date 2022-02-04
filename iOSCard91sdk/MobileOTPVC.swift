    //
    //  MobileOTPVC.swift
    //  iOSCard91sdk
    //
    //  Created by Card91 on 03/01/22.
    //

    import UIKit

    extension String {
    func toBool() -> Bool{
    if self == "false" {
        return false
    }else{
        return true
    }
    }
    }
    final class BlockcardShared {
     static let Sharedblockcard = BlockcardShared() //lazy init, and it only runs once
     var blockcardstr : String!
    }
    class MobileOTPVC: UIViewController {
    var Retrivedtoken = String()
    var Retrivedmobilenumberstr = String()
    var RetrivedClientIdstr = String()
    var toPassmPIN: String?
    var toPassBlock: String?
    var RetrivedCardID = String()
    var counter = 90
    var Resendotp_counter = 90
    @IBOutlet weak var Backview: UIView!
    @IBOutlet weak var Verifybtn: UIButton!
    @IBOutlet weak var otplbl: UILabel!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    @IBOutlet weak var tf5: UITextField!
    @IBOutlet weak var tf6: UITextField!
    @IBOutlet weak var Timercntdownlbl: UILabel!
    @IBOutlet weak var Resendotpcodelbl: UILabel!
    public class Changepin{
            public init(){}
            public func viewController() -> ChangePinVC{
                let bundle = Bundle(for: ChangePinVC.self)
                let Changepin = ChangePinVC(nibName: "ChangePinVC", bundle: bundle)
                return Changepin
            }

        }
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
    @IBAction func Verifybtnclk(_ sender: Any) {
    //        let GotoChangepin = Changepin()
    //        let VC = GotoChangepin.viewController()
    //        VC.modalPresentationStyle = .fullScreen
    //        self.present(VC, animated: true, completion: nil)
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
                tf5.becomeFirstResponder()
            case tf5:
                tf6.becomeFirstResponder()
                
            case tf6:
                tf6.resignFirstResponder()
            default:
                print("default")
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

        //Timer method calling
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MobileOTPVC.Timercountdownupdate), userInfo: nil, repeats: true)
        
        
        if toPassmPIN?.toBool() == true {
             print("its ok")
            otplbl.text = "Change MPIN"
            Verifybtn.setTitle("Verify", for: .normal)
            Verifybtn.addTarget(self, action: #selector(self.Verify(_:)), for: .touchUpInside)
         }
        else if toPassBlock?.toBool() == true
        {
            otplbl.text = "Block"
            Verifybtn.setTitle("Block", for: .normal)
            Verifybtn.addTarget(self, action: #selector(self.BlockOTPverification(_:)), for: .touchUpInside)
        }
        else
        {
            otplbl.text = "Enter OTP"
            Verifybtn.setTitle("Verify mobile number", for: .normal)
            Verifybtn.addTarget(self, action: #selector(self.VerifyMobilenum(_:)), for: .touchUpInside)

        }

        // Do any additional setup after loading the view.
        setUpView()
        
        //--------------Background-View-Color and shadow------------//
        Backview.layer.cornerRadius = 15.0
        // border
        Backview.layer.shadowColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8470588235)
        Backview.layer.shadowOpacity = 0.2
        Backview.layer.shadowOffset = CGSize(width: 4, height: 4)
        Backview.layer.shadowRadius = 4.0
       // Backview.backgroundColor = isDarkMode ?  #colorLiteral(red: 0.2705882353, green: 0.1529411765, blue: 0.6274509804, alpha: 0.8470588235): .white
       // linelbl.backgroundColor = isDarkMode ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9640997024): #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        view.layer.masksToBounds = false
        //------------Login Button Radius-------------------------//
        Verifybtn.layer.cornerRadius = 10.0
        //Resent otp Action calling....
        let Resendoptlabeltap = UITapGestureRecognizer(target: self, action: #selector(MobileOTPVC.Resentotp_tapFunction))
        Resendotpcodelbl.isUserInteractionEnabled = true
        Resendotpcodelbl.addGestureRecognizer(Resendoptlabeltap)
    }
    @objc
       func Resentotp_tapFunction(sender:UITapGestureRecognizer) {

           Retrivedtoken = Shared.Sharedstringvariables.tokenshared
           Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
           RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared
           let language = "English"
           let mobileNumber = Retrivedmobilenumberstr
           let url = URL(string: sendotpAPI.services)!
           let parameters: [String: Any] = ["language": language,"mobileNumber": mobileNumber]
           let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
           customActivityIndicatory(self.view, startAnimate: true)
            // create post request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
               // insert json data to the request
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
                   }
                   let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                   if let responseJSON = responseJSON as? [String: Any] {
                       print("Register Answeres Response",responseJSON)
                       DispatchQueue.main.async { [self] in
                           var succssvalue = false
                           succssvalue = responseJSON["success"] as! Bool
                           print("succssvalue",succssvalue)
                           if (succssvalue == true)
                           {
                               self.customActivityIndicatory(self.view, startAnimate: false)
                               print("send otp API success")

                               DispatchQueue.main.async {
                                   
                                   var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MobileOTPVC.Resentotptimer), userInfo: nil, repeats: true)
                                   
                               }

                           }
                           else
                           {
                               var alertController = UIAlertController(title: "Failure", message: "Resent Tries Exhausted. Please try again later", preferredStyle: UIAlertController.Style.alert)
                               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                   //run your function here
                               }))
                               self.present(alertController, animated: true, completion: nil)
                               self.customActivityIndicatory(self.view, startAnimate: false)


                           }

                       }


                   }
               }

               task.resume()


           
       }

    //Timer

    @objc func Timercountdownupdate() {
        if counter > 0 {
        let minutes = counter / 60
        let seconds = counter % 60
        counter = counter - 1
        Timercntdownlbl.text = "\(minutes):\(seconds)"
        }
        else
        {
        Resendotpcodelbl.text = "Resend code"
        }
    }
    @objc func Resentotptimer() {
        //example functionality
        print("Resend otp timer calling.... here")
        if Resendotp_counter > 0 {
            let minutes = counter / 60
            let seconds = counter % 60
            counter = Resendotp_counter - 1
            Timercntdownlbl.text = "\(minutes):\(seconds)"
        }
        
        else
        {
        Resendotpcodelbl.text = "Resend code"
        }
    }
    // Verify Button Target Action
            @objc func VerifyMobilenum(_ sender:UIButton!) {

            if (tf1.text != "" && tf2.text != "" && tf3.text != "" && tf4.text != "" && tf5.text != "" && tf6.text != "")
            {
            let GotoChangepin = Changepin()
            let VC = GotoChangepin.viewController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            }
            else{
                
                let alert = UIAlertController(title: "Failure", message: "Please Enter 6 digit PIN", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }


    @objc func BlockOTPverification(_ sender:UIButton!) {

    if (tf1.text != "" && tf2.text != "" && tf3.text != "" && tf4.text != "" && tf5.text != "" && tf6.text != "")
    {
        var otpstr:String = "\(tf1.text!)\(tf2.text!)\(tf3.text!)\(tf4.text!)\(tf5.text!)\(tf6.text!)"
        print("otpstr...",otpstr)
        Retrivedtoken = Shared.Sharedstringvariables.tokenshared
        Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
        RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared
       let url = URL(string: verifyOtpAPI.services + "\(otpstr)")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        customActivityIndicatory(view, startAnimate: true)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(Retrivedtoken)", forHTTPHeaderField: "Authorization")
        request.setValue(RetrivedClientIdstr, forHTTPHeaderField: "X-Client-Id")
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            if let data = data,
            let dataString = String(data: data, encoding: .utf8) {
            let str = "Hello World"
            let data = dataString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            let json: AnyObject? = dataString.parseJSONString
            print("Parsed JSON: \(json)")
            do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                var succssvalue = false
                succssvalue = convertedJsonIntoDict["success"] as! Bool
                print("succssvalue",succssvalue)
                if (succssvalue == true)
                {
                    DispatchQueue.main.async {
                    customActivityIndicatory(view, startAnimate: false)
                        BlockAPI()

                    }
                }
                else
                {
                    DispatchQueue.main.async {
                    customActivityIndicatory(view, startAnimate: false)
                    var alertController = UIAlertController(title: "Failure", message: "Resent Tries Exhausted. Please try again later", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                        
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    }
    task.resume()    }
    else{
        
        let alert = UIAlertController(title: "Failure", message: "Please Enter 6 digit PIN", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    }

    @objc func Verify(_ sender:UIButton!) {

    if (tf1.text != "" && tf2.text != "" && tf3.text != "" && tf4.text != "" && tf5.text != "" && tf6.text != "")
    {
        print("click Verify mobile number")
        
        let GotoChangepin = Changepin()
                let VC = GotoChangepin.viewController()
                VC.modalPresentationStyle = .fullScreen
                self.present(VC, animated: true, completion: nil)
    }
    else{
        
        let alert = UIAlertController(title: "Failure", message: "Please Enter 6 digit PIN", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    }



    func BlockAPI()
    {
        
        RetrivedCardID = HomeVCToMobileOTPVCShared.Sharedstringvariables.cardid
        Retrivedtoken = Shared.Sharedstringvariables.tokenshared
        Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
        RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared

        guard let url = URL(string: BlockserviceAPI.services + "\(RetrivedCardID)") else {
                    print("Error: cannot create URL")
                    return
                }
                // Create model
                struct UploadData: Codable {
                    let reason: String
                }
                // Add data to the model
                let uploadDataModel = UploadData(reason: "STOLEN")
                
                // Convert model to JSON data
                guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
                // Create the request
                var request = URLRequest(url: url)
        self.customActivityIndicatory(self.view, startAnimate: true)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(Retrivedtoken)", forHTTPHeaderField: "Authorization")
        request.setValue(RetrivedClientIdstr, forHTTPHeaderField: "X-Client-Id")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
        print(error!)
        return
        }
        guard let data = data else {
        return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        

                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                   
                        let convertedString = String(data: prettyJsonData, encoding: String.Encoding.utf8)

                        if (response.statusCode == 200)
                        {
                        DispatchQueue.main.async { [self] in
                        let alertController = UIAlertController(title: "Success", message: "Your card is been blocked permanently", preferredStyle: .alert)
                        let acceptAction = UIAlertAction(title: "ok", style: .default) { (_) -> Void in
                        let GotoHomeVC = homeVC()
                        let VC = GotoHomeVC.viewController()
                            
                            var defaults = UserDefaults(suiteName: "group.com.seligmanventures.LightAlarmFree")

                            BlockcardShared.Sharedblockcard.blockcardstr = "Blockcard"
                            
                        VC.modalPresentationStyle = .fullScreen
                        self.present(VC, animated: true, completion: nil)
                        }
                        alertController.addAction(acceptAction)
                        present(alertController, animated: true, completion: nil)
                            }
                            
                        }
                        else
                        {
                            DispatchQueue.main.async { [self] in

                            var alertController = UIAlertController(title: "Failure", message: "Already Blocked card", preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                //run your function here
                            }))
                            self.present(alertController, animated: true, completion: nil)
                                customActivityIndicatory(view, startAnimate: false)

                            }
                            
                        }

                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
        
    }



    //MARK:- Custom Action
    func setUpView(){
        tf1.setBorder()
        tf2.setBorder()
        tf3.setBorder()
        tf4.setBorder()
        tf5.setBorder()
        tf6.setBorder()
        
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        tf5.delegate = self
        tf6.delegate = self
        tf1.becomeFirstResponder()
        
        //buttonUnSelected()
    }

    func checkAllFilled(){
        
        if (tf1.text?.isEmpty)! || (tf2.text?.isEmpty)! || (tf3.text?.isEmpty)! || (tf4.text?.isEmpty)! || (tf5.text?.isEmpty)! || (tf6.text?.isEmpty)!{
           // buttonUnSelected()
        }else{
            //buttonSelected()
        }
    }

    }





    extension MobileOTPVC : UITextFieldDelegate{

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
            case tf5:
                tf4.becomeFirstResponder()
            case tf6:
                tf5.becomeFirstResponder()
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



