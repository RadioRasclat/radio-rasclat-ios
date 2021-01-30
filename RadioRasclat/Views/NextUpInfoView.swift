//
//  NextUpInfoView.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 30.01.21.
//

import SwiftUI

struct NextUpInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(Image(systemName: "calendar.badge.clock"))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary) +
                
            Text(" Next up on Radio Rasclat!")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        })
    }
}

struct NextUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NextUpInfoView()
    }
}
