//
//  LiveInfoView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 25.01.21.
//

import SwiftUI
import DateHelper
import AVKit

struct LiveInfoView: View {
    
    @State var isPlaying: Bool = false
    
    var liveInfo: LiveInfo

    init(liveInfo: LiveInfo) {
        self.liveInfo = liveInfo
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
        
        VStack(alignment: .leading, spacing: 10, content: {
            Text(Image(systemName: "antenna.radiowaves.left.and.right"))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary) +
                
            Text(" Now on Radio Rasclat!")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            if liveInfo.imagePath.isEmpty {
                URLImage(url: "https://s3.eu-central-1.wasabisys.com/prod.radiorasclat.uploads/20201104/images/rr-logo-grain_600x.jpg", type: "movie")
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.2), lineWidth: 2))
                    .shadow(radius: 10)
                    .padding(.trailing, 2)
                    .padding(.bottom, 15)
            } else {
                URLImage(url: liveInfo.imagePath, type: "movie")
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.2), lineWidth: 2))
                    .shadow(radius: 10)
                    .padding(.trailing, 2)
                    .padding(.bottom, 15)
            }
            
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
                    Image(systemName: self.isPlaying == true ? "pause.fill" : "play.fill").font(.system(size: 30))
                        .padding()
                        .background(Color("AccentColor"))
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 25)
                .padding(.leading, 15)
                
                VStack(alignment: .leading) {
                    Text(liveInfo.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .padding(.bottom, 2)
                    
                    Text(liveInfo.description)
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .padding(.bottom, 2)
                    
                    HStack {
                        if let date = Date(detectFromString: liveInfo.starts) {
                            Text(date.toString(format: .custom("HH:mm")))
                                .font(.footnote)
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                        
                        Text("—")
                        
                        if let date = Date(detectFromString: liveInfo.ends) {
                            Text(date.toString(format: .custom("HH:mm")))
                                .font(.footnote)
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        })
    }
}

struct LiveInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LiveInfoView(liveInfo: LiveInfo.example)
    }
}
