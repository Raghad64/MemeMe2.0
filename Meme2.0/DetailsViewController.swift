//
//  DetailsViewController.swift
//  MemeMe2.0
//
//  Created by Raghad Mah on 08/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var meme: Meme!
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        // MARK: Setting up imageView constraints
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
}
