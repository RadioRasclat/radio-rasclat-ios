//
//  ScheduleViewModel.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    
    @Published var schedule: Schedule?
    
    func getSchedule() {
        
        WebService().getSchedule() { schedule in
            
            print(schedule?.monday ?? "default value")
            
            if let schedule = schedule {
                self.schedule = schedule
            }
        }
    }
}
