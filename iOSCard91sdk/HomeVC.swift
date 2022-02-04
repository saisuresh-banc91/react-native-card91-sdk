//
//  HomeVC.swift
//  iOSCard91sdk
//
//  Created by Card91 on 27/12/21.
//

import UIKit

//------Status Bar Extention-----//
//extension UIApplication {
//    var statusBarView: UIView? {
//        return value(forKey: "statusBar") as? UIView
//    }
//

//}


extension String
{
    var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray
                {
                    print(jsonResult)
                    return jsonResult //Will return the json array output
                }
                else
                {
                    return nil
                }
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else
        {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}

final class HomeVCToMobileOTPVCShared {
     static let Sharedstringvariables = HomeVCToMobileOTPVCShared() //lazy init, and it only runs once
     var cardid : String!
}

class HomeVC: UIViewController {
    var RetrivedClientIdstr = String()
    var Retrivedtoken = String()
    var Retrivedmobilenumberstr = String()
    var cardHolderNamestr = String()
    var last4Digitstr = String()
    var Exncardidstr = String()
    var toPassBlock = String()
    var OTPstatusstrmessage = String()
    var loststr = String()
    var stolenstr = String()
    var Retrivedblockcard = String()

    var TxnMainDict:NSMutableDictionary = NSMutableDictionary()
    var WalletMainDict:NSMutableDictionary = NSMutableDictionary()
    var TxnListArray:NSMutableArray = NSMutableArray()
    var smartWalletArray:NSMutableArray = NSMutableArray()
    let cellReuseIdentifier = "smartwallettblcell"
    
    
    @IBOutlet weak var settingbtn: UIButton!
    
    @IBOutlet weak var smartWallettbl: UITableView!
    @IBOutlet weak var transactiontbl: UITableView!
    @IBOutlet weak var smart: UITableView!
    @IBOutlet weak var cardNumbertxt: UITextField!
    @IBOutlet weak var crdnumtf1: UITextField!
    @IBOutlet weak var crdnumtf2: UITextField!
    @IBOutlet weak var crdnumtf3: UITextField!
    @IBOutlet weak var crdnumtf4: UITextField!
    //Foreground Card Services Outlets
    @IBOutlet weak var detailscard: UIView!
    @IBOutlet weak var changepincard: UIView!
    @IBOutlet weak var freezecard: UIView!
    @IBOutlet weak var blockcard: UIView!
    //Background card services outlets
    @IBOutlet weak var Bckdetailscard: UIView!
    @IBOutlet weak var Bckchangepincard: UIView!
    @IBOutlet weak var Bckfreezecard: UIView!
    @IBOutlet weak var Bckblockcard: UIView!
    @IBOutlet weak var BottmscrollBckview: UIView!
    @IBOutlet weak var smartBalletbckview: UIView!
    @IBOutlet weak var transactionBckview: UIView!
    @IBOutlet weak var detailslbl: UILabel!
    @IBOutlet weak var changecardPinlbl: UILabel!
    @IBOutlet weak var freezelbl: UILabel!
    @IBOutlet weak var blocklbl: UILabel!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var drpdwntbl: UITableView!
    @IBOutlet weak var drpdwntblbckview: UIView!
    @IBOutlet weak var cardholdernamelbl: UILabel!
    
    
    //BlockPopup Properties
    
    @IBOutlet weak var PopupBackview: UIView!
    @IBOutlet weak var Popupcancelbtn: UIButton!
    @IBOutlet weak var Popupblockbtn: UIButton!
    @IBOutlet weak var Lostbtn: UIButton!
    @IBOutlet weak var Stolenbtn: UIButton!
    
    //Permanentblock properties
    @IBOutlet weak var PermenantblockBckview: UIView!
    
    @IBOutlet weak var blockcrdtxtnum1: UITextField!
    
    @IBOutlet weak var blockcrdtxtnum2: UITextField!
    
    @IBOutlet weak var blockcrdtxtnum3: UITextField!
    
    @IBOutlet weak var blockcrdtxtnum4: UITextField!
    
    @IBOutlet weak var blockcardholderlbl: UILabel!
    
    @IBOutlet weak var AlertblockBckview: UIView!
    
    @IBOutlet weak var blockAlerttextlbl: UILabel!
    var DatedrpdwnArray: [String] = ["Today", "Last 7 days", "Month"]

    //Freeze Properties
    
