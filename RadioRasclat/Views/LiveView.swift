//
//  LiveView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 05.12.20.
//

import SwiftUI
import AVKit

struct LiveView: View {

    @ObservedObject private var liveVM = LiveViewModel()
    @State var isPlaying: Bool = false

    init() {
        liveVM.fetchLiveInfo()
    }

    func playRecording() {
        self.isPlaying.toggle()

        let urlString = "https://station.radio-rasclat.com/live"

        guard let url = URL.init(string: urlString) else { return }

        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .defaultToSpeaker, .mixWithOthers, .allowAirPlay])
            print("Playback OK")

            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        player?.play()
    }

    func pauseRecording() {
        player?.pause()
    }
    var body: some View {
        NavigationView {
            VStack {
                LiveInfoView(liveInfo: liveVM.liveInfo ?? LiveInfo(name: "OFF AIR", description: "Radio Rasclat will come back soon!", url: "OFF AIR", imagePath: "https://radio-rasclat.com/assets/svg/logo.svg", starts: "", ends: ""))
                Button(action: {
                    if self.isPlaying {
                        pauseRecording()
                        self.isPlaying = false
                    } else {
                        playRecording()
                        self.isPlaying = true
                    }
                }) {
                    Image(systemName: self.isPlaying == true ? "pause.fill" : "play.fill").font(.system(size: 40))
                }
            }
            .padding(15)
            .navigationBarTitle("Live")
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
