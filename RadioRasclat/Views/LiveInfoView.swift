//
//  LiveInfoView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 25.01.21.
//

import SwiftUI
import DateHelper

struct LiveInfoView: View {

    var liveInfo: LiveInfo

    init(liveInfo: LiveInfo) {
        self.liveInfo = liveInfo
    }

    var body: some View {
        
        VStack(alignment: .leading, spacing: 10, content: {
            URLImage(url: liveInfo.imagePath, type: "movie")
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.2), lineWidth: 2))
                .shadow(radius: 10)
            
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
        })
    }
}

struct LiveInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LiveInfoView(liveInfo: LiveInfo.example)
    }
}
