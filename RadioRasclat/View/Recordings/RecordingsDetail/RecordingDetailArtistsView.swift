//
//  ArtistsView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 05.12.20.
//

import SwiftUI

struct RecordingDetailArtistsView: View {
    
    var artists: [Artist]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(artists, id: \.id) { artist in
                    VStack {
                        URLImage(url: artist.image ?? "", type: "cast")
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.gray, lineWidth: 1))
                            .frame(width: 100, height: 100)
                        
                        Text("\(artist.title!)")
                            .lineLimit(1)
                            .font(.footnote)
                    }
                    .frame(width: 100, height: 130, alignment: .center)
                }
            }
        }
    }
}

struct RecordingDetailArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingDetailArtistsView(artists: [Artist.example])
    }
}
