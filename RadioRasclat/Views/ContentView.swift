//
//  ContentView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           RecordingsList()
             .tabItem {
                Image(systemName: "folder")
                Text("Broadcasts")
              }
            Text("The content of the first view")
            .tabItem {
               Image(systemName: "hifispeaker")
               Text("Live")
             }
            Text("The content of the first view")
            .tabItem {
               Image(systemName: "calendar")
               Text("Schedule")
             }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
