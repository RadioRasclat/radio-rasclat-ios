//
//  ImageLoader.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var downloadedImage: UIImage?
    
    let didChange = PassthroughSubject<ImageLoader?, Never>()
        
    func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
        
                self.downloadedImage = UIImage(data: data)
                self.didChange.send(self)
            }
            
        }.resume()
    }
}

