//
//  EventsViewController.swift
//  OurPlanet
//
//  Created by Matheus on 27/09/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import RxSwift

class EventsViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var daysLabel: UILabel!
    
    let events = Variable<[EOEvent]>([])
    
    let days = Variable<Int>(360)
    let filteredEvents = Variable<[EOEvent]>([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    @IBAction func sliderAction(slider: UISlider) {
    }
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        return cell
    }
}

