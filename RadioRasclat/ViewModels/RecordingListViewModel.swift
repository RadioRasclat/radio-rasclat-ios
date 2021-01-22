//
//  RecordingListViewModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

class RecordingListViewModel: ObservableObject {
    
    @Published var recordings = [Recording]()
        
    func fetchRecordings() {
        
        WebService().getRecordings() { (recordings) in
            if let recordings = recordings {
                self.recordings = recordings
            }
        }
    }
}
