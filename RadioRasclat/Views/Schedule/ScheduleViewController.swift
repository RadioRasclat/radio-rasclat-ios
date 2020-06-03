//
//  ScheduleViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 02.06.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import UIKit
import Alamofire

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mondayTableView: UITableView!
    @IBOutlet weak var tuesdayTableView: UITableView!
    
    var schedule: Schedule?
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadSchedule {
            self.mondayTableView.reloadData()
            self.tuesdayTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }

        mondayTableView.delegate = self
        mondayTableView.dataSource = self
        mondayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tuesdayTableView.delegate = self
        tuesdayTableView.dataSource = self
        tuesdayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        
        var count:Int?
                
        if tableView == self.mondayTableView {
            count = schedule?.monday.count
        }
        
        if tableView == self.tuesdayTableView {
            count =  schedule?.tuesday.count
        }
        
        return count!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.mondayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
            let mondayScheduleDetail = schedule?.monday[indexPath.row]
            cell!.textLabel!.text = mondayScheduleDetail?.name
            cell!.imageView!.image = UIImage(contentsOfFile: "placeholderImage")
            
        }
        
        if tableView == self.tuesdayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath as IndexPath)
            let tuesdayScheduleDetail = schedule?.tuesday[indexPath.row]
            cell!.textLabel!.text = tuesdayScheduleDetail?.name
            cell!.imageView!.image = UIImage(contentsOfFile: "placeholderImage")
            
        }
        
        return cell!
    }

    func downloadSchedule(completed: @escaping () -> Void) {
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        let session = URLSession.shared
        let url = URL(string: "https://api.radio-rasclat.com/meta/schedule")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print(error!)
                self.activityIndicator.stopAnimating()
                return
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(Schedule.self, from: data!)
                
                print(json)
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
            
        })
        task.resume()
    }
}