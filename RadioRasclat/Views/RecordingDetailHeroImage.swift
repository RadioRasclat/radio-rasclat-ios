//
//  RecordingDetailHeroImage.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI

struct RecordingDetailHeroImage: View {
    
    var recording: Recording
    var runTime: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Cover picture
            
            URLImage(url: recording.image, type: "movie")
                .aspectRatio(contentMode: .fit)
            
            HStack {
                
                // Rating avg
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("test")
                    
                }
                Spacer()
                
                // Rating count
                HStack {
                    Image(systemName: "person.3")
                    
                    Text("test")
                    
                }
                Spacer()
                
                // Movie runtime
                HStack {
                    Image(systemName: "clock")
                    
                    Text("\(runTime) mins")
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
