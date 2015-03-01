//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    // tappedImage converts from UIImage to UIImageView.
    // This is a crucial step to get the frame.
    
    var tappedImageView: UIImageView!
    var transferImageView: UIImageView!
    
    var startFrame: CGRect!
    var endFrame: CGRect!
    
    
    // We need a start image for location
//    var startImage = tappedImageView.frame
    
    // Track: VC presented vs. dismissed
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    // Transition Delegate Method 1
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    // Transition Delegate Method 2
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    // Control the Transition
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    // Animate & Complete the Transition
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        // Add the Transition Image & Fit the Frame to the Tapped Image
        // We replace this line with the startFrame method
   
        transferImageView = UIImageView(frame: tappedImageView.frame)
        transferImageView.image = tappedImageView.image
        transferImageView.contentMode = tappedImageView.contentMode
        transferImageView.clipsToBounds = tappedImageView.clipsToBounds
        
        // Pinpoint the exact image locations
        var frame = containerView.convertRect(tappedImageView.frame, fromView: scrollView)
        transferImageView.frame = frame

        
        // Get the Key Window
        var window = UIApplication.sharedApplication().keyWindow!

        // Add a View to the Window
        window.addSubview(transferImageView)
       
        // Animate to the Photo View Controller
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            // Get to the Final Frame
            var photoViewController = toViewController as PhotoViewController
            // Hide Image
//
            //photoViewController.imageView.hidden = true
            var finalImageView = photoViewController.imageView
            photoViewController.imageView.hidden = true
            
//            // End Position Image
//            var endFrame = CGRect(x: 0, y: (photoViewController.imageView.frame.height - tappedImageView.frame.height)/2, width: 320, height: (tappedImageView.frame.height*320)/tappedImageView.frame.width)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                // Show the transfer image
                toViewController.view.alpha = 1
                // Hide the imageView
                
                // Set the Final Frame
                self.transferImageView.frame = self.endFrame // finalImageView.frame // Recalculation
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    // Remove the Transfer Image
                    photoViewController.imageView.hidden = false
                    self.transferImageView.removeFromSuperview()
//                    self.transferImageView.alpha = 0
                    // show the imageView
                    
                    
        // Animate back to the Thumbnail
            }
        } else {
           
            // Make a copy of the opened image view and match sizes
            var photoVC = fromViewController as PhotoViewController
            //transferImageView = UIImageView(image: photoVC.imageView.image)
            
            // Match the settings like above
            //transferImageView.contentMode = photoVC.imageView.contentMode
            //transferImageView.clipsToBounds = photoVC.imageView.clipsToBounds
            transferImageView.frame = photoVC.imageView.frame
            
            
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                self.transferImageView.frame = frame
                self.transferImageView.alpha = 0
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    
                    self.transferImageView.removeFromSuperview()
                    fromViewController.view.removeFromSuperview()
                    
            }
        }
    }
    
    
    // Hijack the segue
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        // Method to pass data and cast
        var destinationViewController = segue.destinationViewController as PhotoViewController
        // Passing the image
        destinationViewController.passedImage = tappedImageView.image
        // Setting up a custom transition
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
        var window = UIApplication.sharedApplication().keyWindow!
        startFrame = window.convertRect(tappedImageView.frame, fromView: scrollView)
        
        // Here we use image!.size instead of frame to get the actual size.
        var height = (tappedImageView.image!.size.height*320)/tappedImageView.image!.size.width
        endFrame = CGRect(x: 0, y: (view.frame.size.height - height)/2, width: 320, height: height)
        
        destinationViewController.endFrame = endFrame

    }
    
    // Git test comment
    // Test 2
    
    @IBAction func tapThumbnail(sender: UITapGestureRecognizer) {
        var imageView = sender.view as UIImageView
        tappedImageView = imageView
        performSegueWithIdentifier("imageDetailSegue", sender: self)
        println("hi hi")
    }
    
}
