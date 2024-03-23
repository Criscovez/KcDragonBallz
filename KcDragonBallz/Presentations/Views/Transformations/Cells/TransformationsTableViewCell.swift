//
//  TransformationsTableViewCell.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import UIKit

class TransformationsTableViewCell: UITableViewCell {

    @IBOutlet weak var transfDescription: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
