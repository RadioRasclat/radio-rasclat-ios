//
//  RecordingCardView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 22.01.21.
//

import SwiftUI
import DateHelper

struct RecordingCardView: View {
    
    var recordings: Recording
        
    var body: some View {
            VStack {
                URLImage(url: recordings.image, type: "movie")
                    .aspectRatio(contentMode: .fit)
     
                HStack {
                    VStack(alignment: .leading) {
                        Text(recordings.show.title)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                        Text(recordings.title)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                            .padding(.bottom, 2)
                        
                        if let date = Date(detectFromString: recordings.timeStart) {
                            Text(date.toString(format: .custom("dd.MM.yyyy • HH:mm")))
                                .font(.headline)
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                    }
                    .layoutPriority(100)
     
                    Spacer()
                }
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
            )
            .padding([.top, .horizontal])
        }
}

struct RecordingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingCardView(recordings: Recording.example)
    }
}
