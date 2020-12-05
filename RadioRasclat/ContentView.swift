//
//  ContentView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import SwiftUI
import LNPopupUI

struct ContentView: View {
    
    @State var isPopupPresented: Bool = true
    @State var isPopupOpen: Bool = true
    
    var body: some View {
        TabView {
            RecordingListView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Recordings")
                }
        }
        .accentColor(.pink)
        .popup(isBarPresented: $isPopupPresented, isPopupOpen: $isPopupOpen) {
            
        }
        //        .popupInteractionStyle(.drag)
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
