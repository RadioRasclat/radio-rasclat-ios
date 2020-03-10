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
        HStack {
            Image("1")
                .resizable()
                .frame(width: 48, height: 48)
            VStack(alignment: .leading) {
                Text("Radio Rasclat presents: LC-26")
                    .font(.title)
                Text("Radio Rasclat presents: LC-26 description.")
                    .font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
