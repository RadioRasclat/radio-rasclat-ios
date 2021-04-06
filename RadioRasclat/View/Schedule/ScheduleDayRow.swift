//
//  ScheduleDayRow.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 30.01.21.
//

import SwiftUI

struct ScheduleDayRow: View {
    
    var program: Day?
        
    init(program: Day?) {
        self.program = program
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text(program?.name ?? "There is no program scheduled.")
                .foregroundColor(Color("AccentColor"))
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            if (program?.description != "") {
                Text(program?.description ?? "-")
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.bottom, 5)
            }
            
            HStack {
                if let date = Date(detectFromString: program?.starts ?? "") {
                    Text(date.toString(format: .custom("HH:mm")))
                        .foregroundColor(.primary)
                }
                
                Text("—")
                    .foregroundColor(.primary)
                
                if let date = Date(detectFromString: program?.ends ?? "") {
                    Text(date.toString(format: .custom("HH:mm")))
                        .foregroundColor(.primary)
                }
                Spacer()
            }
        })
        .padding()
        .background(Color("LightColor"))
    }
}
