//
//  RecordingListView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 04.12.20.
//

import SwiftUI

struct RecordingListView: View {
    
    @ObservedObject private var recordingListVM = RecordingListViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        recordingListVM.fetchRecordings()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if recordingListVM.recordings.isEmpty {
                    Spacer()
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .padding()
                        
                        Text("Connecting...").padding(5)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: twoColumnGrid, spacing: 20) {
                            ForEach(recordingListVM.recordings, id:\.id) { recording in
                                NavigationLink(destination: RecordingDetailView(recording: recording)) {
                                    RecordingListGridItemView(recordings: recording)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Broadcasts")
        }
        .accentColor(.white)
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView()
    }
}
