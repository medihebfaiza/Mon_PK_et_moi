//
//  HistoriqueTableViewCell.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed Iheb Faiza on 26/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import UIKit

class HistoriqueTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var libelleReponse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
