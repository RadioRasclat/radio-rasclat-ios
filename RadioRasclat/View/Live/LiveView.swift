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
                                        
                    LiveInfoView(liveInfo: liveVM.liveInfo ?? LiveInfo(name: "OFF AIR", description: "Radio Rasclat will come back soon!", url: "OFF AIR", imagePath: "https://s3.eu-central-1.wasabisys.com/prod.radiorasclat.uploads/20201104/images/rr-logo-grain_600x.jpg", starts: "", ends: ""))
                    
                    // Divider()
                    
                    // NextUpInfoView()
                    
                    // Spacer()
                    
                }
                .padding(15)
            }
            .fixFlickering()
            .navigationBarTitle("Live")
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
