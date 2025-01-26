//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 24/01/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recentMusicCollectionView: UICollectionView!
    @IBOutlet weak var recommendedMusicCollectionView: UICollectionView!
    @IBOutlet weak var playListCollectionView: UICollectionView!
    @IBOutlet weak var trendingContainerView: UIView!
    @IBOutlet weak var trendingIconImgView: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var backGroundSongView: UIView!
    @IBOutlet weak var playPauseBtn: UIButton!

    var currentIndex = 0
    var selectedListImg = ""
    var selectedListTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingContainerView.layer.cornerRadius = 20
        trendingContainerView.clipsToBounds = true
        trendingIconImgView.layer.cornerRadius = 15
        trendingIconImgView.clipsToBounds = true
        searchTextField.layer.cornerRadius = 20
        searchTextField.clipsToBounds = true
        searchTextField.placeholder = "🔍 Search for music"
        pageController.numberOfPages = 3
        playPauseBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        recommendedMusicCollectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        swipeRight.delegate = self
        recommendedMusicCollectionView.addGestureRecognizer(swipeRight)
//                recentMusicCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
//                recommendedMusicCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
//                playListCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if MusicPlayer.shared.isPlaying() {
            backGroundSongView.isHidden = false
        }else {
            backGroundSongView.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songList"{
            let vc = segue.destination as? SongListVC
            vc?.listImg = selectedListImg
            vc?.listTitle = selectedListTitle
        }
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let totalItems = recommendedMusicCollectionView.numberOfItems(inSection: 0)
        
        if gesture.direction == .left {
            // Ensure currentIndex doesn't exceed total items
            if currentIndex < totalItems - 1 {
                currentIndex += 1
            }
        } else if gesture.direction == .right {
            // Ensure currentIndex doesn't go below 0
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
        
        // Update the page controller
        pageController.currentPage = currentIndex
        recommendedMusicCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0) , at: .centeredHorizontally, animated: true)
    }
    @IBAction func playBtnAction(_ sender: Any) {
        self.selectedListImg = "focus"
        self.selectedListTitle = "For Focus"
        self.performSegue(withIdentifier: "songList", sender: self)
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 || collectionView.tag == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        } else if collectionView.tag == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as! RecommendedCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView.tag == 1{
//            let width = (collectionView.frame.width - 30)/2
//            let height = collectionView.frame.height
//            return CGSize(width: width, height: height)
//        } else if collectionView.tag == 2{
//            let width = collectionView.frame.width
//            let height = collectionView.frame.height
//            return CGSize(width: width, height: height)
//        } else if collectionView.tag == 3{
//            let width = (collectionView.frame.width - 30)/2
//            let height = collectionView.frame.height
//            return CGSize(width: width, height: height)
//        }
//        return CGSize()
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            self.selectedListImg = "banner"
            self.selectedListTitle = "For Creativity"
            self.performSegue(withIdentifier: "songList", sender: self)
        } else if collectionView.tag == 3{
            self.selectedListImg = "lofi"
            self.selectedListTitle = "Lofi Beats"
            self.performSegue(withIdentifier: "songList", sender: self)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.trendingSongsIcon.image = UIImage(named: "Connect")
        cell.songTitle.text = "Connect Mind + Body"
        cell.songDtl.text = "9 mins 10 XP"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectedListImg = "staticSquareThumbnailIcon"
//        self.selectedListTitle = "Connect Mind + Body"
        self.performSegue(withIdentifier: "music", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension ViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
}
