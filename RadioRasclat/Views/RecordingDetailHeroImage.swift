//
//  RecordingDetailHeroImage.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI
import AVKit

struct RecordingDetailHeroImage: View {
    
    var recording: Recording
    
    func playRecording(audio: String) {        
        print(audio)
        var player = AVPlayer()
        let playerItem = AVPlayerItem(url: URL(string: audio)!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Cover picture
            
            URLImage(url: recording.image, type: "movie")
                .aspectRatio(contentMode: .fit)
            
            HStack(alignment: .center) {
                
                HStack {
                    Button(action: {
                        playRecording(audio: recording.audio)
                    }) {
                        Image(systemName: "play")
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
