//
//  LiveViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 11.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import UIKit
import MediaPlayer
import FRadioPlayer
import AVKit
import Alamofire

class LiveViewController: UIViewController {
    
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
        
    // Singleton ref to player
    let player: FRadioPlayer = FRadioPlayer.shared
    
    var track: Track? {
        didSet {
            artistLabel.text = track?.artist
            trackLabel.text = track?.name
            updateNowPlaying(with: track)
        }
    }
    
    // Get live meta data from Radio Rasclat API

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the radio player
        player.delegate = self
        player.isAutoPlay = false
        player.enableArtwork = false
        player.radioURL = URL(string: "https://station.radio-rasclat.com/live")
        
        setupRemoteTransportControls()
        
        track = Track(artist: "Radio Rasclat", name: "Off-Air")
        
        getLiveIndicator()
        getLiveMeta()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getLiveIndicator()
        getLiveMeta()
    }
    
    //*****************************************************************
    // MARK: - Setup
    //*****************************************************************

    @IBAction func playButtonPressed(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        player.pause()
        track = Track(artist: "Press play button to start stream.", name: "Radio Rasclat")
    }
    
    func getLiveIndicator() {
        AF.request("https://api.radio-rasclat.com/meta/live-info", method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        let status = JSON["source_enabled"] as! String
                        if status == "Master" {
                            self.tabBarController?.tabBar.items?[0].badgeValue = "Live"
                        } else {
                            self.tabBarController?.tabBar.items?[0].badgeValue = nil
                        }
                    }
                case .failure(let error):
                // error handling
                    print(error)
            }
        }
    }
    
    func getLiveMeta() {
        AF.request("https://api.radio-rasclat.com/meta/shows/current", method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        let data = JSON[""] as! String
                        print("hi")
                        print(data)
                    } else {
                        self.track = Track(artist: "Radio Rasclat", name: "Off-Air")
                    }
                case .failure(let error):
                // error handling
                    print(error)
            }
        }
    }
    
}

extension LiveViewController: FRadioPlayerDelegate {

    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
        
        // Please note that the following example is for demonstration purposes only, consider using asynchronous network calls to set the image from a URL.
        guard let artworkURL = artworkURL, let data = try? Data(contentsOf: artworkURL) else {
            return
        }
        track?.image = UIImage(data: data)
        artworkImageView.image = track?.image
        updateNowPlaying(with: track)
    }
}

// MARK: - Remote Controls / Lock screen

extension LiveViewController {
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.player.play()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player.rate == 1.0 {
                self.player.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    func updateNowPlaying(with track: Track?) {
    
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        
        if let artist = track?.artist {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = track?.name
        
        if let image = track?.image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ -> UIImage in
                return image
            })
        }
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
