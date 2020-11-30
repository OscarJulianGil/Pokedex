//
//  MovesController.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class MovesController: ParentController {

    
    @IBOutlet var table: UITableView!
    var move = MoveBLL()
    var info = [Move]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "MoveCell", bundle: nil), forCellReuseIdentifier: "MoveCell")
        Util.showSpinner()
        move.getAll (handler: { (data, responseMessage, success) -> Void in
            // When api request completes,control flow goes here.
            Util.stopSpinner()
            if success {
                self.info.append(contentsOf: data!)
                self.table.reloadData()
            } else {
                print("error")
            }
        })
        // Do any additional setup after loading the view.
    }
}


extension MovesController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for : indexPath)
        as! MoveCell
        
        cell.movename.text = self.info[indexPath.row].name
        
        return cell
    }
    
}

extension MovesController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
