//
//  CategoriesViewController.swift
//  OurPlanet
//
//  Created by Matheus on 27/09/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let categories = Variable<[EOCategory]>([])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe (onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
        .disposed(by: disposeBag)
        startDownload()
    }
    
    func startDownload() {
        let eoCategories = EONET.categories
        let downloadedEvents = EONET.events(forLast: 360)
        
        let updatedCategories = Observable.combineLatest(eoCategories, downloadedEvents) { categories, events -> [EOCategory] in
            categories.map { category in
                var cat = category
                cat.events = events.filter { $0.categories.contains(category.id) }
                return cat
            }
        }
        eoCategories
            .concat(updatedCategories)
            .bind(to: categories)
            .disposed(by: disposeBag)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        let category = categories.value[indexPath.row]
        cell.textLabel?.text = "\(category.name) \(category.events.count)"
        cell.accessoryType = category.events.count > 0 ? .disclosureIndicator : .none
        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
