//
//  LiveView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 05.12.20.
//

import SwiftUI
import AVKit

struct LiveView: View {
    
    @State var isPlaying : Bool = false
    
    func playRecording() {
        self.isPlaying.toggle()
        
        let urlString = "https://wdr-diemaus-live.icecastssl.wdr.de/wdr/diemaus/live/mp3/128/stream.mp3"
              
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
            HStack {
                Button(action: {
                             if self.isPlaying {
                                    pauseRecording()
                                    self.isPlaying = false
                             } else {
                                playRecording()
                                self.isPlaying = true
                             }
                         }) {
                    Image(systemName: self.isPlaying == true ? "pause.fill" : "play.fill").font(.system(size: 60))
                }
            }
            .navigationBarTitle("Live")
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
