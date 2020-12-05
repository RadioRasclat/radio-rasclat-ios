//
//  RecordingDetailHeroImage.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI

struct RecordingDetailHeroImage: View {
    
    var recording: Recording
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Cover picture
            
            URLImage(url: recording.image, type: "movie")
                .aspectRatio(contentMode: .fit)
            
            HStack {
                
                HStack {
                    Image(systemName: "play")
                }
                
                Spacer()
                
                HStack {
                    URLImage(url: recording.show.image, type: "coverArt")
                        .frame(width: 20, height: 20)
                    
                    Text(recording.show.title)
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
