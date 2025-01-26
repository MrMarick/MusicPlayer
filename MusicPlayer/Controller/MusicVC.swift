//
//  MusicVC.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import UIKit
import AVFoundation
class MusicVC: UIViewController {
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var fabBtn: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var suffelBtn: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    
//    private let musicPlayer = MusicPlayer()
    private let musicURL = URL(string: "https://v3.cdn.level.game/raag-pilu-mix-full-vers.mp3")!
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
        playPauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        progressView.progress = 0.0
        self.playPauseBtn.isEnabled = false
        self.previousBtn.isEnabled = false
        self.nextBtn.isEnabled = false
        self.suffelBtn.isEnabled = false
        configureAudioSession()
        updatePlayPauseButton()
        loadMusic()
    }
    

    @IBAction func fabBtn(_ sender: Any) {
        if fabBtn.image(for: .normal) == UIImage(named: "favorite") {
            fabBtn.setImage(UIImage(named: "favoriteSelected"), for: .normal)
        } else {
            fabBtn.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
    @IBAction func backBtnActn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func playPauseBtnActn(_ sender: Any) {
        if playPauseBtn.image(for: .normal) == UIImage(systemName: "play.fill") {
            playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            MusicPlayer.shared.play()
            startTimer()
        } else {
            playPauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            MusicPlayer.shared.pause()
            stopTimer()
        }

    }
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    private func loadMusic() {
        self.spinnerLoader.startAnimating()
        MusicPlayer.shared.loadMusic(from: musicURL) { [weak self] success in
             guard let self = self else {return}
             DispatchQueue.main.async {
                 self.spinnerLoader.stopAnimating()
                 if success {
                     self.playPauseBtn.isEnabled = true
                     self.previousBtn.isEnabled = true
                     self.nextBtn.isEnabled = true
                     self.suffelBtn.isEnabled = true
                     self.showToast(message: "Song loaded successfully")
                 } else {
                     self.showToast(message: "Unable to load song")
                 }
             }
         }
     }
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.progressView.progress = MusicPlayer.shared.getProgress()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    private func updatePlayPauseButton() {
        if MusicPlayer.shared.isPlaying() {
            playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }

}
