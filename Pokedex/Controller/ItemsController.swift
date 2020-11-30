//
//  ItemsController.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class ItemsController: ParentController {

    @IBOutlet var table: UITableView!
    
    var itemBusiness = ItemBLL()
    var info = [Item]()
    
    override func viewDidLoad() {
       super.viewDidLoad()
       table.delegate = self
       table.dataSource = self
       table.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
       Util.showSpinner()
       itemBusiness.getAll (handler: { (data, responseMessage, success) -> Void in
           // When api request completes,control flow goes here.
           Util.stopSpinner()
           if success {
               if let infopokemon = data{
                   self.loaddetail(data : infopokemon)
                   
               }
           } else {
               print("error")
           }
       })
    }
  
    func loaddetail(data : [Item] ){
        for item in data{
            itemBusiness.getdetail (url : item.url, handler: { (data, responseMessage, success) -> Void in
                // When api request completes,control flow goes here.
                Util.stopSpinner()
                if success {
                    self.info.append(Item(name: item.name, url: item.url, detail : data!))
                    self.table.reloadData()
                } else {
                    print("error")
                }
            })
        }
      
    }
}


extension ItemsController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for : indexPath)
        as! ItemCell
        
        cell.itemname.text = self.info[indexPath.row].name
        cell.itemprice.text = "$ \(self.info[indexPath.row].detail.cost)"
        let url = URL(string: self.info[indexPath.row].detail.image)
   
        cell.itemimage.load(url: url!)
        return cell
    }
    
}

extension ItemsController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

