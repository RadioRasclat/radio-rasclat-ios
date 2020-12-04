//
//  RecordingDetailView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI

struct RecordingDetailView: View {
    
    @ObservedObject private var recordingDetailVM = RecordingDetailViewModel()
    
    var recording: Recording
        
    init(recording: Recording) {
        self.recording = recording
        recordingDetailVM.getMovieDetails(id: recording.id)
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
                RecordingDetailHeroImage(recording: recording)
                
                if recordingDetailVM.fetchedRecording?.genres.count ?? 0 >= 1 {
                    
                    // Genre
                    Text("\(recordingDetailVM.fetchedRecording?.genres.first?.title ?? "")")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(2)
                        .border(Color.gray)
                    
                }

                // Synopsis
                Text(recording.recordingDescription)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                
                if recordingDetailVM.fetchedRecording?.artists != nil {
                    ArtistsView(artist: (recordingDetailVM.fetchedRecording?.artists)!)
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .navigationBarTitle(recording.title)
    }
}

struct RecordingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingDetailView(recording: Recording.example)
    }
}
