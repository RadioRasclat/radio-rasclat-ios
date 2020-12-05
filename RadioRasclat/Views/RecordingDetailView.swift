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
                    
                    Text("\(recordingDetailVM.fetchedRecording?.genres.first?.title ?? "")")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(2)
                        .border(Color.gray)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    
                }
                
                Text(recording.recordingDescription)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                Text("Artists")
                    .font(.caption)
                    .lineLimit(nil)
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 0))
                
                if recordingDetailVM.fetchedRecording?.artists != nil {
                    ArtistsView(artists: (recordingDetailVM.fetchedRecording?.artists)!)
                }
                
            }
        }
        .navigationBarTitle(recording.title)
    }
}

struct RecordingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingDetailView(recording: Recording.example)
    }
}
