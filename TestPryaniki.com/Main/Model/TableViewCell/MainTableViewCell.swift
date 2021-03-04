//
//  MainTableViewCell.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
