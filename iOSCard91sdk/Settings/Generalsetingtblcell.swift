//
//  Generalsetingtblcell.swift
//  iOSCard91sdk
//
//  Created by Card91 on 10/01/22.
//

import UIKit

class Generalsetingtblcell: UITableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var Languageicon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
