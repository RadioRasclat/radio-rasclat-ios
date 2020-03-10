//
//  RecordingsList.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI

struct RecordingsList: View {
    var body: some View {
        NavigationView {
            List(recordings) { recording in
                NavigationLink(destination: RecordingDetail(recording: recording)) {
                    RecordingRow(recording: recording)
                }
            }
            .navigationBarTitle(Text("Broadcasts"))
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList()
    }
}
