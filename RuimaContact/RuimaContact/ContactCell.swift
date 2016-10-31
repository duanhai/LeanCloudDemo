//
//  ContactCell.swift
//  RuimaContact
//
//  Created by Tony Duan on 2016/10/31.
//  Copyright © 2016年 ChengduRuiMa. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!

}
