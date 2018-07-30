//
//  RunTableViewCell.swift
//  RunApp
//
//  Created by Evgen Patlay on 23.12.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import UIKit

class RunTableViewCell: UITableViewCell {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!


    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(whith run: RealmRun){
        distanceLabel.text = "\(run.distance)"
        timeLabel.text = run.time
        speedLabel.text = "\(run.speed)"
        dateLabel.text = "\(run.date)"
    }

}
