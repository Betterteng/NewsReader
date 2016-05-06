//
//  NewsCellTableViewCell.swift
//  NewsReader
//
//  Created by 滕施男 on 19/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet var imageV: UIImageView!
    @IBOutlet var titleL: UILabel!
    @IBOutlet var descL: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
