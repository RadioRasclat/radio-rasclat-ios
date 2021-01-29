//
//  LiveView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 05.12.20.
//

import SwiftUI

struct LiveView: View {

    @ObservedObject private var liveVM = LiveViewModel()

    init() {
        liveVM.fetchLiveInfo()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    LiveInfoView(liveInfo: liveVM.liveInfo ?? LiveInfo(name: "OFF AIR", description: "Radio Rasclat will come back soon!", url: "OFF AIR", imagePath: "https://radio-rasclat.com/assets/svg/logo.svg", starts: "", ends: ""))
                    
                    Divider()
                    
                    Spacer()
                    
                }
                .padding(15)
            }
            .navigationBarTitle("Live")
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
