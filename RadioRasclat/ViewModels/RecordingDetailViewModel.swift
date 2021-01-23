//
//  RecordingDetailViewModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

class RecordingDetailViewModel: ObservableObject {
    
    @Published var fetchedRecording: Recording?
    
    func getRecordingDetails(id: String) {
        
        WebService().getRecordingsDetails(recording: id) { recording in
            
            if let recording = recording {
                self.fetchedRecording = recording
            }
        }
    }
}
