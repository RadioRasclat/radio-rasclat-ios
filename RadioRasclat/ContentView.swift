//
//  ContentView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecordingListView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Recordings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
