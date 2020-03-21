//
//  RecordingsList.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI

struct RecordingsList: View {
    @State var showSheetView = false
    
    var body: some View {
        NavigationView {
            List(recordings) { recording in
                NavigationLink(destination: RecordingDetail(recording: recording)) {
                    RecordingRow(recording: recording)
                }
            }
            .navigationBarTitle(Text("Broadcasts")
            .font(.system(.body, design: .rounded)).fontWeight(.medium))
            .navigationBarItems(trailing:
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Image(systemName: "calendar").imageScale(.large)
                }.sheet(isPresented: $showSheetView) {
                    SheetView(showSheetView: self.$showSheetView)
                }
            )
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList()
    }
}

struct SheetView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            Text("Sheet View content")
            .navigationBarTitle(Text("Schedule"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
                })
        }
    }
}
