//
//  smartwallettblcell.swift
//  iOSCard91sdk
//
//  Created by Card91 on 30/12/21.
//

import UIKit

class smartwallettblcell: UITableViewCell {

    
    @IBOutlet weak var imgbckview: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var Amtlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
