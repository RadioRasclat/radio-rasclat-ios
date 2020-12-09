//
//  RecordingDetailHeroImage.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI
import AVKit

var player: AVPlayer?

struct RecordingDetailHeroImage: View {
    
    @State var isPlaying : Bool = false
    var recording: Recording
    
    func playRecording(audio: String) {
        self.isPlaying.toggle()
        
        let urlString = audio
              
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
        ZStack(alignment: .bottom) {
            
            // Cover picture
            
            URLImage(url: recording.image, type: "movie")
                .aspectRatio(contentMode: .fit)
            
            HStack(alignment: .center) {
                
                HStack {
                    Button(action: {
                                 if self.isPlaying {
                                        pauseRecording()
                                        self.isPlaying = false
                                 } else {
                                    playRecording(audio: recording.audio)
                                    self.isPlaying = true
                                 }
                             }) {
                        Image(systemName: self.isPlaying == true ? "pause.fill" : "play.fill")
                    }
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "clock")
                    
                    VStack(alignment: .leading) {
                    
                        Text("27.09.2020")
                        Text("15:00 - 16:00 Uhr")
                    }
                }
                
                Spacer()
                
                HStack {
                    URLImage(url: recording.show.image, type: "coverArt")
                        .frame(width: 20, height: 20)
                        .cornerRadius(3)
                    
                    Text(recording.show.title)
                        .lineLimit(2)
                }
                
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            
        }
    }
}

struct MovieHeroImage_Previews: PreviewProvider {
    static var previews: some View {
        RecordingDetailHeroImage(recording: Recording.example)
    }
}
