//
//  SongListTableViewCell.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import UIKit

class SongListTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var fabBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func fabBtnActn(_ sender: Any) {
        if fabBtn.image(for: .normal) == UIImage(named: "favorite") {
            fabBtn.setImage(UIImage(named: "favoriteSelected"), for: .normal)
        } else {
            fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
    
}
