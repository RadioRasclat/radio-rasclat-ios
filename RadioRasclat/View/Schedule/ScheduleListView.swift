//
//  ScheduleListView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 28.01.21.
//

import SwiftUI

struct ScheduleListView: View {
    
    @ObservedObject private var scheduleVM = ScheduleViewModel()
            
    init() {
        scheduleVM.getSchedule()
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if ((scheduleVM.schedule?.monday.isEmpty) != nil) {
                        Text("Monday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.monday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.tuesday.isEmpty) != nil) {
                        Text("Tuesday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.tuesday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.wednesday.isEmpty) != nil) {
                        Text("Wednesday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.wednesday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.thursday.isEmpty) != nil) {
                        Text("Thursday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.thursday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.friday.isEmpty) != nil) {
                        Text("Friday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.friday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.saturday.isEmpty) != nil) {
                        Text("Saturday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.saturday)
                            .padding(.bottom, 10)
                    }
                    
                    if ((scheduleVM.schedule?.sunday.isEmpty) != nil) {
                        Text("Sunday")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        ScheduleDayView(scheduleDay: scheduleVM.schedule!.sunday)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .padding(15)
            }
            .fixFlickering()
            .navigationBarTitle("Schedule")
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
