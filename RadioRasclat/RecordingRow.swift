//
//  RecordingRow.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI
import URLImage

struct RecordingRow: View {
    var recording: Recording
    
    var body: some View {
        HStack {
            URLImage(recording.image,
            processors: [ Resize(size: CGSize(width: 80, height: 80), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.all, 5.0)
            })
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(recording.title)
                    .font(.body)
            }
        }
    }
}

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecordingRow(recording: recordings[0])
                .previewLayout(.fixed(width: 300, height: 70))
            RecordingRow(recording: recordings[1])
                .previewLayout(.fixed(width: 300, height: 70))
            RecordingRow(recording: recordings[2])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
