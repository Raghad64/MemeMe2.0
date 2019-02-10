//
//  SentMemesTableVC.swift
//  MemeMe2.0
//
//  Created by Raghad Mah on 03/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class SentMemesTableVC: UITableViewController {

    var memes : [Meme] {
        let object = UIApplication.shared.delegate as! AppDelegate
        return object.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesTableCell", for: indexPath) as! CustomTableViewCell
        
        let meme = self.memes[indexPath.row]
        cell.fillCell(meme: meme)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailsViewController()
        detailViewController.imageView.image = memes[indexPath.row].memedImage
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}
