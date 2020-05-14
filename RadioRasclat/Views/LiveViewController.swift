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
import WhatsNewKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the radio player
        player.delegate = self
        player.radioURL = URL(string: "https://station.radio-rasclat.com/live")
        
        // Initialize WhatsNew
        let whatsNew = WhatsNew(
            // The Title
            title: "What's new?",
            // The features you want to showcase
            items: [
                WhatsNew.Item(
                    title: "Listen to Broadcasts",
                    subtitle: "You can install WhatsNewKit via CocoaPods or Carthage",
                    image: UIImage(named: "btn-play")
                ),
                WhatsNew.Item(
                    title: "Push Notifications",
                    subtitle: "We'll be happy to inform you from time to time about upcoming live programs.",
                    image: UIImage(named: "btn-play")
                )
            ]
        )
        
        // Initialize default Configuration
        var configuration = WhatsNewViewController.Configuration()

        // Customize Configuration to your needs
        configuration.apply(theme: .red)
        
        // Initialize WhatsNewVersionStore
        let versionStore: WhatsNewVersionStore = KeyValueWhatsNewVersionStore()

        // Passing a WhatsNewVersionStore to the initializer
        // will give you an optional WhatsNewViewController
        let whatsNewViewController: WhatsNewViewController? = WhatsNewViewController(
            whatsNew: whatsNew,
            configuration: configuration,
            versionStore: versionStore
        )

        // Verify WhatsNewViewController is available
        guard let viewController = whatsNewViewController else {
            // The user has already seen the WhatsNew-Screen for the current Version of your app
            return
        }

        // Present WhatsNewViewController
        self.present(viewController, animated: true)
        
        setupRemoteTransportControls()
    }
    
    //*****************************************************************
    // MARK: - Setup
    //*****************************************************************

    @IBAction func playButtonPressed(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        player.pause()
    }
    
}

extension LiveViewController: FRadioPlayerDelegate {

    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        track = Track(artist: artistName, name: trackName)
    }
    
    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
        track = nil
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

// MARK: - UINavigationController

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