    @IBOutlet weak var FreezeAlertview: UIView!
    
    @IBOutlet weak var FreezeAlerttextlbl: UILabel!
    
    @IBOutlet weak var freezeAlertokbtn: UIButton!
    
    //Custom segment code
    private enum Constants {
        static let segmentedControlHeight: CGFloat = 50
        static let underlineViewColor: UIColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
                                                               
        static let underlineViewHeight: CGFloat = 2
    }

    // Container view of the segmented control
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    // Customised segmented control
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()

        // Remove background and divider colors
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = .white
        // Append segments
        segmentedControl.insertSegment(withTitle: "Smart Wallets", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Transactions", at: 1, animated: true)
        //segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        // Select first segment by default
        segmentedControl.selectedSegmentIndex = 0

        // Change text color and the font of the NOT selected (normal) segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)

        // Change text color and the font of the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .selected)

        // Set up event handler to get notified when the selected segment changes
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        // Return false because we will set the constraints with Auto Layout
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    // The underline view below the segmented control
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = Constants.underlineViewColor
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    
    
    //otp Verification screen class

    public class mobileOTPVC{
        public init(){}
        public func viewController() -> MobileOTPVC{
            let bundle = Bundle(for: MobileOTPVC.self)
            let mobileOTPVC = MobileOTPVC(nibName: "MobileOTPVC", bundle: bundle)
            return mobileOTPVC
        }

    }
    
    
    //Setting screen class
    public class settingVC{
        public init(){}
        public func viewController() -> SettingVC{
            let bundle = Bundle(for: SettingVC.self)
            let settingVC = SettingVC(nibName: "SettingVC", bundle: bundle)
            return settingVC
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        customActivityIndicatory(self.view, startAnimate: false)

        
//smartwallettble.register(UINib(nibName: "smartwallettblcell", bundle: nil), forCellReuseIdentifier: "smartwallettblcell")
        
        self.smartWallettbl.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        smartWallettbl.delegate = self
        smartWallettbl.dataSource = self
        drpdwntbl.delegate = self
        drpdwntbl.dataSource = self

        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        crdnumtf1.isSecureTextEntry = !crdnumtf1.isSecureTextEntry
        crdnumtf2.isSecureTextEntry = !crdnumtf2.isSecureTextEntry
        crdnumtf3.isSecureTextEntry = !crdnumtf3.isSecureTextEntry
        
        blockcrdtxtnum1.isSecureTextEntry = !blockcrdtxtnum1.isSecureTextEntry
        blockcrdtxtnum2.isSecureTextEntry = !blockcrdtxtnum2.isSecureTextEntry
        blockcrdtxtnum3.isSecureTextEntry = !blockcrdtxtnum3.isSecureTextEntry
        //Foreground UIView card
        //details card border color effect
        self.detailscard.layer.cornerRadius = self.detailscard.bounds.height / 2
        detailscard.clipsToBounds = false
        detailscard.layer.shadowColor = UIColor.gray.cgColor
        detailscard.layer.shadowOpacity = 3
        detailscard.layer.shadowOffset = CGSize.zero
        detailscard.layer.shadowRadius = 1
        
        //changepincard card border color effect
        self.changepincard.layer.cornerRadius = self.changepincard.bounds.height / 2
        changepincard.clipsToBounds = false
        changepincard.layer.shadowColor = UIColor.gray.cgColor
        changepincard.layer.shadowOpacity = 3
        changepincard.layer.shadowOffset = CGSize.zero
        changepincard.layer.shadowRadius = 1
       
        //freezecard card border color effect
        self.freezecard.layer.cornerRadius = self.freezecard.bounds.height / 2
        freezecard.clipsToBounds = false
        freezecard.layer.shadowColor = UIColor.gray.cgColor
        freezecard.layer.shadowOpacity = 3
        freezecard.layer.shadowOffset = CGSize.zero
        freezecard.layer.shadowRadius = 1
       
       
        //blockcard card border color effect
        
        self.blockcard.layer.cornerRadius = self.blockcard.bounds.height / 2
        blockcard.clipsToBounds = false
        blockcard.layer.shadowColor = UIColor.gray.cgColor
        blockcard.layer.shadowOpacity = 3
        blockcard.layer.shadowOffset = CGSize.zero
        blockcard.layer.shadowRadius = 1
        
        
        
        
        
        //Background card Outlets
        //details card border color effect
        self.Bckdetailscard.layer.cornerRadius = self.Bckdetailscard.bounds.height / 2
        Bckdetailscard.clipsToBounds = false
        Bckdetailscard.layer.shadowColor = UIColor.gray.cgColor
        Bckdetailscard.layer.shadowOpacity = 3
        Bckdetailscard.layer.shadowOffset = CGSize.zero
        Bckdetailscard.layer.shadowRadius = 1
        
        //changepincard card border color effect
        self.Bckchangepincard.layer.cornerRadius = self.Bckchangepincard.bounds.height / 2
        Bckchangepincard.clipsToBounds = false
        Bckchangepincard.layer.shadowColor = UIColor.gray.cgColor
        Bckchangepincard.layer.shadowOpacity = 3
        Bckchangepincard.layer.shadowOffset = CGSize.zero
        Bckchangepincard.layer.shadowRadius = 1
       
        //freezecard card border color effect
        self.Bckfreezecard.layer.cornerRadius = self.Bckfreezecard.bounds.height / 2
        Bckfreezecard.clipsToBounds = false
        Bckfreezecard.layer.shadowColor = UIColor.gray.cgColor
        Bckfreezecard.layer.shadowOpacity = 3
        Bckfreezecard.layer.shadowOffset = CGSize.zero
        Bckfreezecard.layer.shadowRadius = 1
       
       
        //blockcard card border color effect
        
        self.Bckblockcard.layer.cornerRadius = self.Bckblockcard.bounds.height / 2
        Bckblockcard.clipsToBounds = false
        Bckblockcard.layer.shadowColor = UIColor.gray.cgColor
        Bckblockcard.layer.shadowOpacity = 3
        Bckblockcard.layer.shadowOffset = CGSize.zero
        Bckblockcard.layer.shadowRadius = 1
        
    
        
        //Bottom scroll view  border color effect
        smartBalletbckview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        transactionBckview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //Hide and Show Background views
        smartBalletbckview.isHidden = false
        transactionBckview.isHidden = true
        drpdwntbl.isHidden = true
        drpdwntblbckview.isHidden = true
        PopupBackview.isHidden = true
        PermenantblockBckview.isHidden = true
        FreezeAlertview.isHidden = true


        self.BottmscrollBckview.layer.cornerRadius = 10
        BottmscrollBckview.clipsToBounds = false
        BottmscrollBckview.layer.shadowColor = UIColor.darkGray.cgColor
        BottmscrollBckview.layer.shadowOpacity = 3
        BottmscrollBckview.layer.shadowOffset = CGSize.zero
        BottmscrollBckview.layer.shadowRadius = 2
        
        //Dropdown Back view shadow color code
        drpdwntblbckview.layer.cornerRadius = 1
        drpdwntblbckview.layer.masksToBounds = true;
        drpdwntblbckview.backgroundColor = UIColor.white
        drpdwntblbckview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        drpdwntblbckview.layer.shadowOpacity = 0.4
        drpdwntblbckview.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        drpdwntblbckview.layer.shadowRadius = 5
        drpdwntblbckview.layer.masksToBounds = false
        
        
        //Popup BackView corner radius
        PopupBackview.layer.cornerRadius = 10.0
        PopupBackview.layer.masksToBounds = true;
        PopupBackview.backgroundColor = UIColor.white
        PopupBackview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        PopupBackview.layer.shadowOpacity = 0.9
        PopupBackview.layer.shadowOffset = CGSize(width: 15.0, height: 15.0)
        PopupBackview.layer.shadowRadius = 5
        PopupBackview.layer.masksToBounds = false
        //Popup cancel and block button corner radius code
        Popupblockbtn.layer.cornerRadius = 10.0
        Popupcancelbtn.layer.cornerRadius = 10.0
        
        
        //Filter Label

        filterlbl.layer.cornerRadius = 3
        filterlbl.layer.borderWidth = 1.0
        filterlbl.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
        //Filter Label Action method call
        let Filterlbltap = UITapGestureRecognizer(target: self, action: #selector(HomeVC.FilterlbltapFunction))
                filterlbl.isUserInteractionEnabled = true
                filterlbl.addGestureRecognizer(Filterlbltap)
        
        
        //Custom segment controller code
        
        // Add subviews to the view hierarchy
        // (both segmentedControl and bottomUnderlineView are subviews of the segmentedControlContainerView)
        BottmscrollBckview.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segmentedControl)
        segmentedControlContainerView.addSubview(bottomUnderlineView)

        // Constrain the container view to the view controller
        let safeLayoutGuide = self.BottmscrollBckview.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor, constant: 0),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: safeLayoutGuide.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: safeLayoutGuide.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
            ])

