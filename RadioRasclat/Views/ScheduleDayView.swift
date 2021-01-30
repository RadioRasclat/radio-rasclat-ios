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
        print(self.scheduleDay)
    }
    
    var body: some View {
        VStack {
            if scheduleDay.isEmpty {
                Text("There is no program scheduled.")
            } else {
                ForEach(scheduleDay, id:\.self) { program in
                    VStack(alignment: .leading, spacing: 0, content: {
                        Text(program?.name ?? "There is no program scheduled.")
                            .foregroundColor(.primary)
                        Text(program?.description ?? "-")
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                        
                        if let date = Date(detectFromString: program?.starts) {
                            Text(date.toString(format: .custom("HH:mm")))
                                .font(.headline)
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                        
                        Text("—")
                        
                        if let date = Date(detectFromString: program?.ends) {
                            Text(date.toString(format: .custom("HH:mm")))
                                .font(.headline)
                                .fontWeight(.black)
                                .foregroundColor(.secondary)
                        }
                        Divider()
                    })
                }
            }
        }
    }
}

//struct ScheduleDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleDayView()
//    }
//}
