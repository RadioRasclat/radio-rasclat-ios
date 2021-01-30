//
//  ScheduleDayView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import SwiftUI
import DateHelper

struct ScheduleDayView: View {
    
    var scheduleDay: [Day?]
        
    init(scheduleDay: [Day?]) {
        self.scheduleDay = scheduleDay
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if scheduleDay.isEmpty {
                Text("-")
                    .foregroundColor(.secondary)
            } else {
                ForEach(scheduleDay, id:\.self) { program in
                    ScheduleDayRow(program: program)
                    }
                }
            }
            .cornerRadius(10)
        }
    }

//struct ScheduleDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleDayView()
//    }
//}
