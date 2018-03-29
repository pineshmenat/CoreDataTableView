//
//  ProductType.swift
//  CoreDataTableView
//
//  Created by Menat Pinesh I. on 3/28/18.
//  Copyright © 2018 Menat Pinesh I. All rights reserved.
//

import Foundation


public class ProductType{
    var id : UUID!
    var name : String!
    var price : Double!
    
    init(pId:UUID, pName:String, pPrice:Double) {
        id = pId
        name = pName
        price = pPrice
    }
    
    func getId() -> UUID {
        return id;
    }
    
    func getName() -> String {
        return name;
    }
    
    func getPrice() -> Double {
        return price;
    }
}
