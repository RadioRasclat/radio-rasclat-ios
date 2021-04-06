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
                .frame(width: 150, height: 150)
            
            Text(recordings.title)
                .font(.subheadline)
                .lineLimit(2)
            
        }
    }
}

struct RecordingListGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListGridItemView(recordings: Recording.example)
    }
}
