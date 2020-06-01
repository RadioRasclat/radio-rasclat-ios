//
//  LiveViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 11.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import Alamofire
import AVKit
import FRadioPlayer
import MediaPlayer
import UIKit

class LiveViewController: UIViewController {
    @IBOutlet var trackLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var artworkImageView: UIImageView!

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

    // *****************************************************************

    // MARK: - Setup

    // *****************************************************************

    @IBAction func playButtonPressed(_: Any) {
        player.play()
        getLiveMeta()
    }

    @IBAction func pauseButtonPressed(_: Any) {
        player.pause()
        track = Track(artist: "Radio Rasclat", name: "Paused...")
    }

    func getLiveIndicator() {
        AF.request("https://api.radio-rasclat.com/meta/live-info", method: .get)
            .responseJSON { response in
                switch response.result {
                case let .success(value):
                    if let JSON = value as? [String: Any] {
                        let status = JSON["source_enabled"] as! String
                        if status == "Master" {
                            self.tabBarController?.tabBar.items?[0].badgeValue = "Live"
                        }
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }

    func getLiveMeta() {
        AF.request("https://api.radio-rasclat.com/meta/shows/current", method: .get)
            .responseJSON { response in
                switch response.result {
                case let .success(value):
                    if let JSON = value as? [String: Any] {
                        let showTitle = JSON["name"] as! String
                        let showImage = JSON["image_path"] as! String
                        if showImage.count > 5 {
                            let urlImageString = showImage
                            let urlImage = URL(string: urlImageString)

                            self.artworkImageView.load(url: urlImage!)
                        } else {
                            self.artworkImageView.image = UIImage(named: "placeholderImage")
                        }

                        self.track = Track(artist: "Radio Rasclat", name: showTitle)
                    } else {
                        self.track = Track(artist: "Radio Rasclat", name: "Off-Air")
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
}

extension LiveViewController: FRadioPlayerDelegate {
    func radioPlayer(_: FRadioPlayer, playerStateDidChange _: FRadioPlayerState) {}

    func radioPlayer(_: FRadioPlayer, playbackStateDidChange _: FRadioPlaybackState) {}

    func radioPlayer(_: FRadioPlayer, metadataDidChange _: String?, trackName _: String?) {
        getLiveMeta()
    }

    func radioPlayer(_: FRadioPlayer, itemDidChange _: URL?) {}

    func radioPlayer(_: FRadioPlayer, metadataDidChange _: String?) {}

    func radioPlayer(_: FRadioPlayer, artworkDidChange artworkURL: URL?) {
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
        commandCenter.playCommand.addTarget { [unowned self] _ in
            if self.player.rate == 0.0 {
                self.player.play()
                self.getLiveMeta()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] _ in
            if self.player.rate == 1.0 {
                self.player.pause()
                self.track = Track(artist: "Radio Rasclat", name: "Paused...")
                return .success
            }
            return .commandFailed
        }
    }

    func updateNowPlaying(with track: Track?) {
        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()

        if let artist = track?.artist {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }

        nowPlayingInfo[MPMediaItemPropertyTitle] = track?.name

        if let image = track?.image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ -> UIImage in
                image
            })
        }

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
