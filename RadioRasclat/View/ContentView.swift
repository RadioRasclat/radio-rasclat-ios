//
//  ContentView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import SwiftUI
import LNPopupUI

struct ContentView: View {
    
    @State var isPopupPresented: Bool = false
    @State var isPopupOpen: Bool = false
    
    var body: some View {
        TabView {
            LiveView()
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Live")
                }
            RecordingListView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Recordings")
                }
            ScheduleListView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }
        .accentColor(Color("AccentColor"))
        .popup(isBarPresented: $isPopupPresented, isPopupOpen: $isPopupOpen) {
            
        }
        .popupInteractionStyle(.drag)
        .popupBarStyle(.prominent)
        .popupBarProgressViewStyle(.top)
        .popupBarMarqueeScrollEnabled(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