        // Constrain the segmented control to the container view
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
            ])

        // Constrain the underline view relative to the segmented control
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
            ])
       
        //Change card Pin UILabel Action
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.ChangePincardAction))
        self.changepincard.addGestureRecognizer(gesture)
        
        //Freeze Action method calling...
        let Freezegesture = UITapGestureRecognizer(target: self, action:  #selector(self.FreezeAction))
        self.freezecard.addGestureRecognizer(Freezegesture)
        //Blok Action method calling...
        let Blockgesture = UITapGestureRecognizer(target: self, action:  #selector(self.BlockAction))
        self.blockcard.addGestureRecognizer(Blockgesture)
        
        
        //Tableview
        let bundle = Bundle(for: type(of: self))
        smartWallettbl.register(UINib(nibName: "smartwallettblcell", bundle: bundle), forCellReuseIdentifier: "smartwallettblcell")
        
        
        transactiontbl.register(UINib(nibName: "transactioncell", bundle: bundle), forCellReuseIdentifier: "transactioncell")
        
        drpdwntbl.register(UINib(nibName: "Drodwncell", bundle: bundle), forCellReuseIdentifier: "Drodwncell")
        //Tableview row height
        //self.smartWallettbl.rowHeight = 60
        
        transactiontbl.estimatedRowHeight = 60
        transactiontbl.rowHeight = UITableView.automaticDimension

        
        //Block card Perminantly code
        
        Retrivedblockcard = BlockcardShared.Sharedblockcard.blockcardstr ?? ""
        if(Retrivedblockcard == "Blockcard")
        {
            Bckchangepincard.isHidden = true
            Bckfreezecard.isHidden = true
            Bckblockcard.isHidden = true
            changecardPinlbl.isHidden = true
            freezelbl.isHidden = true
            blocklbl.isHidden = true
            PermenantblockBckview.isHidden = false
            blockcardholderlbl.isHidden = false
            blockcrdtxtnum4.isHidden = false
            AlertblockBckview.layer.cornerRadius = 6.0
            
            
            let blockfirstWord   = "  Your card is been"
                let blocksecondWord = " . blocked permanently"
                let comboWord = blockfirstWord + blocksecondWord
                let attributedText = NSMutableAttributedString(string:comboWord)
            let attrs      =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]
            let range = NSString(string: comboWord).range(of: blocksecondWord)
                attributedText.addAttributes(attrs, range: range)
            blockAlerttextlbl.attributedText = attributedText
            blockAlerttextlbl.textColor = #colorLiteral(red: 0.6431372549, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
            AlertblockBckview.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
            settingbtn.isHidden = true
            
            
            

        }
        else
        {
            Bckchangepincard.isHidden = false
            Bckfreezecard.isHidden = false
            Bckblockcard.isHidden = false
            changecardPinlbl.isHidden = false
            freezelbl.isHidden = false
            blocklbl.isHidden = false
            PermenantblockBckview.isHidden = true
        }
        
        
        //Calling ListingcardAPI Method
        CardListingAPI()
        TransactionAPI()

        
    }
    
    
    @objc
        func FilterlbltapFunction(sender:UITapGestureRecognizer) {
            print(" FilterlbltapFunction tap working")
            drpdwntblbckview.isHidden = false
            drpdwntbl.isHidden = false
            
        }
    
    //********ListingCardAPI********//
    @objc func ChangePincardAction(sender : UITapGestureRecognizer) {
        
        let GotoMobileOTPVC = mobileOTPVC()
        let VC = GotoMobileOTPVC.viewController()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
   
    //Freeze Action code
    @objc func FreezeAction(sender : UITapGestureRecognizer) {
        PermenantblockBckview.isHidden = false
        PermenantblockBckview.layer.cornerRadius = 6.0
        freezelbl.text = "UnFreeze"
        freezelbl.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        freezelbl.layer.cornerRadius = 6.0

        let FreezefirstWord   = "Your card is frozen temporarily please click"
            let FreezesecondWord = " UnFreeze"
        let Freezethirdword = " to use it for your next transaction"
            let comboWord = FreezefirstWord + FreezesecondWord + Freezethirdword
            let attributedText = NSMutableAttributedString(string:comboWord)
        let attrs      =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.red]
        let range = NSString(string: comboWord).range(of: FreezesecondWord)
            attributedText.addAttributes(attrs, range: range)
        blockAlerttextlbl.attributedText = attributedText
        blockAlerttextlbl.textColor = #colorLiteral(red: 0.3882352941, green: 0.2, blue: 0.01176470588, alpha: 1)
        AlertblockBckview.backgroundColor = #colorLiteral(red: 1, green: 0.937254902, blue: 0.7490196078, alpha: 1)
        settingbtn.isHidden = true
        FreezeAlertview.isHidden = false
        FreezeAlertview.layer.cornerRadius = 10.0
        FreezeAlertview.layer.masksToBounds = true;
        FreezeAlertview.backgroundColor = UIColor.white
        FreezeAlertview.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        FreezeAlertview.layer.shadowOpacity = 0.9
        FreezeAlertview.layer.shadowOffset = CGSize(width: 15.0, height: 15.0)
        FreezeAlertview.layer.shadowRadius = 5
        FreezeAlertview.layer.masksToBounds = false
        freezeAlertokbtn.layer.cornerRadius = 20
        freezeAlertokbtn.layer.borderWidth = 1.0
        freezeAlertokbtn.layer.borderColor = #colorLiteral(red: 0.4, green: 0.2980392157, blue: 0.7058823529, alpha: 1)
        let FreezeAlertfirstWord   = "Please click"
            let FreezeAlertsecondWord = " UnFreeze"
        let FreezeAlertthirdword = " any time to Unlock the card"
            let FreezecomboWord = FreezeAlertfirstWord + FreezeAlertsecondWord + FreezeAlertthirdword
            let FreezeattributedText = NSMutableAttributedString(string:FreezecomboWord)
        let Freezeattrs      =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let Freezerange = NSString(string: FreezecomboWord).range(of: FreezesecondWord)
        FreezeattributedText.addAttributes(Freezeattrs, range: Freezerange)
        FreezeAlerttextlbl.attributedText = FreezeattributedText

    }
    //Block Action code
    @objc func BlockAction(sender : UITapGestureRecognizer) {
        PopupBackview.isHidden = false
    }
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeSegmentedControlLinePosition()
        if segmentedControl.selectedSegmentIndex == 0 {
            segmentedControl.backgroundColor = .white
               print("Select 0")
            smartBalletbckview.isHidden = false
            transactionBckview.isHidden = true
            
           } else if segmentedControl.selectedSegmentIndex == 1 {
               print("Select 1")
               smartBalletbckview.isHidden = true
               transactionBckview.isHidden = false
           }
    }

    @IBAction func Settingbtnclk(_ sender: Any) {
        let GotoSettingVC = settingVC()
        let VC = GotoSettingVC.viewController()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtnclk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            //self?.layoutIfNeeded()
        })
    }

    
    //Popup Lost and Stolen Action's
    
    @IBAction func Lostbtnclk(_ sender: UIButton) {
        
        if !Lostbtn.isSelected {
            Lostbtn.isSelected = true
            Lostbtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            Lostbtn.setImage(UIImage(systemName: "record.circle"), for: .normal)
            Stolenbtn.setImage(UIImage(systemName: "circle"), for: .normal)
            Lostbtn.backgroundColor = .white
            Stolenbtn.backgroundColor = .white
            
            loststr = "LOSS"
            }
        if Lostbtn.isSelected {
            Lostbtn.isSelected = false
            Lostbtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            Lostbtn.setImage(UIImage(systemName: "record.circle"), for: .normal)
            Stolenbtn.setImage(UIImage(systemName: "circle"), for: .normal)
            Lostbtn.backgroundColor = .white
            Stolenbtn.backgroundColor = .white
            loststr = "LOSS"
            }
        
    }
    
    @IBAction func Stolenbtnclk(_ sender: UIButton) {
        if !Stolenbtn.isSelected {
            Stolenbtn.isSelected = false
            Stolenbtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            Stolenbtn.setImage(UIImage(systemName: "record.circle"), for: .normal)
            Lostbtn.setImage(UIImage(systemName: "circle"), for: .normal)
            Lostbtn.backgroundColor = .white
            Stolenbtn.backgroundColor = .white
            stolenstr = "STOLEN"

            }
        
        
        if Stolenbtn.isSelected {
            Stolenbtn.isSelected = true
            Stolenbtn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            Stolenbtn.setImage(UIImage(systemName: "record.circle"), for: .normal)
            Lostbtn.setImage(UIImage(systemName: "circle"), for: .normal)
            Lostbtn.backgroundColor = .white
            Stolenbtn.backgroundColor = .white
            stolenstr = "STOLEN"

            }
        
    }
    //Popup cancel and block button Action's
    
    @IBAction func Popupcancelbtnclk(_ sender: Any) {
        PopupBackview.isHidden = true
    }
    
    
    
        
    func CardListingAPI()
    {
        
        Retrivedtoken = Shared.Sharedstringvariables.tokenshared
        print("Retrived token values",Retrivedtoken)
        Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
        print("Retrived mobilenumber value",Retrivedmobilenumberstr)
        RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared
        print("Retrived client value",RetrivedClientIdstr)

        let url = URL(string: CustomerListingcardAPI.services)
        customActivityIndicatory(self.view, startAnimate: true)

        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                
            let cardListArray = convertedJsonIntoDict["cardList"] as! Array<Any>
            for Dic in cardListArray as! [[String:Any]]
                {
                
                DispatchQueue.main.async {
                customActivityIndicatory(self.view, startAnimate: false)
                }
                var Listingcard_modeldata = Listingcardsmodel()
                let cardDic = Dic["card"] as! Dictionary<String, Any>
                Listingcard_modeldata.cardHolderNamestr = cardDic["cardHolderName"] as! String
                Listingcard_modeldata.last4Digitstr = cardDic["last4Digit"] as! String
                Exncardidstr = cardDic["id"] as! String
                cardHolderNamestr = Listingcard_modeldata.cardHolderNamestr
                last4Digitstr = Listingcard_modeldata.last4Digitstr

            }
            DispatchQueue.main.async {
                       
                smartWalletListAPI()
                cardholdernamelbl.text = cardHolderNamestr
                crdnumtf4.text = last4Digitstr
                blockcardholderlbl.text = cardHolderNamestr
                blockcrdtxtnum4.text = last4Digitstr
            }
          
        }
    } catch let error as NSError {
                       print(error.localizedDescription)
      }
                
    }
   }
        task.resume()
 }




