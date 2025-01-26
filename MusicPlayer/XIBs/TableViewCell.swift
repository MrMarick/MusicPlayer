//
//  TableViewCell.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var trendingSongsIcon: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songDtl: UILabel!
    @IBOutlet weak var fabBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        trendingSongsIcon.layer.cornerRadius = 15
        trendingSongsIcon.clipsToBounds = true
        fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favBtnAction(_ sender: Any) {
        if fabBtn.image(for: .normal) == UIImage(named: "favorite") {
            fabBtn.setImage(UIImage(named: "favoriteSelected"), for: .normal)
        } else {
            fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
    
}
