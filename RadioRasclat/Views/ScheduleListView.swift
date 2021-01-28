//
//  ScheduleListView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import SwiftUI

struct ScheduleListView: View {
    
    @ObservedObject private var scheduleVM = ScheduleViewModel()
    
    @State private var pickerSelection = 0
        
    init() {
        scheduleVM.getSchedule()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                ScrollView {
                    
                    Picker("Select a week", selection: $pickerSelection) {
                      Text("This week").tag(0)
                      Text("Next week").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Text("Montag")
                    ScheduleDayView()
                    
                    Text("Tuesday")
                    ScheduleDayView()
                }
            }
            .navigationBarTitle("Schedule")
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
