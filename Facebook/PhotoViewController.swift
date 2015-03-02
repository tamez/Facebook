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
    
    // ...Declare the Passed Image
    var passedImage: UIImage!
    
    // ...Declare the Passed Frame
    var endFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Receive the Passed Image
        imageView.image = passedImage
    
        // Receive the Passed Frame
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
