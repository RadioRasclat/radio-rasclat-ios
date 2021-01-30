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
                
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        UIScrollView.appearance().backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
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
