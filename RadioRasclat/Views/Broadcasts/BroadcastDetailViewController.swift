//
//  BroadcastDetailViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 15.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import AVFoundation
import AVKit
import MediaPlayer
import UIKit
import SwiftSoup
import Kingfisher

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class BroadcastDetailViewController: UIViewController {
    var player = AVPlayer()
    var playerItem: AVPlayerItem!

    var broadcast: Broadcasts?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func playBroadcastButton(_: Any) {
        player.play()
        setupAVAudioSession()
    }

    @IBAction func pauseBroadcastButton(_: Any) {
        player.pause()
    }

    private func setupAVAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("AVAudioSession is Active and Category Playback is set")
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupCommandCenter()
        } catch {
            debugPrint("Error: \(error)")
        }
    }

    private func setupCommandCenter() {
        // Meta
        var nowPlayingInfo = [String: Any]()

        nowPlayingInfo[MPMediaItemPropertyTitle] = broadcast?.title ?? "Radio Rasclat"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Radio Rasclat"
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "Stimulating the gun-finger."
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo

        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (_) -> MPRemoteCommandHandlerStatus in
            self?.player.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (_) -> MPRemoteCommandHandlerStatus in
            self?.player.pause()
            return .success
        }

        // Scrubber
        commandCenter.changePlaybackPositionCommand.addTarget { event in
            let seconds = (event as? MPChangePlaybackPositionCommandEvent)?.positionTime ?? 0
            let time = CMTime(seconds: seconds, preferredTimescale: 1)
            self.player.seek(to: time)
            return .success
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlAudioString = broadcast?.audio

        playerItem = AVPlayerItem(url: URL(string: urlAudioString!)!)
        player = AVPlayer(playerItem: playerItem)

        title = broadcast?.title

        let urlImageString = broadcast?.image
        let urlImage = URL(string: urlImageString!)
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: urlImage,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }

        titleLabel.text = broadcast?.title
        
        do {
            let html = (broadcast?.description)!
            let doc: Document = try SwiftSoup.parse(html)
            descriptionLabel.text = try doc.text()
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("message")
        }
        
        descriptionLabel.sizeToFit()
    }

    override func viewDidDisappear(_: Bool) {
        player.pause()
        player.cancelPendingPrerolls() // stops network requests
        player.replaceCurrentItem(with: nil)
    }
}
