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
    
    @IBOutlet weak var freezenexttransactionlbl: UILabel!
    @IBOutlet weak var frozenalertView: UIView!
    
    @IBOutlet weak var disablecard: UIView!
    @IBOutlet weak var callnowbtn: UIButton!
    
    @IBOutlet weak var GotITbtn: UIButton!
    //@IBOutlet weak var NeedhelpbottomView: UIView!
    
    
    @IBOutlet weak var Blkbtn: UIButton!
    
    @IBOutlet weak var cancelbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //freezetxtbckview is hidden
        freezetxtbckview.isHidden = true
        Bottompopupview.isHidden = true
        frozenalertView.isHidden = true
        disablecard.isHidden = true
        
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
        let switchOnOff = UISwitch(frame:CGRect(x: 50, y: 10, width: 30, height: 10))
        switchOnOff.onTintColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
        switchOnOff.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        switchOnOff.thumbTintColor = UIColor.white
        switchOnOff.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        switchOnOff.layer.cornerRadius = 14
        
        Blkbtn.layer.cornerRadius = 8
        cancelbtn.layer.cornerRadius = 8




      switchOnOff.addTarget(self, action: #selector(self.Unfreeze), for: .valueChanged)
            switchOnOff.setOn(true, animated: false)
        self.UnfreezeView.addSubview(switchOnOff)
        
        //Tap on Help label
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreditcardVC.HelplbltapFunction))
           helplbl.isUserInteractionEnabled = true
           helplbl.addGestureRecognizer(tap)

//        //Block UISwitch
//        let BlokswitchOnOff = UISwitch(frame:CGRect(x: 50, y: 10, width: 30, height: 10))
//        BlokswitchOnOff.onTintColor = #colorLiteral(red: 0, green: 0, blue: 0.05490196078, alpha: 0.1962425595)
//        BlokswitchOnOff.tintColor = #colorLiteral(red: 0, green: 0, blue: 0.05490196078, alpha: 0.1962425595)
//        BlokswitchOnOff.thumbTintColor = UIColor.white
//        BlokswitchOnOff.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.05490196078, alpha: 0.1962425595)
//        BlokswitchOnOff.layer.cornerRadius = 14
//
//        BlokswitchOnOff.addTarget(self, action: #selector(self.Blok), for: .valueChanged)
//        BlokswitchOnOff.setOn(true, animated: false)
//        self.BlockView.addSubview(BlokswitchOnOff)


        
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


    @objc func HelplbltapFunction(sender:UITapGestureRecognizer) {

        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
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
        UnfreezeView.backgroundColor = UIColor.white
        BlockView.backgroundColor = UIColor.white
        freezelbl.backgroundColor = UIColor.white
        blocktxtlbl.backgroundColor = UIColor.white
        freezecreditcrdlbl.backgroundColor = UIColor.white
        blockcredictcardlbl.backgroundColor = UIColor.white
        Bottompopupview.isHidden = true
    }
    
    
   
   
    @objc func Unfreeze(sender:UISwitch){
       if (sender.isOn == true){
           sender.setOn(true, animated: false)
           print("Switched on")
           freezelbl.text = "Freeze"
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
           freezetxtbckview.backgroundColor = #colorLiteral(red: 1, green: 0.9137254902, blue: 0.5137254902, alpha: 1)
           freezenexttransactionlbl.text = "Your card is frozen temporarily please click unfreeze to use it for your next transaction"
           
           //Block UISwitch
                  let BlokswitchOnOff = UISwitch(frame:CGRect(x: 50, y: 10, width: 30, height: 10))
           BlokswitchOnOff.onTintColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
           BlokswitchOnOff.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           BlokswitchOnOff.thumbTintColor = UIColor.white
           BlokswitchOnOff.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           BlokswitchOnOff.layer.cornerRadius = 14
                  BlokswitchOnOff.addTarget(self, action: #selector(self.Blok), for: .valueChanged)
                  BlokswitchOnOff.setOn(true, animated: false)
                  self.BlockView.addSubview(BlokswitchOnOff)
           sender.setOn(false, animated: false)

       }
   }
    
    @objc func Blok(sender:UISwitch){
       if (sender.isOn == true){
           sender.setOn(true, animated: false)
           print("Bloked")
           freezetxtbckview.isHidden = false
           frozenalertView.isHidden = true

          

       }
       else{

           freezetxtbckview.isHidden = true
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
        freezetxtbckview.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.6509803922, blue: 0.6274509804, alpha: 1)
        freezenexttransactionlbl.text = "Your card is Blocked Permenantly"
        managecardlbl.text = "Need Help? Call Us"
        managecardlbl.textColor = #colorLiteral(red: 0.07843137255, green: 0.4588235294, blue: 1, alpha: 1)
        
        
    }
}
