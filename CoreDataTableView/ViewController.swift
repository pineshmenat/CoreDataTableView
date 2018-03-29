//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by Menat Pinesh I. on 3/28/18.
//  Copyright © 2018 Menat Pinesh I. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var productPriceTV: UITextField!
    
    @IBOutlet weak var productNameTV: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTapped(_ sender: Any) {
        let name = productNameTV.text ?? "New Product"
        let price = Double(productPriceTV.text ?? "0.0")!
        let id = UUID.init()
        products.append(ProductType(pId: id,pName: name,pPrice: price))
        tableView.reloadData()
    }
    
    var products : Array<ProductType> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = products[indexPath.row].getName()
        cell?.detailTextLabel?.text = String(products[indexPath.row].getPrice())
        return cell!
    }

}

