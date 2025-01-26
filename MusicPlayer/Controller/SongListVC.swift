//
//  SongListVC.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import UIKit

class SongListVC: UIViewController {
    @IBOutlet weak var songBanner: UIImageView!
    @IBOutlet weak var songList: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backGroundSongView: UIView!
    @IBOutlet weak var playPauseBtn: UIButton!
    var listImg = ""
    var listTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        songBanner.image = UIImage(named: listImg)
        playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        backBtn.setTitle(listTitle, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        if MusicPlayer.shared.isPlaying() {
            backGroundSongView.isHidden = false
        }else {
            backGroundSongView.isHidden = true
        }
    }
    @IBAction func playBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "", sender: self)
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func playPauseBtnActn(_ sender: Any) {
        if playPauseBtn.image(for: .normal) == UIImage(systemName: "pause.fill") {
            playPauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            MusicPlayer.shared.pause()
        } else {
            playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            MusicPlayer.shared.play()
        }
    }
    @IBAction func stopBtnActn(_ sender: Any) {
        MusicPlayer.shared.stop()
        backGroundSongView.isHidden = true
    }
    
}
extension SongListVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListTableViewCell", for: indexPath) as! SongListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Music", sender: self)
    }
}
