//
//  URLImage.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, type: String, placeholder: Image = Image("noImageFound")) {
        
        switch type {
        case "coverArt":
            self.placeholder = Image("placeholder").resizable()
        case "cast":
            self.placeholder = Image("placeholder").resizable()
        default:
            self.placeholder = Image("placeholder").resizable()
        }
    
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage)
            .resizable()
 
        } else {
            return placeholder
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
