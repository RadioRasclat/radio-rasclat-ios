//
//  WebService.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import Foundation

class WebService {
        
    func getRecordings(completion: @escaping ([Recording]?) -> ()) {
            
        guard let url = URL(string: "https://api.radio-rasclat.com/recordings") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
                        
            // Check for errors
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // Check that data has been returned
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recordings = try decoder.decode([Recording].self, from: data)
                
                DispatchQueue.main.async {
                    print(recordings.count)
                    completion(recordings)
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getRecordingsDetails(recording: String, completion: @escaping (Recording?) -> ()) {
            
        guard let url = URL(string: "https://api.radio-rasclat.com/recordings/recording/\(recording)") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            // Check for errors
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // Check that data has been returned
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let recordingDetails = try decoder.decode(Recording.self, from: data)
                
                DispatchQueue.main.async {
                    completion(recordingDetails)
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
}
