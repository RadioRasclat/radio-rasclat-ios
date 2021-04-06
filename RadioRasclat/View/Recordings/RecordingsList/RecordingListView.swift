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
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                            ForEach(recordingListVM.recordings, id:\.id) { recording in
                                NavigationLink(destination: RecordingDetailView(recording: recording)) {
                                    RecordingCardView(recordings: recording)
                                }
                            }
                        }
                    }
                    .fixFlickering()
                }
            }
            .navigationBarTitle("Broadcasts")
            .navigationBarItems(leading: Text(String(recordingListVM.recordings.count)) + Text("+"))
        }
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView()
    }
}
