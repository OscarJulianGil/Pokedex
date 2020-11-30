//
//  PokemonDetailController.swift
//  Pokedex
//
//  Created by Oscar Julian on 29/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class PokemonDetailController: ParentController {

    
    @IBOutlet var pokemonimage: UIImageView!
    @IBOutlet var mainview: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var labelnamepokemon: UILabel!
    @IBOutlet var labelDescription: UILabel!
    
    @IBAction func backclick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pokemon = PokemonBLL()
    var pokemonSelected : Pokemon?
    
    override func viewDidLoad() {
       super.viewDidLoad()

        mainview.clipsToBounds = true
        mainview.layer.cornerRadius = 40
        mainview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        if let item = pokemonSelected{
            let url = URL(string: item.detail.front_shiny)
            pokemonimage.load(url: url!)
            labelnamepokemon.text = item.name
            loadSpecie(name: item.name)
        }
        setupSegmentController()
       //self.navigationItem.hidesBackButton = false
    }
    
    
    ///Carga la descripcion del pokemon
    func loadSpecie(name: String){
        
        pokemon.getSpecieByName (name: name, handler: { (data, responseMessage, success) -> Void in
            // When api request completes,control flow goes here.
            Util.stopSpinner()
            if success {
                if let infopokemon = data{
                    self.labelDescription.text =  infopokemon.description
                }
            } else {
                self.showUserMessage(usermessage: responseMessage)
            }
        })
    }
    
    //PreCarga los controladores que se usan con el SegmentController
    lazy var StatViewController: StatController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var controller = storyboard.instantiateViewController(identifier: "StatController") as! StatController
        controller.pokemonSelected = pokemonSelected
        self.addViewControllerAsChildViewController(childViewController : controller)
        return controller
    }()
    
    lazy var EvolutionController: EvolutionController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var controller = storyboard.instantiateViewController(identifier: "EvolutionController") as! EvolutionController
        controller.pokemonSelected = pokemonSelected
        self.addViewControllerAsChildViewController(childViewController : controller)
        return controller
    }()
    
    private func setupSegmentController(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Stat", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Type(s)", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        StatViewController.view.isHidden = false
        EvolutionController.view.isHidden = true
    }
    
    
    @objc func selectionDidChange(sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            print("hola")
            StatViewController.view.isHidden = false
            EvolutionController.view.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1{
            StatViewController.view.isHidden = true
            EvolutionController.view.isHidden = false
        }
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController){
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        
        childViewController.didMove(toParent: self)
    }
}


