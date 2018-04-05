//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by Menat Pinesh I. on 3/28/18.
//  Copyright © 2018 Menat Pinesh I. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedRowIndex = -2
    @IBOutlet weak var productPriceTV: UITextField!
    
    @IBOutlet weak var productNameTV: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func saveTapped(_ sender: Any) {
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
        //products.append(ProductType(pId: id,pName: name,pPrice: price))
        
        
        //Save the new item in the SQLite DB
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let newProduct = Product(context: context)
        newProduct.id = id
        newProduct.name = name
        newProduct.price = price
        delegate.saveContext()
        //pop from stack to go back
        navigationController?.popViewController(animated: true)
        
    }
    
    var products : Array<Product> = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
