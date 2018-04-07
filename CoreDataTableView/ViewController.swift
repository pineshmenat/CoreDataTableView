//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by Menat Pinesh I. on 3/28/18.
//  Copyright © 2018 Menat Pinesh I. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var selectedRowIndex = -2
    var products : Array<Product> = []
    
    @IBOutlet weak var productPriceTV: UITextField!
    
    @IBOutlet weak var productNameTV: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func saveTapped(_ sender: Any) {
        //print(selectedRowIndex)
        if(selectedRowIndex <= -1) {
            //to create new record
            let name = productNameTV.text ?? "New Product"
            
            let price : Double!
            let priceInput = productPriceTV.text ?? "0.0"
            if(priceInput == ""){
                price = 0.0
            } else {
                price = Double(priceInput)!
            }
            
            let id = UUID.init()
            
            productNameTV.text = ""
            productPriceTV.text = ""
            saveToSQLiteDB(id: id, name: name, price: price)
            //pop from stack to go back
            navigationController?.popViewController(animated: true)
        } else if(selectedRowIndex > -1) {
            let eId = products[selectedRowIndex].id
            let eName = productNameTV.text
            let ePrice : Double!
            let epriceInput = productPriceTV.text ?? "0.0"
            
            if(epriceInput == ""){
                ePrice = 0.0
            } else {
                ePrice = Double(epriceInput)!
            }
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Product")
            do {
                let results = try context.fetch(request)
                if(results.count > 0) {
                    for result in results as! [NSManagedObject]
                    {
                        if let uid = result.value(forKey: "id") as? UUID
                        {
                            if uid == eId {
                                result.setValue(eName, forKey: "name")
                                result.setValue(ePrice, forKey: "price")
                                do {
                                    try context.save()
                                    loadData()
                                } catch{
                                    
                                }
                            }
                        }
                    }
                }
            } catch {
                
            }
            

            loadData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func saveToSQLiteDB(id: UUID, name: String, price: Double) {
        //Save the new item in the SQLite DB
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let newProduct = Product(context: context)
        newProduct.id = id
        newProduct.name = name
        newProduct.price = price
        delegate.saveContext()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRowIndex)
        if(selectedRowIndex > -1) {
            loadData()
            productNameTV?.text = products[selectedRowIndex].name
            productPriceTV?.text = String(products[selectedRowIndex].price)
        }
    }
}
