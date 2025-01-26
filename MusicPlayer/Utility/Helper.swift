//
//  Helper.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import Foundation
import AVFoundation

final class MusicPlayer {
    static let shared = MusicPlayer()
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    // Cache directory for storing songs
    private let cacheDirectory: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    func loadMusic(from url: URL, completion: @escaping (Bool) -> Void) {
        // Generate a file name based on the URL (e.g., by using a hash of the URL)
        let fileName = url.lastPathComponent
        let cachedFileURL = cacheDirectory.appendingPathComponent(fileName)
        
        // Check if the file is already cached
        if FileManager.default.fileExists(atPath: cachedFileURL.path) {
            print("Loading music from cache.")
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: cachedFileURL)
                self.audioPlayer?.prepareToPlay()
                completion(true)
            } catch {
                print("Error initializing audio player from cache: \(error.localizedDescription)")
                completion(false)
            }
        } else {
            print("Downloading and caching music.")
            // Perform network call asynchronously to download the file
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Failed to load music: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                guard let data = data else {
                    print("No data received from URL.")
                    completion(false)
                    return
                }

                do {
                    // Save the downloaded file to the cache directory
                    try data.write(to: cachedFileURL)
                    self.audioPlayer = try AVAudioPlayer(data: data)
                    self.audioPlayer?.prepareToPlay()
                    completion(true)
                } catch {
                    print("Error saving music file: \(error.localizedDescription)")
                    completion(false)
                }
            }
            task.resume()
        }
    }

    func play() {
        audioPlayer?.play()
    }

    func pause() {
        audioPlayer?.pause()
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }

    func isPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }

    func getProgress() -> Float {
        guard let audioPlayer = audioPlayer else { return 0 }
        return Float(audioPlayer.currentTime / audioPlayer.duration)
    }
}
