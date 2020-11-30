//
//  ParentController.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import UIKit

class ParentController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    func setGradientBackground() {
       let colorTop =   UIColor(hexString: "#DEECFA").cgColor
       let colormiddle = UIColor(hexString: "#E1F4E9").cgColor
       let colorBottom = UIColor(hexString: "#DDF5DB").cgColor
                   
       let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [colorTop,colormiddle, colorBottom]
       gradientLayer.locations = [0.0,1.1, 1.0]
       gradientLayer.frame = self.view.bounds
               
       self.view.layer.insertSublayer(gradientLayer, at:0)
   }
    
    
    func showUserMessage(usermessage : String){
        let alert = UIAlertController(title: "Pokedex", message: usermessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    }

}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