func TransactionAPI()
{
    
    Retrivedtoken = Shared.Sharedstringvariables.tokenshared
    Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
    RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared
    let url = URL(string: TransactionlistAPI.services)
    guard let requestUrl = url else { fatalError() }
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
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
        let txnsArray = convertedJsonIntoDict["txns"] as! Array<Any>
                for Dic in txnsArray as! [[String:Any]]
                {
            var TxnMainDict:NSMutableDictionary = NSMutableDictionary()
                    var TransactionList_modeldata = Transactionlistmodel()

                    TransactionList_modeldata.merchantNamestr = Dic["merchantName"] as! String
                    TransactionList_modeldata.amountstr = Dic["amount"] as! String
                    TransactionList_modeldata.walletnamestr = Dic["txnType"] as! String
                    TransactionList_modeldata.Datestr = Dic["createdAt"] as! String
                    TransactionList_modeldata.txnStatusstr = Dic["txnStatus"] as! String
                    //TransactionList_modeldata.cardidstr = Dic["cardId"] as! String
                    //Exncardidstr = Dic["cardId"] as! String
                TxnMainDict.setObject(TransactionList_modeldata.merchantNamestr, forKey: "merchantName" as NSCopying)
                    TxnMainDict.setObject(TransactionList_modeldata.amountstr, forKey: "amount" as NSCopying)
                    TxnMainDict.setObject(TransactionList_modeldata.walletnamestr, forKey: "txnType" as NSCopying)
                    TxnMainDict.setObject(TransactionList_modeldata.Datestr, forKey: "createdAt" as NSCopying)
                    TxnMainDict.setObject(TransactionList_modeldata.txnStatusstr, forKey: "txnStatus" as NSCopying)

                        self.TxnListArray.add(TxnMainDict)
                        print("TxnListArray array",self.TxnListArray)
                    
                   
                                                        }
                                        DispatchQueue.main.async {
                                            //smartWalletListAPI()
                                        self.TxnListArray.add(self.TxnMainDict)
                                        self.transactiontbl.reloadData()
                                        }
                    
        } else {
            print("bad json")
        }
    } catch let error as NSError {
        print(error)
    }
}
}
task.resume()
}
    
    func smartWalletListAPI()
    {
        print("calling here ",Exncardidstr)
        
        Retrivedtoken = Shared.Sharedstringvariables.tokenshared
        Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
        RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared

       let url = URL(string: getCardApplicationsAPI.services + "\(Exncardidstr)")
        //let url = URL(string: getCardApplicationsAPI.services + "\("220110051416199ID1CARD4884232")")

        
        print("walleturl",url)

        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
            let applicationsArray = convertedJsonIntoDict["applications"] as! Array<Any>
                    for Dic in applicationsArray as! [[String:Any]]
                    {
                var WalletMainDict:NSMutableDictionary = NSMutableDictionary()
                        var wallet_modeldata = smartwallet_getapplicationmodel()

                        wallet_modeldata.namestr = Dic["name"] as! String
                        
                        WalletMainDict.setObject(wallet_modeldata.namestr, forKey: "name" as NSCopying)
                        wallet_modeldata.balance = Dic["balance"] as! String

                        WalletMainDict.setObject(wallet_modeldata.balance, forKey: "balance" as NSCopying)
                        
                            self.smartWalletArray.add(WalletMainDict)
                            print("smartWalletArray array",self.smartWalletArray)
                        
                       
                                                            }
                                            DispatchQueue.main.async {
                                            self.smartWalletArray.add(self.WalletMainDict)
                                            self.smartWallettbl.reloadData()
                                            }
                        
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    }
    task.resume()
    }
    
    
    @IBAction func PopupBlockbtnclk(_ sender: Any) {

//        var LossorStolenstr = String()
//        var Constantlossstr = String()
//        Constantlossstr = "LOSS"
//        if (loststr == "LOSS" )
//        {
//            LossorStolenstr = loststr
//            print("loss...",LossorStolenstr)
//        }
//        else if (stolenstr == "STOLEN")
//        {
//            LossorStolenstr = stolenstr
//            print("stolen...",LossorStolenstr)
//        }
//        else
//        {
//            print("static contant variable",Constantlossstr)
//
//        }
        

        print("Block button clk")
        Retrivedtoken = Shared.Sharedstringvariables.tokenshared
        print("otpsend Retrived token values",Retrivedtoken)
        Retrivedmobilenumberstr = Shared.Sharedstringvariables.mobilenumbershared
        print("Retrived mobilenumber value",Retrivedmobilenumberstr)
        RetrivedClientIdstr = Shared.Sharedstringvariables.clientidshared
        print("Retrived client value",RetrivedClientIdstr)


        print("sendotp service " + sendotpAPI.services)
        print("global Calling Prelive login service from class is " + sendotpAPI.services)

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
            //request.setValue( "Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
            //request.setValue(clientId, forHTTPHeaderField: "X-Client-Id")
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



                            let GotoMobileOTPVC = mobileOTPVC()
                            var mPINstr = String.self

                            let VC = GotoMobileOTPVC.viewController()
                            UserDefaults.standard.set("Block", forKey: "blockkey") //setObject


//                            var defaults = UserDefaults(suiteName: "group.com.seligmanventures.LightAlarmFree")
//                            UserDefaults.standard.set(jwt_token, forKey: "Refreshtoken")
//
//                            Shared.Sharedstringvariables.tokenshared = jwt_token
//
                            HomeVCToMobileOTPVCShared.Sharedstringvariables.cardid = Exncardidstr
                            VC.toPassBlock = "Block"


                            VC.modalPresentationStyle = .fullScreen
                            self.present(VC, animated: true, completion: nil)


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

    
    extension HomeVC:UITableViewDelegate,UITableViewDataSource {
        public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // return self.smartWalletsArray.count
             
             var count:Int?
             if tableView == self.smartWallettbl {
                 count = smartWalletArray.count - 1

             return count!
                 }
             
             else if tableView == self.drpdwntbl
             {
                 count = DatedrpdwnArray.count
                 return count!

             }
             
             else{
                 if tableView == self.transactiontbl {
                 count = TxnListArray.count - 1
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

           if tableView == self.smartWallettbl {
                 

               let cell = tableView.dequeueReusableCell(withIdentifier: "smartwallettblcell", for: indexPath) as! smartwallettblcell
              
                             cell.self.imgbckview.layer.cornerRadius = cell.self.imgbckview.bounds.height / 2
   
               let responseDict = self.smartWalletArray[indexPath.row] as! NSMutableDictionary
                                   let res = smartWalletArray[indexPath.row]
               print("Retrived data",responseDict)
               print("Retrived data---",res)

               self.smartWalletArray.add(WalletMainDict)
               var walletnamestr : String?
               walletnamestr = responseDict["name"] as? String
               print("walletnamestr....",walletnamestr)
               var balancestr : String?
               balancestr = responseDict["balance"] as? String
               
               
               
               let balanceamtconvertbool = Double(balancestr!)!
               let BalAmtValue = String(format: "%.2f", arguments: [balanceamtconvertbool])
               print("string convert digit",BalAmtValue)
               
               
               cell.titlelbl!.text = walletnamestr
               cell.Amtlbl!.text = BalAmtValue
               
               
               
                  return cell
              }
           
           else if tableView == self.drpdwntbl
           {
               let cell = tableView.dequeueReusableCell(withIdentifier: "Drodwncell", for: indexPath) as! Drodwncell
               cell.datefilterlbl.text = DatedrpdwnArray[indexPath.row]
               return cell
           }
           
           else
           {
              // let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as! transactioncell
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as! transactioncell

              
                         if cell == nil{
                             let bundle = Bundle(for: type(of: self))
                             transactiontbl.register(UINib(nibName: "transactioncell", bundle: bundle), forCellReuseIdentifier: "transactioncell")
                         }
               let responseDict = self.TxnListArray[indexPath.row] as! NSMutableDictionary
                                   let res = TxnListArray[indexPath.row]
               print("transaction Retrived data",responseDict)
               print("transaction Retrived data---",res)

               self.TxnListArray.add(TxnMainDict)
               var TransactionList_modeldata = Transactionlistmodel()
               TransactionList_modeldata.merchantNamestr = (responseDict["merchantName"] as? String)!
               TransactionList_modeldata.amountstr = (responseDict["amount"] as? String)!
               
               
               
               TransactionList_modeldata.walletnamestr = (responseDict["txnType"] as? String)!
               TransactionList_modeldata.Datestr = (responseDict["createdAt"] as? String)!

               
               //Date formate convertion
               let dateFormatter = DateFormatter()
               let tempLocale = dateFormatter.locale // save locale temporarily
               dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
               let date = dateFormatter.date(from: TransactionList_modeldata.Datestr )!
              // dateFormatter.dateFormat = "dd-MM-yyyy"
               dateFormatter.dateFormat = "dd MMM, yyyy"
               dateFormatter.locale = tempLocale // reset the locale
               let dateString = dateFormatter.string(from: date)
               print("EXACT_DATE : \(dateString)")
               TransactionList_modeldata.txnStatusstr = (responseDict["txnStatus"] as? String)!
               print("TransactionList_modeldata.txnStatusstr",TransactionList_modeldata.txnStatusstr)
                     
                     if (TransactionList_modeldata.txnStatusstr == "SUCCESS")
                     {
                   

                         cell.statusimg.image = UIImage(systemName: "checkmark.circle.fill")

                         cell.statusimg.tintColor = #colorLiteral(red: 0.2039215686, green: 0.6177884615, blue: 0.3490196078, alpha: 1)

               }
               else
               {
                   cell.statusimg.image = UIImage(systemName: "exclamationmark.circle")
                   cell.statusimg.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
               }
               print("TransactionList_modeldata.Datestr",TransactionList_modeldata.Datestr)
               cell.titlelbl!.text = TransactionList_modeldata.merchantNamestr
               let Amtstr = TransactionList_modeldata.amountstr
               let balanceamtconvertbool = Double(Amtstr)!
               let BalAmtValue = String(format: "%.2f", arguments: [balanceamtconvertbool])
               print("string convert digit",BalAmtValue)
               cell.FirtAmtlbl.text = BalAmtValue
               cell.walletlbl.text = TransactionList_modeldata.walletnamestr
               cell.datelbl.text = dateString
               cell.reasonlbl.text = TransactionList_modeldata.merchantNamestr
               
               
                  return cell
              }
           
           
       }
       
       // method to run when table view cell is tapped
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Drodwncell", for: indexPath) as! Drodwncell
            cell.datefilterlbl.text = DatedrpdwnArray[indexPath.row]
            filterlbl.text = DatedrpdwnArray[indexPath.row]
            drpdwntblbckview.isHidden = true
            drpdwntbl.isHidden = true
            
            
       }
    
       
        
}

