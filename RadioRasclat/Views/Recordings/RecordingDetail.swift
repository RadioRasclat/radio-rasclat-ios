//
//  RecordingDetail.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI
import URLImage

struct RecordingDetail: View {
    var recording: Recording
    
    var body: some View {
        VStack {
            URLImage(recording.image,
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 20.0)
                .shadow(radius: 2.0)
            })
                VStack {
                    Text(recording.title)
                        .font(.title)
                    Text(recording.description)
                        .font(.body)
                }
            .navigationBarTitle(Text(recording.title), displayMode: .inline)
        }
    }
}

struct RecordingDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingDetail(recording: recordings[4])
        }
    }
}
