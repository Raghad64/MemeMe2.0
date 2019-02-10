//
//  CustomTableViewCell.swift
//  MemeMe2.0
//
//  Created by Raghad Mah on 08/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    func fillCell(meme: Meme) {
        memeLabel.text = meme.topText
        memeImageView.image = meme.memedImage
    }
}
