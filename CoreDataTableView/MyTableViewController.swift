//
//  MyTableViewController.swift
//  CoreDataTableView
//
//  Created by Menat Pinesh I. on 4/4/18.
//  Copyright © 2018 Menat Pinesh I. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    var products : Array<Product> = []

    @IBAction func addTapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = products[indexPath.row].name
        cell?.detailTextLabel?.text = String(products[indexPath.row].price)
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        destinationVC.selectedRowIndex = selectedRowIndex
    }
    var selectedRowIndex = -1
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
    }
}
