//
//  DetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Tanya Burke on 12/7/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
  
    
     var song:Song?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        songName.text = song?.name
        artistName.text = song?.artist
        imageView.image = UIImage(named: "loveSongs")
    }
    

    

   

}
