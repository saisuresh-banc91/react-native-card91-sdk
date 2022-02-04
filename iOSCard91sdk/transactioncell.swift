//
//  transactioncell.swift
//  iOSCard91sdk
//
//  Created by Card91 on 04/01/22.
//

import UIKit

class transactioncell: UITableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    
    
    
    @IBOutlet weak var FirtAmtlbl: UILabel!
    
    @IBOutlet weak var walletlbl: UILabel!
    
    @IBOutlet weak var datelbl: UILabel!
    
    @IBOutlet weak var reasonlbl: UILabel!
    
    @IBOutlet weak var reasontxtlbl: UILabel!
    
    @IBOutlet weak var statusimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
