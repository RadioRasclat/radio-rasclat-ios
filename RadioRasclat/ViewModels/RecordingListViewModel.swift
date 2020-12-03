//
//  RecordingListViewModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

class RecordingListViewModel: ObservableObject {
    
    @Published var recordings = [Recording]()
    
    private var fetchedRecordings = [RecordingList]()
    
    func fetchRecordings() {
        
        WebService().getRecordings() { recording in
            
            if let recording = recording {
                self.fetchedRecordings.append(recording)
                for recording in recording.recordings {
                    self.recordings.append(recording)
                }
            }
        }
    }
}
