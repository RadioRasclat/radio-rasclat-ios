//
//  RrecordingGridItemView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI

struct RecordingListGridItemView: View {
    
    var recordings: Recording
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        VStack {
            // Poster
            URLImage(url: "\(recordings.image)", type: "coverArt")
                .frame(width: 154, height: 228)
            
            Text(recordings.title)
                .font(.footnote)
                .lineLimit(0)
            
            HStack {
                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(recordings.recordingDescription)
   
                }
                
                HStack {
                    // Release date
                    Image(systemName: "calendar")
                    
                    Text("\(recordings.timeStart)")
                        .font(.callout)
                }
            }
        }.padding(.bottom, 20)
        .frame(width: 154)
    }
}

struct RecordingListGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListGridItemView(recordings: Recording.example)
    }
}
