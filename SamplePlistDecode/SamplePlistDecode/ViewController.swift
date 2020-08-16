//
//  ViewController.swift
//  SamplePlistDecode
//
//  Created by KENJI WADA on 2020/08/16.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

struct ItemData: Decodable {
    let name: String
    let imageName: String
}

struct ItemGroup: Decodable {
    let sectionTitle: String
    let items: [ItemData]
}

class ViewController: UITableViewController {

    var items: [ItemGroup] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.path(forResource: "Items", ofType:"plist" ) {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            items = try! PropertyListDecoder().decode([ItemGroup].self, from: data)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(named: item.imageName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section].items[indexPath.row]

        print("item: \(item.name)")
    }
}
