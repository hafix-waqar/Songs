//
//  SongsViewController.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 9/9/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class SongsViewController: UIViewController, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var songs = [String]()
    var songURLs = [URL]()

    @IBAction func playAll(_ sender: UIBarButtonItem) {
        playViaQueuePlayer()
    }
    
    private func playViaQueuePlayer() {
        
        let urls = FileSystem.mp3URLs()
        let mp3Items = urls.map { AVPlayerItem(url: $0) }
        let queuePlayer = AVQueuePlayer(items: mp3Items)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = queuePlayer
        print(mp3Items[0].canStepForward)
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = FileSystem.songs()
        songURLs = FileSystem.mp3URLs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songsCell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row]
        cell.textLabel?.textColor = UIColor.colorFrom(RGBValue: Colors.GreenYellow)
        cell.backgroundColor = UIColor.colorFrom(RGBValue: Colors.DarkSlateGray)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songURL = songURLs[indexPath.row]
        playSongAt(url: songURL)
        //playViaAVAudioPlayer(url: songURL)
    }
    
    private func playSongAt(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    var player:AVAudioPlayer?
    var currentTrackIndex = 0
    var error:NSError?
    
    
    func playViaAVAudioPlayer(url: URL) {
        if (player != nil) {
            player = nil
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            if player?.isPlaying == false {
                player?.play()
            }
        }
        catch {
            //SHOW ALERT OR SOMETHING
        }
    }
    
    
    
}
