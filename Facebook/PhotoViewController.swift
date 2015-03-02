//
//  PhotoViewController.swift
//  Facebook
//
//  Created by dt on 2/26/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var likeBar: UIImageView!
    @IBOutlet weak var doneButtonImage: UIImageView!
    @IBOutlet weak var blackBgView: UIView!
    
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
        
        // Set Scroll View Delegate
        scrollView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Hack the Fade Away
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(scrollView.contentOffset.y)
        var offset = scrollView.contentOffset.y
        doneButtonImage.alpha = 1 + (offset/50)
        likeBar.alpha = 1 + (offset/50)
        blackBgView.alpha = 1 + (offset/150)
    }
    
    
    // Dismiss on Scroll Release
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y > 50 || scrollView.contentOffset.y < -50) {
            self.imageView.hidden = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
