//
//  BroadcastListViewController.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 11.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import UIKit

class BroadcastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var broadcasts = [Broadcasts]()

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadJSON {
            self.tableView.reloadData()
        }

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return broadcasts.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = broadcasts[indexPath.row].title
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: "showBroadcastDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let destination = segue.destination as? BroadcastDetailViewController {
            destination.broadcast = broadcasts[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    func downloadJSON(completed: @escaping () -> Void) {
        let url = URL(string: "https://api.radio-rasclat.com/recordings")

        URLSession.shared.dataTask(with: url!) { data, _, error in
            if error == nil {
                do {
                    self.broadcasts = try JSONDecoder().decode([Broadcasts].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }

        }.resume()
    }
}
