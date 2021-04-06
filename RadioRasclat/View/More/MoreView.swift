//
//  MoreView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 06.04.21.
//

import SwiftUI

struct MoreView: View {

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {

                VStack {
                    About()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(5)
            }
            .navigationBarTitle("More")

        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
