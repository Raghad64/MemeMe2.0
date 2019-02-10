//
//  SentMemesCollectionViewVC.swift
//  MemeMe2.0
//
//  Created by Raghad Mah on 03/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

private let identifier = "CustomCollectionViewCell"

class SentMemesCollectionViewVC: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes : [Meme] {
        let object = UIApplication.shared.delegate as! AppDelegate
        return object.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat
        let dimension: CGFloat
        
        if UIDeviceOrientation.portrait.isPortrait{
            space = 3.0
            dimension = (view.frame.size.width - (2 * space)) / 3
        } else {
            space = 1.0
            dimension = (view.frame.size.width - (1 * space)) / 5
        }
        flowLayout.minimumInteritemSpacing = space
        
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CustomCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailsViewController()
        detailController.imageView.image = memes[indexPath.row].memedImage
        navigationController?.pushViewController(detailController, animated: true)
    }
}
