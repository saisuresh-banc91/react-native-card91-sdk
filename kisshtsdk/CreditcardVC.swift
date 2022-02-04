//
//  CreditcardVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 12/01/22.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


class CreditcardVC: UIViewController {
    
    
    
     @IBOutlet weak var switch1: MJMaterialSwitch!
    @IBOutlet weak var switch2: MJMaterialSwitch!
    @IBOutlet weak var cancelimg: UIImageView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var Bottompopupview: UIView!
    @IBOutlet weak var UnfreezeView: UIView!
    @IBOutlet weak var BlockView: UIView!
    @IBOutlet weak var helplbl: UILabel!
    @IBOutlet weak var freezelbl: UILabel!
    @IBOutlet weak var freezecreditcrdlbl: UILabel!
    @IBOutlet weak var blocktxtlbl: UILabel!
    @IBOutlet weak var managecardlbl: UILabel!
    @IBOutlet weak var blockcredictcardlbl: UILabel!
    @IBOutlet weak var freezetxtbckview: UIView!
    @IBOutlet weak var cardbckview: UIView!
    @IBOutlet weak var freezebckview: UIView!
    @IBOutlet weak var freezenexttransactionlbl: UILabel!
    @IBOutlet weak var frozenalertView: UIView!
    @IBOutlet weak var disablecard: UIView!
    @IBOutlet weak var callnowbtn: UIButton!
    @IBOutlet weak var GotITbtn: UIButton!
    @IBOutlet weak var Blkbtn: UIButton!
    @IBOutlet weak var cancelbtn: UIButton!
    //Loading Properties
    @IBOutlet weak var Last4digittxtfld: UITextField!
    @IBOutlet weak var cardholderlbl: UILabel!
    
