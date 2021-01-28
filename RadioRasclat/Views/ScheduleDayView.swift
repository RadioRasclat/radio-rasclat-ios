//
//  ScheduleDayView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import SwiftUI

struct ScheduleDayView: View {
    
    var scheduleDay: Schedule
        
    init(scheduleDay: Schedule) {
        self.scheduleDay = scheduleDay
    }
    
    var body: some View {
        List {
            Section {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ScheduleDayView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDayView(scheduleDay: Schedule.example)
    }
}
