//
//  PhotoViewController.swift
//  Facebook
//
//  Created by dt on 2/26/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var passedImage: UIImage!
    var endFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = passedImage
    
        imageView.frame = endFrame
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    
    }

}