    //Freeze
    @IBOutlet weak var FreezeLast4digittxtfld: UITextField!
    @IBOutlet weak var Freezecardholderlbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customActivityIndicatory(self.view, startAnimate: false)
        //Card Holder method calling...
        CardholderloadingAPI()
        //UISwitch
        self.switch1.addTarget(self, action: #selector(switchStateChanged(_:)), for: UIControl.Event.valueChanged)
        self.switch1.tag = 1
        switch1.isOn = false
        let xPos: CGFloat = (UIScreen.main.bounds.width / 2 ) - 22.5
        let yPos: CGFloat = (UIScreen.main.bounds.height / 2 ) + 50.0
        //freezetxtbckview is hidden
        freezetxtbckview.isHidden = true
        freezebckview.isHidden = true
        Bottompopupview.isHidden = true
        frozenalertView.isHidden = true
        disablecard.isHidden = true
        switch2.isHidden = true
        //Unfreez View
        UnfreezeView.layer.cornerRadius = 12
        UnfreezeView.layer.masksToBounds = true;
        UnfreezeView.backgroundColor = UIColor.white
        UnfreezeView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        UnfreezeView.layer.shadowOpacity = 0.8
        UnfreezeView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        UnfreezeView.layer.shadowRadius = 6.0
        UnfreezeView.layer.masksToBounds = false
        //Block View
        BlockView.layer.cornerRadius = 12
        BlockView.layer.masksToBounds = true;
        BlockView.backgroundColor = UIColor.white
        BlockView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        BlockView.layer.shadowOpacity = 0.8
        BlockView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        BlockView.layer.shadowRadius = 6.0
        BlockView.layer.masksToBounds = false
        
        //callnowbtn radius
        callnowbtn.layer.cornerRadius = 10
        callnowbtn.layer.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
        //Unfreeze UISwitch
        
        Blkbtn.layer.cornerRadius = 8
        cancelbtn.layer.cornerRadius = 8
        //Tap on Help label
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreditcardVC.HelplbltapFunction))
           helplbl.isUserInteractionEnabled = true
           helplbl.addGestureRecognizer(tap)
        //Freeze label data
        freezelbl.text = "Freeze"
        managecardlbl.text = "Manage Card"
        //Alert view
        
        frozenalertView.layer.cornerRadius = 20
        frozenalertView.layer.masksToBounds = true;
        frozenalertView.backgroundColor = UIColor.white
        frozenalertView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        frozenalertView.layer.shadowOpacity = 0.99
        frozenalertView.layer.shadowOffset = CGSize(width: 30.0, height: 30.0)
        frozenalertView.layer.shadowRadius = 30
        frozenalertView.layer.masksToBounds = false
        
        //disable card radius color code
        disablecard.layer.cornerRadius = 20
        disablecard.layer.masksToBounds = true;
        disablecard.backgroundColor = UIColor.white
        disablecard.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        disablecard.layer.shadowOpacity = 0.99
        disablecard.layer.shadowOffset = CGSize(width: 30.0, height: 30.0)
        disablecard.layer.shadowRadius = 30
        disablecard.layer.masksToBounds = false
        //GotITbtn radius and border color
        GotITbtn.layer.cornerRadius = 10
        GotITbtn.layer.borderWidth = 2.0
        GotITbtn.layer.borderColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
        // image action code
        let tapcancelimage = UITapGestureRecognizer(target: self, action: #selector(CreditcardVC.tappedMe))
        cancelimg.addGestureRecognizer(tapcancelimage)
        cancelimg.isUserInteractionEnabled = true
        //freezetxtbckview radius and color
        freezetxtbckview.layer.cornerRadius = 5.0
    }
    @objc func switchStateChanged(_ mjSwitch: MJMaterialSwitch) {
        print("on",mjSwitch.isOn)
           if (mjSwitch.isOn == true){
               //sender.setOn(true, animated: false)
               print("Switched on")
               freezelbl.text = "Freeze"
               freezebckview.isHidden = true
               freezetxtbckview.isHidden = true
               view.backgroundColor = UIColor.white
               UnfreezeView.backgroundColor = UIColor.white
               BlockView.backgroundColor = UIColor.white
               freezelbl.backgroundColor = UIColor.white
               blocktxtlbl.backgroundColor = UIColor.white
               freezecreditcrdlbl.backgroundColor = UIColor.white
               blockcredictcardlbl.backgroundColor = UIColor.white
               
           }
           else{
               print("Switched off")
               freezelbl.text = "Unfreeze"
               freezetxtbckview.isHidden = false
               freezebckview.isHidden = false
               freezetxtbckview.backgroundColor = #colorLiteral(red: 1, green: 0.937254902, blue: 0.7490196078, alpha: 1)
//               freezenexttransactionlbl.text = "Your card is frozen temporarily please click unfreeze to use it for your next transaction"
               let FreezefirstWord   = "Your card is frozen temporarily please click"
                   let FreezesecondWord = " UnFreeze"
               let Freezethirdword = " to use it for your next transaction"
                   let comboWord = FreezefirstWord + FreezesecondWord + Freezethirdword
                   let attributedText = NSMutableAttributedString(string:comboWord)
               let attrs      =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]
               let range = NSString(string: comboWord).range(of: FreezesecondWord)
                   attributedText.addAttributes(attrs, range: range)
               freezenexttransactionlbl.attributedText = attributedText
               freezenexttransactionlbl.textColor = #colorLiteral(red: 0.3882352941, green: 0.2, blue: 0.01176470588, alpha: 1)
               freezenexttransactionlbl.backgroundColor = #colorLiteral(red: 1, green: 0.937254902, blue: 0.7490196078, alpha: 1)
               switch2.isHidden = false
               self.switch2.addTarget(self, action: #selector(BlockswithcStateChanged(_:)), for: UIControl.Event.valueChanged)
               self.switch2.tag = 1
               frozenalertView.isHidden = false

           }
       }
        
    @objc func BlockswithcStateChanged(_ mjSwitch: MJMaterialSwitch) {
    print("block on",mjSwitch.isOn)
    if (mjSwitch.isOn == true){
    freezetxtbckview.isHidden = false
        freezebckview.isHidden = false
    frozenalertView.isHidden = true
    }
    else{
    freezetxtbckview.isHidden = true
        freezebckview.isHidden = true
    frozenalertView.isHidden = false
    headerview.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    UnfreezeView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    BlockView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    freezelbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    blocktxtlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    freezecreditcrdlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    blockcredictcardlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)

    }
}
        
    @objc func HelplbltapFunction(sender:UITapGestureRecognizer) {
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        freezebckview.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        cardbckview.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        switch1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        switch2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        headerview.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        UnfreezeView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        BlockView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        freezelbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        blocktxtlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        freezecreditcrdlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        blockcredictcardlbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        Bottompopupview.roundCorners(corners: [.topLeft,.topRight], radius: 25)
        Bottompopupview.isHidden = false
    }
    
    //image action
    @objc func tappedMe()
    {
        headerview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        freezebckview.backgroundColor = UIColor.white
        cardbckview.backgroundColor = UIColor.white
        UnfreezeView.backgroundColor = UIColor.white
        BlockView.backgroundColor = UIColor.white
        freezelbl.backgroundColor = UIColor.white
        blocktxtlbl.backgroundColor = UIColor.white
        freezecreditcrdlbl.backgroundColor = UIColor.white
        blockcredictcardlbl.backgroundColor = UIColor.white
        Bottompopupview.isHidden = true
        switch1.backgroundColor = UIColor.white
        switch2.backgroundColor = UIColor.white
    }
    @IBAction func okgotitbtnclk(_ sender: Any) {
        frozenalertView.isHidden = true
        disablecard.isHidden = false
    }
    
    @IBAction func Blockbtnclk(_ sender: Any) {
        view.backgroundColor = UIColor.white
        UnfreezeView.backgroundColor = UIColor.white
        BlockView.backgroundColor = UIColor.white
        freezelbl.backgroundColor = UIColor.white
        blocktxtlbl.backgroundColor = UIColor.white
        freezecreditcrdlbl.backgroundColor = UIColor.white
        blockcredictcardlbl.backgroundColor = UIColor.white
        frozenalertView.isHidden = true
        disablecard.isHidden = true
        UnfreezeView.isHidden = true
        BlockView.isHidden = true
        helplbl.isHidden = true
        freezetxtbckview.isHidden = false
        freezebckview.isHidden = false
        freezetxtbckview.backgroundColor = .white
        let BlockfirstWord   = "Your card is "
            let BlocksecondWord = " Blocked"
        let Blockthirdword = " permenantly"
            let BlockcomboWord = BlockfirstWord + BlocksecondWord + Blockthirdword
            let BlockattributedText = NSMutableAttributedString(string:BlockcomboWord)
        let Blockattrs      =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]
        let Blockrange = NSString(string: BlockcomboWord).range(of: BlocksecondWord)
        BlockattributedText.addAttributes(Blockattrs, range: Blockrange)
        freezenexttransactionlbl.attributedText = BlockattributedText
        freezenexttransactionlbl.layer.cornerRadius = 6.0
        freezenexttransactionlbl.layer.masksToBounds = true
        freezenexttransactionlbl.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6509803922, blue: 0.6274509804, alpha: 1)
        freezenexttransactionlbl.textColor = #colorLiteral(red: 0.3882352941, green: 0.2, blue: 0.01176470588, alpha: 1)
        managecardlbl.text = "Need Help? Call Us"
        managecardlbl.textColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
    }
    
    //Cardholoder loading data
    
    func CardholderloadingAPI()
    {
        let mobile = "91" + "9553397941"
        let sdkAuthToken = "F9123xyzzxsfswgsfdf"
        let primaryOrgId = "220201024103605ID1OID6004160"
        let CarholderloginString = "\(mobile):\(sdkAuthToken):\(primaryOrgId)"
        let loginData = CarholderloginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: [String: Any] = ["mobile": "91" + "9876500061", "sdkAuthToken": "F9123xyzzxsfswgsfdf", "primaryOrgId": "220201024103605ID1OID6004160"]
        // create the url with URL
        let url = URL(string: CardholderloginAPI.services)!
        // create the session object
        let session = URLSession.shared
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        customActivityIndicatory(view, startAnimate: true)
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        request.httpMethod = "POST" //set http method as POST
//        customActivityIndicatory(view, startAnimate: true)
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          // convert parameters to Data and assign dictionary to httpBody of request
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          return
        }
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
          
          if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            return
          }
          // ensure there is valid response code returned from this HTTP response
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
          else {
            print("Invalid Response received from the server")
            return
          }
          // ensure there is data returned
          guard let responseData = data else {
            print("nil Data received from the server")
            return
          }
          do {
            // create json object from data or use JSONDecoder to convert to Model stuct
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
              print("Response data...",jsonResponse)
                var customerDic = jsonResponse["customer"]! as! NSDictionary
                var loginRetrivedData = CardholderLoginmodel()
                loginRetrivedData.mobilenumstr = customerDic["mobile"]! as! String
                print("model string values",loginRetrivedData.mobilenumstr)
                loginRetrivedData.cardHoldername = customerDic["nameOnCard"]! as! String
                print("model string values",loginRetrivedData.cardHoldername)
                DispatchQueue.main.async {
                    self.cardholderlbl.text = loginRetrivedData.cardHoldername
                    self.Freezecardholderlbl.text = loginRetrivedData.cardHoldername
                }
                let cardListArray = jsonResponse["cards"] as! Array<Any>
                print("cardListArray...",cardListArray)

                for Dic in cardListArray as! [[String:Any]]
                    {
                    
                    DispatchQueue.main.async { [self] in
                        loginRetrivedData.lastFourDigits = Dic["lastFourDigits"] as! String
                        print("Last 4 digits string values",loginRetrivedData.lastFourDigits)
                        loginRetrivedData.cardMode = Dic["cardMode"] as! String
                        self.Last4digittxtfld.text = loginRetrivedData.lastFourDigits
                        self.FreezeLast4digittxtfld.text = loginRetrivedData.lastFourDigits
                        //self.managecardlbl.text = loginRetrivedData.cardMode
                        customActivityIndicatory(self.view, startAnimate: false)
                    }
                }
            } else {
              print("data maybe corrupted or in wrong format")
              throw URLError(.badServerResponse)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
        // perform the task
        task.resume()
        
}
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
        viewBackgroundLoading.backgroundColor =  #colorLiteral(red: 0.05882352941, green: 0.3764705882, blue: 0.9137254902, alpha: 1)
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




