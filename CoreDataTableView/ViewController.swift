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
        //products.append(ProductType(pId: id,pName: name,pPrice: price))
        
        
        //Save the new item in the SQLite DB
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let newProduct = Product(context: context)
        newProduct.id = id
        newProduct.name = name
        newProduct.price = price
        delegate.saveContext()
        loadData()
        tableView.reloadData()
    }
    
    func loadData() {
    //Load Data
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.persistentContainer.viewContext
    do {
    products = try context.fetch(Product.fetchRequest())
    } catch {
    
    }
    }
    
    var products : Array<Product> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load data
        loadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = products[indexPath.row].name
        cell?.detailTextLabel?.text = String(products[indexPath.row].price)
        return cell!
    }

}
