//
//  Util.swift
//  Pokedex
//
//  Created by Oscar Julian on 27/11/20.
//  Copyright © 2020 Oscar Julian Gil Bernal. All rights reserved.
//

import Foundation
import UIKit

class Util{
   static var WEB_SERVER_URL : String = "https://pokeapi.co/api/v2/";
    
 internal static var spinner: UIActivityIndicatorView?
    // utility function to show a spinner for long tasks
    static func showSpinner() {
        let style: UIActivityIndicatorView.Style = .whiteLarge
        let backColor = UIColor.black.withAlphaComponent(0.5)
        let baseColor = UIColor.black
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    // utility function to stop the spinner
    static func stopSpinner() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
}
