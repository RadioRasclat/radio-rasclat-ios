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
    @IBOutlet weak var wednesdayTableView: UITableView!
    @IBOutlet weak var thursdayTableView: UITableView!
    @IBOutlet weak var fridayTableView: UITableView!
    @IBOutlet weak var saturdayTableView: UITableView!
    @IBOutlet weak var sundayTableView: UITableView!
    
    var schedule: Schedule?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mondayTableView.delegate = self
        mondayTableView.dataSource = self
        mondayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "mondayCells")
        
        tuesdayTableView.delegate = self
        tuesdayTableView.dataSource = self
        tuesdayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tuesdayCells")
        
        wednesdayTableView.delegate = self
        wednesdayTableView.dataSource = self
        wednesdayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "wednesdayCells")
        
        thursdayTableView.delegate = self
        thursdayTableView.dataSource = self
        thursdayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "thursdayCells")
        
        fridayTableView.delegate = self
        fridayTableView.dataSource = self
        fridayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "fridayCells")
        
        saturdayTableView.delegate = self
        saturdayTableView.dataSource = self
        saturdayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "saturdayCells")
        
        sundayTableView.delegate = self
        sundayTableView.dataSource = self
        sundayTableView.register(UITableViewCell.self, forCellReuseIdentifier: "sundayCells")
        
        downloadSchedule {
            self.mondayTableView.reloadData()
            self.tuesdayTableView.reloadData()
            self.wednesdayTableView.reloadData()
            self.thursdayTableView.reloadData()
            self.fridayTableView.reloadData()
            self.saturdayTableView.reloadData()
            self.sundayTableView.reloadData()
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.

        guard let schedule = schedule else { return 0 }

        var count:Int = 0

        if tableView == self.mondayTableView {
            count = schedule.monday.count
        }

        if tableView == self.tuesdayTableView {
            count = schedule.tuesday.count
        }
        
        if tableView == self.wednesdayTableView {
            count = schedule.wednesday.count
        }
        
        if tableView == self.thursdayTableView {
            count = schedule.thursday.count
        }
        
        if tableView == self.fridayTableView {
            count = schedule.friday.count
        }
        
        if tableView == self.saturdayTableView {
            count = schedule.saturday.count
        }
        
        if tableView == self.sundayTableView {
            count = schedule.sunday.count
        }

        return count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:UITableViewCell?
        
        if tableView == self.mondayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "mondayCells", for: indexPath as IndexPath)
            let mondayScheduleDetail = schedule?.monday[indexPath.row]
            cell!.textLabel!.text = mondayScheduleDetail?.name
        }

        if tableView == self.tuesdayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "tuesdayCells", for: indexPath as IndexPath)
            let tuesdayScheduleDetail = schedule?.tuesday[indexPath.row]
            cell!.textLabel!.text = tuesdayScheduleDetail?.name
        }
        
        if tableView == self.wednesdayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "wednesdayCells", for: indexPath as IndexPath)
            let wednesdayScheduleDetail = schedule?.wednesday[indexPath.row]
            cell!.textLabel!.text = wednesdayScheduleDetail?.name
        }
        
        if tableView == self.thursdayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "thursdayCells", for: indexPath as IndexPath)
            let thursdayScheduleDetail = schedule?.thursday[indexPath.row]
            cell!.textLabel!.text = thursdayScheduleDetail?.name
        }
        
        if tableView == self.fridayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "fridayCells", for: indexPath as IndexPath)
            let fridayScheduleDetail = schedule?.friday[indexPath.row]
            cell!.textLabel!.text = fridayScheduleDetail?.name
        }
        
        if tableView == self.saturdayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "saturdayCells", for: indexPath as IndexPath)
            let saturdayScheduleDetail = schedule?.saturday[indexPath.row]
            cell!.textLabel!.text = saturdayScheduleDetail?.name
        }
        
        if tableView == self.sundayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "sundayCells", for: indexPath as IndexPath)
            let sundayScheduleDetail = schedule?.sunday[indexPath.row]
            cell!.textLabel!.text = sundayScheduleDetail?.name
        }

        return cell!
    }

    func downloadSchedule(completed: @escaping () -> Void) {
        let url = URL(string: "https://api.radio-rasclat.com/meta/schedule")

        URLSession.shared.dataTask(with: url!) { data, _, error in
            if error == nil,
                let data = data {
                do {
                    self.schedule = try JSONDecoder().decode(Schedule.self, from: data)
                } catch {
                    print("JSON Error")
                }
            }
            DispatchQueue.main.async {
                completed()
            }
        }.resume()
    }
}
