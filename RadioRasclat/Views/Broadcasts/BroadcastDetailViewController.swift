//
//  BroadcastDetailViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 15.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

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
    
    var broadcast:Broadcasts?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func playBroadcastButton(_ sender: Any) {
        let urlAudioString = broadcast?.audio
        
        let playerItem = AVPlayerItem(url: URL(string: urlAudioString!)!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
        
        setupAVAudioSession()
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
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: broadcast?.title ?? "Radio Rasclat"]

        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player.pause()
            return .success
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = broadcast?.title
        
        let urlImageString = broadcast?.image
        let urlImage = URL(string: urlImageString!)
        
        titleLabel.text = broadcast?.title
        imageView.load(url: urlImage!)
    }
}
