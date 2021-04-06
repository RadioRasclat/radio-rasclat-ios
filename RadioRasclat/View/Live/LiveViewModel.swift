//
//  LiveViewModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 25.01.21.
//

import Foundation

class LiveViewModel: ObservableObject {
    
    @Published var liveInfo: LiveInfo?
    
    func fetchLiveInfo() {
        
        WebService().getLiveInfo() { liveInfo in
            if let liveInfo = liveInfo {
                self.liveInfo = liveInfo
            }
        }
    }
}
